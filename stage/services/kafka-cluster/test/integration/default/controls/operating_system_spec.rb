control 'operating_system' do
  describe command('rpm --query centos-release') do
    its('stdout') { should match (/centos/i) }
  end
end
