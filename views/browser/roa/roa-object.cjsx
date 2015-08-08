React = require('react')
Button = require('react-bootstrap/lib/Button')
ButtonGroup = require('react-bootstrap/lib/ButtonGroup')
ListGroup = require('react-bootstrap/lib/ListGroup')
ListGroupItem = require('react-bootstrap/lib/ListGroupItem')
ampersandReactMixin = require 'ampersand-react-mixin'
f = require('../../../lib/fun')

module.exports = React.createClass
  displayName: 'RoaObject'
  mixins: [ampersandReactMixin]

  render: ()->
    roa = @props.roaObject

    <div className='app--browser--roa-object panel panel-info'>
      <div className='panel-heading'>
        <h3>ROA Object</h3>
      </div>

      <ListGroup>
        <RoaSelfRelation selfRelation={roa.get('self-relation')}/>
        <RoaCollection collection={roa.get('collection')}/>
        <RoaRelations relations={roa.get('relations')}/>
      </ListGroup>

    </div>

RoaSelfRelation = React.createClass
  render: ()->
    return null unless (selfRelation = @props.selfRelation)?
    <ListGroupItem header='Self'>
      <RoaRelationList relations={[selfRelation]}/>
    </ListGroupItem>

RoaCollection = React.createClass
  render: ()->
    collection = @props.collection
    return null unless collection?.length > 1

    <ListGroupItem header='Collection'>
      [next link]
      <RoaRelationList relations={collection.relations}/>
    </ListGroupItem>

RoaRelations = React.createClass
  render: ()->
    return null unless (relations = @props.relations)?
    <ListGroupItem header='Relations'>
      <RoaRelationList relations={relations}/>
    </ListGroupItem>

# partials

RoaRelationList = React.createClass
  render: ()->
    relationList = @props.relations
    return null unless relationList?.length > 0
    <div className='table-responsive'>
      <table className='table table-striped table-condensed'><thead></thead>
        <tbody>
          {relationList.map (relation)->
            <RoaRelationListItem relation={relation} key={relation.getId()}/>
          }
        </tbody>
      </table>
    </div>

RoaRelationListItem = React.createClass
  render: ()->
    {relation} = @props

    <tr className='relation-row'>
      {false && <td className='rel-name col-sm-2'>
        <samp><strong><small>{relation.keyName}</small></strong></samp></td>}
      <td className='title col-sm-2'>
        {relation.title}</td>
      <td className='meta-relations col-sm-4'>
        <ul className='list-inline list-unstyled'>
          {relation.relations.map (metaRel)->
            <li key={metaRel.getId()}>
              <a href={metaRel.href}>
                <i className='fa fa-link fa-rotate-90'/>{metaRel.title}</a>
            </li>
          }
        </ul>
      </td>
      <td className='methods col-sm-3'>
        <MethodButtons methods={relation.methods}/></td>
    </tr>

MethodButtons = React.createClass
  render: ()->
    styleMap =
      get: 'success'
      post: 'primary'
      put: 'info'
      patch: 'info'
      delete: 'danger'

    # sort methods like the order defined in styleMap (extra keys at the end)
    methods = f(@props.methods).sortKeysLike(f.keys(styleMap))

    <ButtonGroup bsSize='xs'>
      {f.map methods, (_o, m)->
        # hack: disable non-GET for now:
        disabled = not (m is 'get')

        <Button bsStyle={styleMap[m] or 'warning'} key={m} disabled={disabled}>
          <samp>{m.toUpperCase()}</samp>
        </Button>
      }
    </ButtonGroup>
