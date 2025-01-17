var autoPrefixer = require('autoprefixer-core')
var HtmlWebpackPlugin = require('html-webpack-plugin')

module.exports = {
  entry: './main',
  output: {
    path: __dirname + '/build/',
    filename: 'app.js',
      // cssFilename: 'app.css',
      hash: true,
      // publicPath: '/'
  },
  resolve: {
    // we can leave off file extensions for js-like sources:
    // still need to transform them with a loader!
    'extensions': [
      // (node.js) defaults:
     '', // need to leave this…
     '.js',
     '.json',
      //  extra:
     '.coffee',
     '.jsx',
     '.cjsx'
    ]
  },
  // how to `require()` things:
  module: {
    // how to transform non-js sources:
    loaders: [
      // CSS will be injected into the HTML:
      { test: /\.css$/, loader: 'style!css' },
      // less will be transformed, than handled like CSS:
      { test: /\.less$/, loader: 'style!css!less' },
      // plain files: url-encode if small enough or passthrough
      {
        test: /\.(otf|eot|svg|ttf|woff)/,
        loader: 'url-loader?limit=10000'
      },
      {
        test: /\.(jpe?g|png|gif)/,
        loader: 'url-loader?limit=10000'
      },

      // js dialects are just transformed:
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        loaders: [
          'babel-loader'
        ]
      },
      {
        test: /\.coffee$/,
        loader: 'coffee-loader'
      },
      {
        test: /\.cjsx$/,
        loader: 'coffee-jsx-loader'
      }
    ]
  },

  postcss: [autoPrefixer()],

  plugins: [
    // generate a simple index.html referencing all entries
    new HtmlWebpackPlugin({
      title: 'JSON-ROA Browser',
      template: 'node_modules/html-webpack-template/index.html',
      mobile: true,
      // devServer: 8080,
      // appMountId: 'app',
      // window: {
      //   env: {
      //     apiHost: 'http://example.com/api/v1'
      //   }
      // }
    })
  ]
}
