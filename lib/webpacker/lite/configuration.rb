# Loads webpacker configuration from config/webpack/paths.yml
require "webpacker/lite/file_loader"
require "webpacker/lite/env"

class Webpacker::Lite::Configuration < Webpacker::Lite::FileLoader
  class << self
    def config_path
      Rails.root.join(paths.fetch(:config, "config/webpack"))
    end

    def entry_path
      Rails.root.join(source_path, paths.fetch(:entry, "packs"))
    end

    def file_path
      Rails.root.join("config", "webpack", "paths.yml")
    end

    def manifest_path
      Rails.root.join(output_path, paths.fetch(:manifest, "manifest.json"))
    end

    def output_path
      Rails.root.join(paths.fetch(:output, "public"), paths.fetch(:entry, "packs"))
    end

    def paths
      load if Webpacker::Lite::Env.development?
      raise Webpacker::Lite::FileLoader::FileLoaderError.new("Webpacker::Lite::Configuration.load must be called first") unless instance
      instance.data
    end

    def source_path
      Rails.root.join(paths.fetch(:source, "app/javascript"))
    end
  end

  private
    def load
      return super unless File.exist?(@path)
      HashWithIndifferentAccess.new(YAML.load(File.read(@path))[Webpacker::Lite::Env.current])
    end
end
