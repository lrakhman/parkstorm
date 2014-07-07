require 'rails_helper'

feature 'User browsing the website' do
  context "on initial landing page" do
    # xit "login button brings up modal" do
    #   visit root_path
    #   click_on "Log In"
    #   sleep 1
    #   expect(page).to have_css('#user_email')
    # end

    # xit "user is able to log in and see their user page" do
    #   visit root_path
    #   click_on "Log In"
    #   User.create(email: "nfrecka@gmail.com", password: "caketime99")
    #   fill_in '#user_email',   with: user.email
    #   fill_in '#user_password', with: 'caketime99'
    #   click_on "Log In"
    #   expect(current_url).to eq()
    # end

    it "street sweeping window updates" do
      visit root_path
      expect(page).to have_content('The next street cleaning for your location is: _____________________')
    end

    
  end

  # context "" do
  #   it "" do
  #   end
  # end
end