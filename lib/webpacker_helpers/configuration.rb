# Loads webpacker configuration from config/webpack/paths.yml
require "webpacker_helpers/file_loader"
require "webpacker_helpers/env"

class WebpackerHelpers::Configuration < WebpackerHelpers::FileLoader
  RAILS_WEB_PUBLIC = "public"

  class << self
    def manifest_path
      Rails.root.join(webpack_public_output_dir,
                      configuration.fetch(:manifest, "manifest.json"))
    end

    def webpack_public_output_dir
      Rails.root.join(RAILS_WEB_PUBLIC, configuration.fetch(:webpack_public_output_dir, "webpack"))
    end

    def base_path
      "/#{configuration.fetch(:webpack_public_output_dir, "webpack")}"
    end

    # Uses the hot_reloading_host if appropriate
    def base_url
      if WebpackerHelpers::Env.hot_loading?
        host = configuration[:hot_reloading_host]
        if host.blank?
          raise "WebpackerHelpers's /config/webpacker_helpers.yml needs a configuration value for the "\
            "`hot_reloading_host` for environment #{Rails.env}."
        end
        if host.starts_with?("http")
          host
        else
          "http://#{host}"
        end
      else
        base_path
      end
    end

    def configuration
      load_instance
      raise WebpackerHelpers::FileLoader::FileLoaderError.new("WebpackerHelpers::Configuration.load_instance must be called first") unless instance
      instance.data
    end

    def file_path
      Rails.root.join("config", "webpacker_helpers.yml")
    end
  end

  private
    def load_data
      return super unless File.exist?(@path)
      HashWithIndifferentAccess.new(YAML.load(File.read(@path))[WebpackerHelpers::Env.current])
    end
end
