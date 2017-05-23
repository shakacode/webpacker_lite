# Singleton registry for accessing the output path using generated manifest.
# This allows javascript_pack_tag, stylesheet_pack_tag, asset_pack_path to take a reference to,
# say, "calendar.js" or "calendar.css" and turn it into "/public/webpack/calendar.js" or
# "/public/webpack/calendar.css" in development. In production mode, it returns compiles
# files, # "/public/webpack/calendar-1016838bab065ae1e314.js" and
# "/webpack/calendar-1016838bab065ae1e314.css" for long-term caching

require "webpacker_lite/file_loader"
require "webpacker_lite/env"
require "webpacker_lite/configuration"

class WebpackerLite::Manifest < WebpackerLite::FileLoader
  class << self
    def file_path
      WebpackerLite::Configuration.manifest_path
    end

    def lookup(name)
      load if WebpackerLite::Env.development? || instance.data.empty?
      raise WebpackerLite::FileLoader::FileLoaderError.new("WebpackerLite::Manifest.load must be called first") unless instance
      instance.data[name.to_s] || missing_file_error(name)
    end

    def missing_file_error(name)
      msg = <<-MSG
        WebpackerLite can't find #{name} in your manifest #{file_path}. Possible causes:
          1. You are hot reloading
          2. Webpack is not running
          3. You have misconfigured WebpackerLite's config/webpacker_lite.yml file.
          4. Your Webpack configuration is not creating a manifest.
      MSG
      raise(WebpackerLite::FileLoader::NotFoundError.new(msg))
    end
  end

  private
    def load
      return super unless File.exist?(@path)
      JSON.parse(File.read(@path))
    end
end
