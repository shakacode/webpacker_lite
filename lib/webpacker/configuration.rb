# Loads webpacker configuration from config/webpack/paths.yml
require "webpacker/lite/file_loader"
require "webpacker/lite/env"

class WebpackerLite::Configuration < WebpackerLite::FileLoader
  class << self
    def config_path
      Rails.root.join(paths.fetch(:config, "config/webpack"))
    end

    def file_path
      Rails.root.join("config", "webpack", "paths.yml")
    end

    def manifest_path
      Rails.root.join(output_path, paths.fetch(:manifest, "manifest.json"))
    end

    def output_path
      Rails.root.join(paths.fetch(:output, "public"), paths.fetch(:assets, "assets/webpack"))
    end

    def paths
      load if WebpackerLite::Env.development?
      raise WebpackerLite::FileLoader::FileLoaderError.new("WebpackerLite::Configuration.load must be called first") unless instance
      instance.data
    end

    def source_path
      Rails.root.join(paths.fetch(:source, "app/javascript"))
    end
  end

  private
    def load
      return super unless File.exist?(@path)
      HashWithIndifferentAccess.new(YAML.load(File.read(@path))[WebpackerLite::Env.current])
    end
end
