Gem::Specification.new do |spec|
  spec.name        = 'puppet-lint-reference_on_declaration_outside_of_class-check'
  spec.version     = '1.1.1'
  spec.homepage    = 'https://github.com/voxpupuli/puppet-lint-reference_on_declaration_outside_of_class-check'
  spec.license     = 'Apache-2.0'
  spec.author      = 'Vox Pupuli'
  spec.email       = 'voxpupuli@groups.io'
  spec.files       = Dir[
    'README.md',
    'LICENSE',
    '.rspec',
    'lib/**/*',
    'spec/**/*',
  ]
  spec.summary     = 'puppet-lint only reference on declarations in class check'
  spec.description = <<-EOF
    Extends puppet-lint to ensure that a reference is made only on a declaration within the same class
  EOF

  spec.add_dependency             'puppet-lint', '>= 1.0', '< 3.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'rspec-its', '~> 1.0'
  spec.add_development_dependency 'rspec-json_expectations', '>= 1.4', '< 3.0'
  spec.add_development_dependency 'simplecov', '~> 0.22.0'
end
