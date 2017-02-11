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

end
