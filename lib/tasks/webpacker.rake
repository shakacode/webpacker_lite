tasks = {
  "webpacker_lite:install"         => "Installs and setup webpack with yarn",
  "webpacker_lite:compile"         => "Compiles webpack bundles based on environment",
  "webpacker_lite:check_node"      => "Verifies if Node.js is installed",
  "webpacker_lite:check_yarn"      => "Verifies if yarn is installed",
  "webpacker_lite:verify_install"  => "Verifies if webpacker is installed",
}.freeze

desc "Lists all available tasks in webpacker_lite"
task :webpacker_lite do
  puts "Available webpacker_lite tasks are:"
  tasks.each { |task, message| puts task.ljust(30) + message }
end
