var webpack = require('webpack');
module.exports = {
  entry: ['./app_client/index.js'],
  output: {
    path: './public',
    filename: 'bundle.js'
  },
  module: {
    loaders: [
      { test: /\.css$/, loader: 'style!css' },
      {
        test: /\.jsx?$/, 
        loader: 'babel-loader',
        exclude: /node_modules/
      },
      {
        test: /\.(jpe?g|png|gif|svg)$/i,
        loaders: [
          'file?hash=sha512&digest=hex&name=[hash].[ext]',
          'image-webpack?bypassOnDebug&optimizationLevel=7&interlaced=false'
        ]
      }
    ]
  },

  devServer: {
    historyApiFallback: true
  },

  plugins: [
    new webpack.DefinePlugin({
      REGISTRATION_PATH: JSON.stringify("/register_with_email_pwd"),
      LOGIN_PATH: JSON.stringify("/login_with_email_pwd")
    })
  ]
};
