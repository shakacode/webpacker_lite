tasks = {
  "webpacker_helpers:clobber" => "Remove the webpack compiled output directory as defined in config/webpack/paths.yml",
  "webpacker_helpers:check_node"      => "Verifies if Node.js is installed",
  "webpacker_helpers:check_yarn"      => "Verifies if yarn is installed",
  "webpacker_helpers:verify_install"  => "Verifies if webpacker is installed"
}.freeze

desc "Lists all available tasks in webpacker_helpers"
task :webpacker_helpers do
  puts "Available webpacker_helpers tasks are:"
  tasks.each { |task, message| puts task.ljust(30) + message }
end
