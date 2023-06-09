# Chef InSpec test for recipe workstation::default

# The Chef InSpec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec/resources/

unless os.windows?
  # This is an example test, replace with your own test.
  describe user('root'), :skip do
    it { should exist }
  end
end

# This is an example test, replace it with your own test.
describe port(80), :skip do
  it { should_not be_listening }
end

describe 'workstation::default' do
  describe package('tree') do
    it { should be_installed }
  end

  describe package('git') do
    it { should be_installed }
  end
end
