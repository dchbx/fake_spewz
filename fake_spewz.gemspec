
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "fake_spewz/version"

Gem::Specification.new do |spec|
  spec.name          = "fake_spewz"
  spec.version       = FakeSpewz::VERSION
  spec.authors       = ["Dan Thomas"]
  spec.email         = ["dan@ideacrew.com"]

  spec.summary       = %q{Generate data elements that seem real, yet are totally fabricated}
  spec.description   = %q{Intended to generate anonymous content for commonly-used database classes}
  spec.homepage      = "https://github.com/dchbx"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  # spec.add_runtime_dependency 'dbf', '~> 3.1', '>= 3.1.1'
  spec.add_runtime_dependency 'rgeo-shapefile', '~> 0.4.2'

  spec.add_development_dependency "byebug"
  spec.metadata["yard.run"] = "yri" # use "yard" to build full HTML docs.

end
