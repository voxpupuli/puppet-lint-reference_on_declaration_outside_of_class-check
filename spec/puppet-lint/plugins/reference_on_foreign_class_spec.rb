require 'spec_helper'

describe 'reference_on_foreign_class' do

  context 'a proper reference on a local class include' do
    let(:code) { "
      class demo {
        include demo::install
        include demo::config
        Class['demo::config'] -> Class['demo::install']
      }
            " }

    it 'should detect no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a proper reference on a local class include using a variable' do
    let(:code) { "
      class demo {
        include $install
        include $config
        Class[$config] -> Class[$install]
      }
            " }

    it 'should detect no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a proper reference on a local class type declaration' do
    let(:code) { "
      class demo2 {
        class { demo2::install: }
        class { demo2::config: }
        Class['demo2::config'] -> Class['demo2::install']
      }
            " }

    it 'should detect no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a proper reference on a local class type declaration using a variable' do
    let(:code) { "
      class demo2 {
        class { $install: }
        class { $config: }
        Class[$config] -> Class[$install]
      }
            " }

    it 'should detect no problem' do
      expect(problems).to have(0).problem
    end
  end


  context 'a reference on a foreign class declaration' do
    let(:msg) { 'reference on a foreign class' }
    let(:code) { "
      include base::demo
      Class['demo'] -> Class['foo']
            " }

    it 'should detect two problems' do
      expect(problems).to have(2).problem
    end

    it 'should create a warning' do
      expect(problems).to contain_warning(msg)
    end
  end

  context 'a reference on a foreign class declaration using a variable' do
    let(:msg) { 'reference on a foreign class' }
    let(:code) { "
      include $base::demo
      Class[$demo] -> Class[$foo]
            " }

    it 'should detect two problems' do
      expect(problems).to have(2).problem
    end

    it 'should create a warning' do
      expect(problems).to contain_warning(msg)
    end
  end

  context 'a reference on a foreign class type declaration' do
    let(:msg) { 'reference on a foreign class' }
    let(:code) { "
      class{ base::demo: }
      Class['demo'] -> Class['foo']
            " }

    it 'should detect two problems' do
      expect(problems).to have(2).problem
    end

    it 'should create a warning' do
      expect(problems).to contain_warning(msg)
    end
  end


end
