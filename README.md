# puppet-lint plugin reference on declaration in class check

**Note: this plugin will check for references which are declared outside of the class where the reference is used.**

## Installation

To use this plugin, add the following like to the Gemfile in your Puppet code
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
