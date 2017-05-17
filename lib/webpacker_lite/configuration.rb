# Loads webpacker configuration from config/webpack/paths.yml
require "webpacker_lite/file_loader"
require "webpacker_lite/env"

class WebpackerLite::Configuration < WebpackerLite::FileLoader
  class << self
    def file_path
      Rails.root.join("config", "webpacker_lite.yml")
    end

    def manifest_path
      Rails.root.join(output_path, paths.fetch(:manifest, "manifest.json"))
    end

    def output_path
      Rails.root.join(paths.fetch(:webpack_public_output_dir, File.join("public", "webpack")))
    end

    def paths
      load if WebpackerLite::Env.development?
      raise WebpackerLite::FileLoader::FileLoaderError.new("WebpackerLite::Configuration.load must be called first") unless instance
      instance.data
    end
  end

  private
    def load
      return super unless File.exist?(@path)
      HashWithIndifferentAccess.new(YAML.load(File.read(@path))[WebpackerLite::Env.current])
    end
end
