# Loads webpacker configuration from config/webpack/paths.yml
require "webpacker_lite/file_loader"
require "webpacker_lite/env"

class WebpackerLite::Configuration < WebpackerLite::FileLoader
  class << self
    def manifest_path
      Rails.root.join(webpack_public_output_dir,
                      configuration.fetch(:manifest, "manifest.json"))
    end

    def webpack_public_output_dir
      Rails.root.join(
        File.join("public", configuration.fetch(:webpack_public_output_dir, "webpack")))
    end

    def base_path
      "/#{configuration.fetch(:webpack_public_output_dir, "webpack")}"
    end

    # Uses the hot_reloading_host if appropriate
    def base_url
      if WebpackerLite::Env.hot_loading?
        host = configuration[:hot_reloading_host]
        if host.blank?
          raise "WebpackerLite's /config/webpacker_lite.yml needs a configuration value for the "\
            "`hot_reloading_host` for environment #{Rails.env}."
        end
        "http://#{host}"
      else
        base_path
      end
    end

    def configuration
      load if WebpackerLite::Env.development?
      raise WebpackerLite::FileLoader::FileLoaderError.new("WebpackerLite::Configuration.load must be called first") unless instance
      instance.data
    end

    def file_path
      Rails.root.join("config", "webpacker_lite.yml")
    end
  end

  private
    def load
      return super unless File.exist?(@path)
      HashWithIndifferentAccess.new(YAML.load(File.read(@path))[WebpackerLite::Env.current])
    end
end
