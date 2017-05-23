require_relative "task_helpers"
include WebpackerLite::TaskHelpers

namespace :lint do
  desc "Run Rubocop as shell"
  task :rubocop do
    sh_in_dir(gem_root, "bundle exec rubocop .")
  end

  desc "Run ruby-lint as shell"
  task :ruby do
    puts "See /ruby-lint.yml for what directories are included."
    sh_in_dir(gem_root, "bundle exec ruby-lint .")
  end

  desc "Run scss-lint as shell"
  task :scss do
    sh_in_dir(gem_root, "bundle exec scss-lint spec/dummy/app/assets/stylesheets/")
  end

  desc "Run all rubocop linters. Skip ruby-lint and scss"
  task lint: [:rubocop] do
    puts "Completed all linting"
  end
end

desc "Runs all linters. Run `rake -D lint` to see all available lint options"
task lint: ["lint:lint"]
