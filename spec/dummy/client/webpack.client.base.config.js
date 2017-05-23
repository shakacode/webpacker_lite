/* eslint global-require: 0 */
/* eslint import/no-dynamic-require: 0 */

const webpack = require('webpack');
const { resolve } = require('path');
const ManifestPlugin = require('webpack-manifest-plugin');
const { env, paths, publicPath } = require('./webpackConfigLoader.js');

module.exports = {

  context: resolve(__dirname),

  entry: {
    vendor: [
      'es5-shim/es5-shim',
      'es5-shim/es5-sham',
      'babel-polyfill',
      'bootstrap-loader/extractStyles'
    ],

    app: [
      './app/bundles/HelloWorld/startup/registration',
    ],
  },

  output: {
    filename: '[name]-bundle-[chunkhash].js',
    path: resolve('..', paths.output, paths.assets),
    pathinfo: true,
  },

  module: {
    rules: [
      {
        test: /\.(jpeg|png|gif|svg|eot|ttf|woff|woff2)$/i,
        use: [{
          loader: 'file-loader',
          options: {
            publicPath,
            name: '[name]-[hash].[ext]',
          },
        }],
      },
      {
        test: /\.(js|jsx)?(\.erb)?$/,
        exclude: /node_modules/,
        use: 'babel-loader',
      },
      {
        test: /\.erb$/,
        enforce: 'pre',
        exclude: /node_modules/,
        loader: 'rails-erb-loader',
        options: {
          runner: 'DISABLE_SPRING=1 bin/rails runner',
        },
      },
    ],
  },

  plugins: [
    new webpack.EnvironmentPlugin(JSON.parse(JSON.stringify(env))),
    new ManifestPlugin({ fileName: paths.manifest, publicPath, writeToFileEmit: true }),
  ],

  resolve: {
    extensions: ['.js', '.jsx'],
    modules: [
      paths.source,
      paths.node_modules,
    ],
  },

  resolveLoader: {
    modules: [paths.node_modules],
  },
};
