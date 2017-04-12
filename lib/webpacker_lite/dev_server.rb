require "webpacker_lite/file_loader"
require "webpacker_lite/env"

class WebpackerLite::DevServer < WebpackerLite::FileLoader
  class << self
    def current
      raise WebpackerLite::FileLoader::FileLoaderError.new("WebpackerLite::DevServer.load must be called first") unless instance
      instance.data
    end

    def hot_loading?
      WebpackerLite::Env.development? && current === true
    end

    def file_path
      Rails.root.join("config", "webpack", "development.server.yml")
    end
  end

  private
    def load
      config = File.exist?(@path) ? YAML.load(File.read(@path))['development'] : [].freeze
      return config['enabled'] if config.has_key?('enabled')
      false
    end
end
