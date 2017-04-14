require "webpacker_lite/manifest"
require "webpacker_lite/env"

module WebpackerLite::Helper
  # Computes the full path for a given webpacker asset.
  # Return relative path using manifest.json and passes it to asset_url helper
  # This will use asset_path internally, so most of their behaviors will be the same.
  # Examples:
  #
  # In development mode:
  #   <%= asset_pack_path 'calendar.js' %> # => "/packs/calendar.js"
  # In production mode:
  #   <%= asset_pack_path 'calendar.css' %> # => "/packs/calendar-1016838bab065ae1e122.css"
  def asset_pack_path(name, **options)
    asset_path(WebpackerLite::Manifest.lookup(name), **options)
  end
  # Creates a script tag that references the named pack file, as compiled by Webpack per the entries list
  # in config/webpack/shared.js. By default, this list is auto-generated to match everything in
  # app/javascript/packs/*.js. In production mode, the digested reference is automatically looked up.
  #
  # Examples:
  #
  #   # In development mode:
  #   <%= javascript_pack_tag 'calendar', 'data-turbolinks-track': 'reload' %> # =>
  #   <script src="/packs/calendar.js" data-turbolinks-track="reload"></script>
  #
  #   # In production mode:
  #   <%= javascript_pack_tag 'calendar', 'data-turbolinks-track': 'reload' %> # =>
  #   <script src="/packs/calendar-1016838bab065ae1e314.js" data-turbolinks-track="reload"></script>
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
  #   <link rel="stylesheet" media="screen" href="/public/webpack/development/calendar.css" data-turbolinks-track="reload" />
  #
  #   The key options are `static` and `hot` which specify what you want for static vs. hot. Both of
  #   these params are optional, and support either a single value, or an array.
  #
  #   static vs. hot is picked based on whether
  #   ENV["REACT_ON_RAILS_ENV"] == "HOT"
  #   <%= stylesheet_pack_tag(static: 'application_static',
  #                               hot: 'application_non_webpack',
  #                               media: 'all',
  #                               'data-turbolinks-track' => "reload")  %>
  #
  #   <!-- These do not use turbolinks, so no data-turbolinks-track -->
  #   <!-- This is to load the hot assets. -->
  #   <%= stylesheet_pack_tag(hot: ['app', 'vendor']) %>
  #
  #   <!-- These do use turbolinks -->
  #   <%= stylesheet_pack_tag(static: 'application_static',
  #                                  hot: 'application_non_webpack',
  #                                  'data-turbolinks-track': 'reload') %>
  #

  def stylesheet_pack_tag(*args, **kwargs)
    manifested_names = []
    default_case = args.any?
    if default_case
      args.flatten!
      manifested_names += get_manifests(args)
    end
    asset_type = WebpackerLite::Env.hot_loading? ? :hot : :static
    names = Array(kwargs[asset_type])
    manifested_names += get_manifests(names)

    options = kwargs.delete_if { |key, _value| %i(hot static).include?(key) }
    stylesheet_link_tag(*manifested_names, options)
  end

  private

  def get_manifests(names)
    names.map do |name|
      WebpackerLite::Manifest.lookup("#{name}#{compute_asset_extname(name, type: :stylesheet)}")
    end
  end
end
