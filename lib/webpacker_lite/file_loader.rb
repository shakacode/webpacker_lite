# Provides a base singleton-configuration pattern for loading a JSON or YAML file, given a path
class WebpackerLite::FileLoader
  class NotFoundError < StandardError; end
  class FileLoaderError < StandardError; end

  class_attribute :instance
  attr_accessor :data

  class << self
    def load(path = file_path)
      self.instance = new(path)
    end

    def file_path
      raise "Subclass of WebpackerLite::FileLoader should override this method"
    end
  end

  private
    def initialize(path)
      @path = path
      @data = load
    end

    def load
      {}.freeze
    end
end
