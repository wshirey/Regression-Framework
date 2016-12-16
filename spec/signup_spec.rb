describe 'Create account' do
  context 'free plan' do
    before(:all) do
      @email = Faker::Internet.email
      
      visit HomePage do |page|
        page.my_account_element.when_present
        page.my_account
      end

      on SigninPage do |page|
        page.sign_up_element.when_present
        page.sign_up
      end

      on SignupPage do |page|
        page.input_user_details(
          email: @email,
          password: 'HappyBirthday1'
        )
        page.home_element.when_present
        page.home
      end
    end

     after(:all) do
       visit EditUserPage do |page|
         page.cancel_account_element.when_present
         page.cancel_and_confirm
       end
     end

     it 'currently signed in' do
        on HomePage do |page|
          page.content_div_element.when_present
          expect(page.content_div).to include("Currently sign in as #{@email}")
        end
     end

  end
end
