# Webpacker Lite
![Gem Version](https://badge.fury.io/rb/webpacker_lite.svg)

Webpacker Lite provides the webpack enabled asset helpers from [Webpacker](https://github.com/rails/webpacker).
[React on Rails](https://github.com/shakacode/react_on_rails) version 8 and greater defaults to using Webpacker Lite.

If you like this project, show your support by giving us a star!

# NEWS
 
* 2017-05-03: React on Rails 8.0.0 beta defaults to using webpacker_lite.

## Prerequisites

* Ruby 2+
* Rails 4.2+

## Installation

Webpacker Lite is currently compatible with Rails 4.2+.

The best way to see the installation of webpacker_lite is to use the generator for React on Rails 8.0.0 or greater.

## Overview

1. Configure the location of your Webpack output in the `config/webpack/paths.yml` file.
   `webpack_ouput: public/assets/webpack` is the default.
2. Configure your Webpack scripts to:
   1. Use the [webpack-manifest-plugin](https://www.npmjs.com/package/webpack-manifest-plugin) to generate a manifest
   2. Write output to the directory that you configured in your `/config/webpack/paths.yml` file, taking into account both the `output` and `assets` values.
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

For more details on the helper documentation, see [lib/webpacker_lite/helper.rb](lib/webpacker_lite/helper.rb).

## Confirguration
Webpacker Lite takes 2 configuration file, `config/webpack/paths.yml` and `config/webpack/development.server.yml`

### `config/webpack/paths.yml`

```yaml
default: &default
  output: public           # The default of most rails apps 
  manifest: manifest.json  # Used in your webpack configuration

development:
  <<: *default
  assets: webpack/development # Location development generated files

test:
  <<: *default
  assets: webpack/test        # Location test generated files

production:
  <<: *default
  assets: webpack/production  # Location production generated files
```


### `config/webpack/development.server.yml`

```yaml
# Restart webpack-dev-server if you make changes here
default: &default  
  # important that the default is false so non-development environments don't use hot reloading
  enabled: false      
  host: localhost
  port: 3500

development:
  <<: *default
  # Leaving the default as false so only overriden by an ENV value
  enabled: false
```

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
Webpacker Lite is released under the [MIT License](https://opensource.org/licenses/MIT).
