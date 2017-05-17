require "webpacker_lite/manifest"
require "webpacker_lite/env"

module WebpackerLite::Helper
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
    asset_path(WebpackerLite::Manifest.lookup(name), **options)
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
    javascript_include_tag(WebpackerLite::Manifest.lookup("#{name}#{compute_asset_extname(name, type: :javascript)}"), **options)
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
  def stylesheet_pack_tag(*args, **kwargs)
   return "" if WebpackerLite::Env.hot_loading? && !kwargs[enabled_when_hot_loading].presence

   args.flatten!
   manifested_names = get_manifests(args)
   stylesheet_link_tag(*manifested_names, options)
  end

  private

    def get_manifests(names)
      names.map do |name|
        WebpackerLite::Manifest.lookup("#{name}#{compute_asset_extname(name, type: :stylesheet)}")
      end
    end
end
