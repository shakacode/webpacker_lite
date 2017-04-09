module Webpacker
  module Lite
    def self.bootstrap
      WebpackerLite::Env.load
      WebpackerLite::Configuration.load
      WebpackerLite::Manifest.load
    end
  end
end

require "webpacker_lite/railtie" if defined?(Rails)
