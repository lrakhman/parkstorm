require 'rails_helper'

feature 'User browsing the website' do
  context "on initial landing page" do
    it "updates street sweeping window for your location" do
      visit root_path
      expect(page).to have_content('The next street cleaning for your current location is: July 16')
    end

    it "updates street sweeping window for your address" do
      visit root_path
      fill_in 'address', with: "6900 N Wolcott Ave"
      find('#address_submit').click
      expect(page).to have_content('The next street cleaning for 6900 N Wolcott Ave is: July 24')
    end

    it "updates street sweeping windows when map is clicked" do
      within_frame('#active_map') do
        map = find('#active_map').native
        page.driver.browser.action.move_to(map, 42.00647, -87.67796).click.perform
        expect(page).to have_content('The next street cleaning for 6900 N Wolcott Ave is: July 24')
      end
    end
    
  end

  context "logged in user can click profile button to redirect to user page" do
    it "user is able to log in and see their user page" do
      user = User.create(firstname: "Natalie", lastname: "Frecka", email: "nfrecka@gmail.com", password: "caketime99", password_confirmation: "caketime99")
      visit root_path
      find('#login_button').click
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: "caketime99"
      find('#login_submit').click
      click_on "Profile"
      expect(current_url).to eq(user_path(user))
    end
  end

  # context "" do
  #   it "" do
  #   end
  # end
end