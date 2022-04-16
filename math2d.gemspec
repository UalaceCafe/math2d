Gem::Specification.new do |s|
  s.name        = 'math2d'
  s.version     = '1.4.1'
  s.summary     = 'Math2D'
  s.description = 'A collection of useful Mathematical and Vector tools in 2D space'
  s.authors     = ['Ualace Henrique']
  s.files       = Dir['lib/**/*.rb']
  s.homepage    = 'https://github.com/UalaceCafe/math2d'
  s.license     = 'MIT'

  # no deployment dependencies

  # development
  s.add_development_dependency 'rspec', '~> 3.0'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'yard'
end
