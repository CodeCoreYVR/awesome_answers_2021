// Here, the default webpack configuration is imported via @rails/webpacker
// if you want to see the entire webpack config object run:
// 
const { environment } = require("@rails/webpacker");

const webpack = require("webpack");
// Add 'const jQuery = require('jquery') to legacy jQuery plugins and
// const popper = require('popper')
// and also set window.$ = require('jquery')
environment.plugins.append(
  "Provide",
  new webpack.ProvidePlugin({
    $: "jquery",
    jQuery: "jquery",
    Popper: ["popper.js", "default"],
  })
);

module.exports = environment;
