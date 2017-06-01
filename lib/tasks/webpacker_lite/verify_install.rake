require "webpacker_helpers/configuration"

namespace :webpacker_helpers do
  desc "Verifies if webpacker_helpers is installed"
  task verify_install: [:check_node, :check_yarn] do
    if File.exist?(WebpackerHelpers::Env.file_path)
      puts "WebpackerHelpers is installed 🎉 🍰"
      puts "Using #{WebpackerHelpers::Env.file_path} file for setting up webpack paths"
    else
      puts "Configuration config/webpack/paths.yml file not found. \n"\
           "Make sure webpacker_helpers:install is run successfully before " \
           "running dependent tasks"
      exit!
    end
  end
end
