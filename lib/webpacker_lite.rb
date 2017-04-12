module WebpackerLite
  def self.bootstrap
    WebpackerLite::Env.load
    WebpackerLite::DevServer.load
    WebpackerLite::Configuration.load
    WebpackerLite::Manifest.load
  end
end

require "webpacker_lite/railtie" if defined?(Rails)
