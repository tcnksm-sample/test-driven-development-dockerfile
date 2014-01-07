require 'spec_helper'

describe package('nginx') do
  it { should be_installed }
end
