module WebpackerHelpers
  def self.bootstrap
    WebpackerHelpers::Env.load_instance
    WebpackerHelpers::Configuration.load_instance
    WebpackerHelpers::Manifest.load_instance
  end

  def env
    WebpackerHelpers::Env.current.inquiry
  end
end

require "webpacker_helpers/railtie" if defined?(Rails)
