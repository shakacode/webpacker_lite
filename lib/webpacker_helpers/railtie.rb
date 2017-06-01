require "rails/railtie"

require "webpacker_helpers/helper"

class WebpackerHelpers::Engine < ::Rails::Engine
  initializer :webpacker_helpers do |app|
    ActiveSupport.on_load :action_controller do
      ActionController::Base.helper WebpackerHelpers::Helper
    end

    ActiveSupport.on_load :action_view do
      include WebpackerHelpers::Helper
    end

    WebpackerHelpers.bootstrap
    Spring.after_fork {  WebpackerHelpers.bootstrap } if defined?(Spring)
  end
end
