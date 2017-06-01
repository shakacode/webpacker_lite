require "webpacker_helpers/manifest"
require "webpacker_helpers/env"

module WebpackerHelpers::Helper
  # Computes the full path for a given webpacker asset.
  # Return relative path using manifest.json and passes it to asset_url helper
  # This will use asset_path internally, so most of their behaviors will be the same.
  # Examples:
  #
  # In development mode:
  #   <%= asset_pack_path 'calendar.js' %> # => "/public/webpack/development/calendar-1016838bab065ae1e122.js"
  # In production mode:
  #   <%= asset_pack_path 'calendar.css' %> # => "/public/webpack/production/calendar-1016838bab065ae1e122.css"
  def asset_pack_path(name, **options)
    path = WebpackerHelpers::Configuration.base_path
    file = WebpackerHelpers::Manifest.lookup(name)
    asset_path("#{path}/#{file}", **options)
  end

  # Creates a script tag that references the named pack file, as compiled by Webpack.
  #
  # Examples:
  #
  #   In development mode:
  #   <%= javascript_pack_tag 'calendar', 'data-turbolinks-track': 'reload' %> # =>
  #   <script src="/public/webpack/development/calendar-1016838bab065ae1e314.js" data-turbolinks-track="reload"></script>
  #
  #   # In production mode:
  #   <%= javascript_pack_tag 'calendar', 'data-turbolinks-track': 'reload' %> # =>
  #   <script src="/public/webpack/production/calendar-1016838bab065ae1e314.js" data-turbolinks-track="reload"></script>
  def javascript_pack_tag(name, **options)
    javascript_include_tag(asset_source(name, :javascript), **options)
  end

  # Creates a link tag that references the named pack file(s), as compiled by Webpack per the entries list
  # in client/webpack.client.base.config.js.
  #
  # Examples:
  #
  #   # In production mode:
  #   <%= stylesheet_pack_tag 'calendar', 'data-turbolinks-track': 'reload' %> # =>
  #   <link rel="stylesheet" media="screen" href="/public/webpack/production/calendar-1016838bab065ae1e122.css" data-turbolinks-track="reload" />
  #
  #   # In development mode:
  #   <%= stylesheet_pack_tag 'calendar', 'data-turbolinks-track': 'reload' %> # =>
  #   <link rel="stylesheet" media="screen" href="/public/webpack/development/calendar-1016838bab065ae1e122.css" data-turbolinks-track="reload" />
  #
  #   # In development mode with hot-reloading
  #   <%= stylesheet_pack_tag('main') %> <% # Default is false for enabled_when_hot_loading%>
  #   # No output
  #
  #   # In development mode with hot-reloading and enabled_when_hot_loading
  #   # <%= stylesheet_pack_tag('main', enabled_when_hot_loading: true) %>
  #   <link rel="stylesheet" media="screen" href="/public/webpack/development/calendar-1016838bab065ae1e122.css" />
  #
  def stylesheet_pack_tag(name, **options)
    return "" if WebpackerHelpers::Env.hot_loading? && !options[:enabled_when_hot_loading].presence
    stylesheet_link_tag(asset_source(name, :stylesheet), **options)
  end

  private
    def asset_source(name, type)
      url = WebpackerHelpers::Configuration.base_url
      path = WebpackerHelpers::Manifest.lookup("#{name}#{compute_asset_extname(name, type: type)}")
      "#{url}/#{path}"
    end
end
