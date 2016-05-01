Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-reference_on_declaration_outside_of_class-test'
  spec.version     = '1.0.8'
  spec.homepage    = 'https://github.com/tuxmea/puppet-lint-reference_on_declaration_outside_of_class-test'
  spec.license     = 'APL2'
  spec.author      = 'Martin Alfke'
  spec.email       = 'ma@example42.com'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    '.rspec',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.test_files  = Dir['spec/**/*']
  spec.summary     = 'puppet-lint only reference on declarations in class check'
  spec.description = <<-EOF
    Extends puppet-lint to ensure that a reference is made only on a declaration within the same class
  EOF

  spec.add_dependency             'puppet-lint', '~> 1.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rake', '~> 0'
end
