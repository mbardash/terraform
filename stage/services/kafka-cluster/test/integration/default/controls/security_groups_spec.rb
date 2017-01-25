describe command('ping -c 1 google.com') do
  its('stdout') {should match /1 packets transmitted, 1 received/}
end
