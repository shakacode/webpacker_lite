# Singleton registry for determining NODE_ENV from config/webpacker_lite.yml
require "webpacker_lite/file_loader"

class WebpackerLite::Env < WebpackerLite::FileLoader
  class << self
    def current
      raise WebpackerLite::FileLoader::FileLoaderError.new("WebpackerLite::Env.load must be called first") unless instance
      instance.data
    end

    def development?
      current == "development"
    end

    def hot_loading?
      (ENV["HOT_RELOADING_ENABLED"].present? && (
      ENV["HOT_RELOADING_ENABLED"].upcase == "YES" ||
        ENV["HOT_RELOADING_ENABLED"].upcase == "TRUE")) ||
        current["hot_reloading_enabled_by_default"]
    end

    def file_path
      Rails.root.join("config", "webpacker_lite.yml")
    end
  end

  private
    def load
      environments = File.exist?(@path) ? YAML.load(File.read(@path)).keys : [].freeze
      return ENV["NODE_ENV"] if environments.include?(ENV["NODE_ENV"])
      return Rails.env if environments.include?(Rails.env)
      "production"
    end
end
