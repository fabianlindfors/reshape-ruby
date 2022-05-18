Gem::Specification.new do |s|
	s.name        = 'reshape_helper'
	s.version     = '0.1.1'
	s.summary 	  = "A Ruby helper library for applications using Reshape"
	s.authors     = ["Fabian Lindfors"]
	s.email       = "fabian@flapplabs.se"
	s.files       = ["lib/reshape_helper.rb"]
	s.homepage    = "https://github.com/fabianlindfors/reshape-ruby"
	s.license     = 'MIT'

	s.add_runtime_dependency "toml", "~> 0.3.0"
	s.add_development_dependency "test-unit", "~> 3.5.3"
end