module Webpacker
  module Lite
    def self.bootstrap
      Webpacker::Lite::Env.load
      Webpacker::Lite::Configuration.load
      Webpacker::Lite::Manifest.load
    end
  end
end

require "webpacker/lite/railtie" if defined?(Rails)
