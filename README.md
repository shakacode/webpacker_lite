# Webpacker Lite
![Gem Version](https://badge.fury.io/rb/webpacker_lite.svg)

Webpacker Lite provides the webpack enabled asset helpers from [Webpacker](https://github.com/rails/webpacker).
[React on Rails](https://github.com/shakacode/react_on_rails) version 8 and greater defaults to using Webpacker Lite. 

# NEWS
 
* 2017-05-03: React on Rails 8.0.0 beta defaults to using webpacker_lite.

## Prerequisites

* Ruby 2+
* Rails 4.2+

## Installation

WebpackerLite is currently compatible with Rails 4.2+.

The best way to see the installation of webpacker_lite is to use the generator for React on Rails 8.0.0 or greater.

## Overview

1. Configure the location of your Webpack output in the `config/webpack/paths.yml` file.
   `webpack_ouput: public/assets/webpack` is the default.
2. Configure your Webpack scripts to:
   1. Use the manifest plugin to generate a manifest
   2. Write output to the directory that you configured in your paths.yml file.
3. Use the asset helpers on your layouts to provide the webpack generated files:
   ```erb
   <%# app/views/layouts/application.html.erb %>
   <%= javascript_pack_tag('main') %>
   <%= stylesheet_pack_tag('main') %>
   ```
4. If you only want the `stylesheet_pack_tag` to be used for non-hot-reloading, pass the value of the file name in a named parameter called "static", like this:
   ```erb
   <%= stylesheet_pack_tag(static: 'main') %>
   ```

Note, you can specify singlar file names or arrays for these asset helpers, even when using the `static` named parameter.

## Rake Tasks

### Examples

To see available webpacker_lite rake tasks:

```
rake webpacker_lite
```

If you are using different directories for the output paths per RAILS_ENV, this is how you'd delete the files created for tests: 
```
RAILS_ENV=test rake webpacker_lite:clobber
```

## Hot Reloading Config   
You can also control and configure `webpack-dev-server` settings from

`config/webpack/development.server.yml` file

```yml
# config/webpack/development.server.yml
enabled: true
host: localhost
port: 8080
```

## Getting asset path

The `asset_pack_path` helper provides the path of any given asset that's been compiled by webpack.

For example, if you want to create a `<link rel="prefetch">` or `<img />`
for an asset used in your pack code you can reference them like this in your view,

```erb
<img src="<%= asset_pack_path 'calendar.png' %>" />
<% # => <img src="/packs/calendar.png" /> %>
```

## Example for Development vs Hot Reloading vs Production Mode
```html
  <!-- In development mode with webpack-dev-server -->
  <script src="http://localhost:8080/main.js"></script>
  <link rel="stylesheet" media="screen" href="http://localhost:8080/main.css">
  <!-- In development mode -->
  <script src="/packs/main.js"></script>
  <link rel="stylesheet" media="screen" href="/packs/main.css">
  <!-- In production mode -->
  <script src="/packs/main-0bd141f6d9360cf4a7f5.js"></script>
  <link rel="stylesheet" media="screen" href="/packs/main-dc02976b5f94b507e3b6.css">
```

## License
Webpacker is released under the [MIT License](https://opensource.org/licenses/MIT).
