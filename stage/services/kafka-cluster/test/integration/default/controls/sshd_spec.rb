control 'sshd' do
  title 'sshd controls'
  desc "
    Check that the host's SSH daemon is correctly configured.
  "

  tag 'sshd', 'centos'

  describe service('sshd') do
    it { should be_enabled}
    it { should be_running}
  end

  describe sshd_config do
    its( 'Protocol' ) { should eq '2' }
    its( 'Port' ) { should eq('22') }
  end
end
