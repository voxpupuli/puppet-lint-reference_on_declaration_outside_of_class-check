require 'spec_helper'

describe 'reference_on_foreign_class' do
  context 'a proper reference on a local class include' do
    let(:code) do
      "
      class demo {
        include demo::install
        include demo::config
        Class['demo::config'] -> Class['demo::install']
      }
            "
    end

    it 'detects no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a proper reference on a local class include using a variable' do
    let(:code) do
      "
      class demo {
        include $install
        include $config
        Class[$config] -> Class[$install]
      }
            "
    end

    it 'detects no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a proper reference on a local class type declaration' do
    let(:code) do
      "
      class demo2 {
        class { demo2::install: }
        class { demo2::config: }
        Class['demo2::config'] -> Class['demo2::install']
      }
            "
    end

    it 'detects no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a proper reference on a local class type declaration using a variable' do
    let(:code) do
      "
      class demo2 {
        class { $install: }
        class { $config: }
        Class[$config] -> Class[$install]
      }
            "
    end

    it 'detects no problem' do
      expect(problems).to have(0).problem
    end
  end

  context 'a reference on a foreign class declaration' do
    let(:msg) { 'reference on a foreign class' }
    let(:code) do
      "
      include base::demo
      Class['demo'] -> Class['foo']
            "
    end

    it 'detects two problems' do
      expect(problems).to have(2).problem
    end

    it 'creates a warning' do
      expect(problems).to contain_warning(msg)
    end
  end

  context 'a reference on a foreign class declaration using a variable' do
    let(:msg) { 'reference on a foreign class' }
    let(:code) do
      "
      include $base::demo
      Class[$demo] -> Class[$foo]
            "
    end

    it 'detects two problems' do
      expect(problems).to have(2).problem
    end

    it 'creates a warning' do
      expect(problems).to contain_warning(msg)
    end
  end

  context 'a reference on a foreign class type declaration' do
    let(:msg) { 'reference on a foreign class' }
    let(:code) do
      "
      class{ base::demo: }
      Class['demo'] -> Class['foo']
            "
    end

    it 'detects two problems' do
      expect(problems).to have(2).problem
    end

    it 'creates a warning' do
      expect(problems).to contain_warning(msg)
    end
  end
end
