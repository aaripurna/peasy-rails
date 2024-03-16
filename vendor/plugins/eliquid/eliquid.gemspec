require_relative "lib/eliquid/version"

Gem::Specification.new do |spec|
  spec.name        = "eliquid"
  spec.version     = Eliquid::VERSION
  spec.authors     = ["Nawa Aripurna"]
  spec.email       = ["nap.aripurna@gmail.com"]
  spec.homepage    = "https://github.com/aaripurna"
  spec.summary     = "Summary of Eliquid."
  spec.description = "Description of Eliquid."

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the "allowed_push_host"
  # to allow pushing to a single host or delete this section to allow pushing to any host.

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/aaripurna"
  spec.metadata["changelog_uri"] = "https://github.com/aaripurna"

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  end

  spec.add_dependency "rails", ">= 7.1.3.2"
  spec.add_dependency "temple", "~> 0.10.3"
  spec.add_dependency "liquid", "~> 5.4"
end
