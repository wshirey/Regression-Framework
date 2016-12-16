describe 'Create account' do
  context 'free plan' do
    before(:all) do
      @email = Faker::Internet.email   
      @browser.goto 'http://ec2-54-191-181-182.us-west-2.compute.amazonaws.com/'
    end

     it 'displays the home page' do
        expect(@browser.div(:id => 'content').when_present.text).to include("With all the contact management")
     end
  end
end
