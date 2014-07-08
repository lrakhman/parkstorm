require 'rails_helper'

feature 'User browsing the website' do
  context "on initial landing page" do
    it "street sweeping window updates" do
      visit root_path
      sleep 3
      expect(page).to have_content('The next street cleaning for your current location is: July 16')
    end

    it "user is able to log in and see their user page" do
      user = User.create(email: "nfrecka@gmail.com", password: "caketime99")
      visit root_path
      sleep 4
      fill_in 'user[email]',   with: user.email
      fill_in 'user[password]', with: 'caketime99'
      click_on "Log In"
      expect(current_url).to eq()
    end


    
  end

  # context "" do
  #   it "" do
  #   end
  # end
end