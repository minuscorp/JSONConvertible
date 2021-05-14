Gem::Specification.new do |spec|
  spec.name        = "json_convertible"
  spec.version     = "0.0.1"
  spec.summary     = "A lightweight Ruby mixin for encoding/decoding JSON data classes."
  spec.description = "A lightweight Ruby mixin for encoding/decoding JSON data classes."
  spec.authors     = ["Jorge Revuelta H"]
  spec.email       = "minuscorp@gmail.com"
  spec.files       = Dir.glob("*/lib/**/*", File::FNM_DOTMATCH)
  spec.homepage    =
    "https://rubygems.org/gems/json_convertible"
  spec.license     = "Apache-2.0"

  spec.required_ruby_version = ">= 2.4.0"

  # Dependencies
  spec.add_dependency("json", "< 3.0.0")

  # Development dependencies
  spec.add_development_dependency("bundler", ">= 1.5")
  spec.add_development_dependency("coveralls")
  spec.add_development_dependency("rake")
  spec.add_development_dependency("rspec", "~> 3.10")
  spec.add_development_dependency("rubocop", "1.12.1")
  spec.add_development_dependency("rubocop-performance")
end

