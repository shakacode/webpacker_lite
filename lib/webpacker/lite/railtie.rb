require "rails/railtie"

require "webpacker/lite/helper"

class Webpacker::Lite::Engine < ::Rails::Engine
  initializer :webpacker do |app|
    ActiveSupport.on_load :action_controller do
      ActionController::Base.helper Webpacker::Lite::Helper
    end

    Webpacker::Lite.bootstrap
    Spring.after_fork {  Webpacker::Lite.bootstrap } if defined?(Spring)
  end
end
