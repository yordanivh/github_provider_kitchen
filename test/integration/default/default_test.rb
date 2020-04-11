control 'check_website' do

    describe http('https://github.com/yordanivh-source/test-repo') do
      its('status') { should cmp 200 }
      its('body') { should match 'This is a test' }
    end
  
  end