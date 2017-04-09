tasks = {
  "webpacker:install"         => "Installs and setup webpack with yarn",
  "webpacker:compile"         => "Compiles webpack bundles based on environment",
  "webpacker:check_node"      => "Verifies if Node.js is installed",
  "webpacker:check_yarn"      => "Verifies if yarn is installed",
  "webpacker:verify_install"  => "Verifies if webpacker is installed",
}.freeze

desc "Lists all available tasks in webpacker"
task :webpacker do
  puts "Available webpacker tasks are:"
  tasks.each { |task, message| puts task.ljust(30) + message }
end
