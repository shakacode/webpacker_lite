# Singleton registry for determining NODE_ENV from config/webpacker_helpers.yml
require "webpacker_helpers/file_loader"

class WebpackerHelpers::Env < WebpackerHelpers::FileLoader
  class << self
    def current
      raise WebpackerHelpers::FileLoader::FileLoaderError.new("WebpackerHelpers::Env.load must be called first") unless instance
      instance.data
    end

    def hot_loading?
      (ENV["HOT_RELOADING"].present? && (
      ENV["HOT_RELOADING"].upcase == "YES" ||
        ENV["HOT_RELOADING"].upcase == "TRUE")) ||
        current["hot_reloading_enabled_by_default"]
    end

    def file_path
      Rails.root.join("config", "webpacker_helpers.yml")
    end
  end

  private
    def load_data
      environments = File.exist?(@path) ? YAML.load(File.read(@path)).keys : [].freeze
      return ENV["NODE_ENV"] if environments.include?(ENV["NODE_ENV"])
      return Rails.env if environments.include?(Rails.env)
      "production"
    end
end
