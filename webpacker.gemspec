$:.push File.expand_path("../lib", __FILE__)
require "webpacker_lite/version"

Gem::Specification.new do |s|
  s.name     = "webpacker_lite"
  s.version  = WebpackerLite::VERSION
  s.authors  = "David Heinemeier Hansson, Justin Gordon"
  s.email    = "justin@shakacode.com"
  s.summary  = "Asset Helpers for Webpack"
  s.homepage = "https://github.com/shakacode/webpacker_lite"
  s.license  = "MIT"

  s.required_ruby_version = ">= 2.0.0"

  s.add_dependency "activesupport", ">= 4.2"
  s.add_dependency "multi_json",    "~> 1.2"
  s.add_dependency "railties",      ">= 4.2"

  s.add_development_dependency "bundler", "~> 1.12"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "rspec"
  s.add_development_dependency "coveralls"
  s.add_development_dependency "rubocop"

  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features|gen-examples|tmp|node_modules|node_package|coverage)/}) }
  s.test_files    = `git ls-files -- spec/*`.split("\n")
end
