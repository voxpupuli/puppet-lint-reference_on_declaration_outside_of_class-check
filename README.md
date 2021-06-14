# puppet-lint plugin reference on declaration in class check

[![License](https://img.shields.io/github/license/voxpupuli/puppet-lint-reference_on_declaration_outside_of_class-check.svg)](https://github.com/voxpupuli/puppet-lint-reference_on_declaration_outside_of_class-check/blob/master/LICENSE)
[![Test](https://github.com/voxpupuli/puppet-lint-reference_on_declaration_outside_of_class-check/actions/workflows/test.yml/badge.svg)](https://github.com/voxpupuli/puppet-lint-reference_on_declaration_outside_of_class-check/actions/workflows/test.yml)
[![Release](https://github.com/voxpupuli/puppet-lint-reference_on_declaration_outside_of_class-check/actions/workflows/release.yml/badge.svg)](https://github.com/voxpupuli/puppet-lint-reference_on_declaration_outside_of_class-check/actions/workflows/release.yml)
[![RubyGem Version](https://img.shields.io/gem/v/puppet-lint-reference_on_declaration_outside_of_class-check.svg)](https://rubygems.org/gems/puppet-lint-reference_on_declaration_outside_of_class-check)
[![RubyGem Downloads](https://img.shields.io/gem/dt/puppet-lint-reference_on_declaration_outside_of_class-check.svg)](https://rubygems.org/gems/puppet-lint-reference_on_declaration_outside_of_class-check)
[![Donated by example42](https://img.shields.io/badge/donated%20by-example42-fb7047.svg)](#transfer-notice)

**Note: this plugin will check for references which are declared outside of the class where the reference is used.**

## Installation

To use this plugin, add the following line to the `Gemfile` in your Puppet code
base and run `bundle install`.

```ruby
gem 'puppet-lint-reference_on_declaration_outside_of_class-check'
```

## Usage

This plugin provides one new check to `puppet-lint`.

### reference_on_declaration_outside_of_class

**--fix support: No**

This check will raise a warning for any resource reference that is not declared inside the same class.


```
  class 'foo' {
    package { 'foo':
      ensure => present,
    }
    file { '/tmp/foo':
      ensure  => file,
      require => Package['foo2'],
    }
  }
```
and will result in the following warning:

```
WARNING: reference on non local resource declaration
```

### reference_on_foreign_class

**--fix support: No**

This check will raise a warning for any class reference that is not declared inside the class.

```
   class 'demo' {
     class { 'demo::install': }
     include demo::config
     Class['demo::install'] -> Class['foobar']
   }
```
and will result in the following warning:

```
WARNING: reference on a foreign class
```

## Transfer Notice

This plugin was originally authored by [example42](https://example42.de).
The maintainer preferred that Puppet Community take ownership of the module for future improvement and maintenance.
Existing pull requests and issues were transferred over, please fork and continue to contribute here instead of example42.

## License

This gem is licensed under the Apache-2 license.

## Release information

To make a new release, please do:
* update the version in the gemspec file
* Install gems with `bundle install --with release --path .vendor`
* generate the changelog with `bundle exec rake changelog`
* Check if the new version matches the closed issues/PRs in the changelog
* Create a PR with it
* After it got merged, push a tag. GitHub actions will do the actual release to rubygems and GitHub Packages
