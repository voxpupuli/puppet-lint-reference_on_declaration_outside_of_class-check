require 'spec_helper'

describe 'reference_on_declaration_outside_of_class' do
  context 'a proper reference on a local declaration' do
    let(:code) do
      "
      package { 'demo': ensure => present }
      file { 'foo': ensure => file }
      service { 'foo': subscribe => File['foo'] }
            "
    end

    it 'detects no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a proper reference on a local declaration using varaible' do
    let(:code) do
      "
      package { 'demo': ensure => present }
      file { $cfgfile: ensure => file }
      service { 'foo': subscribe => File[$cfgfile] }
            "
    end

    it 'detects no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a reference on a foreign declaration' do
    let(:msg) { 'reference on a resource type declaration not included in the same class' }
    let(:code) do
      "
      package { 'demo2': ensure => present }
      file { 'foofail': ensure => file }
      service { 'foofail': subscribe => File['foo2'] }
            "
    end

    it 'onlies detect a single problem' do
      expect(problems).to have(1).problem
    end

    it 'creates a warning' do
      expect(problems).to contain_warning(msg)
    end
  end

  context 'a reference on a foreign declaration using a variable' do
    let(:msg) { 'reference on a resource type declaration not included in the same class' }
    let(:code) do
      "
      package { $pkgname: ensure => present }
      file { 'foofail': ensure => file }
      service { 'foofail': subscribe => Package[$pkgname2] }
            "
    end

    it 'onlies detect a single problem' do
      expect(problems).to have(1).problem
    end

    it 'creates a warning' do
      expect(problems).to contain_warning(msg)
    end
  end
end
