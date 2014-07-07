require 'rails_helper'

feature 'User browsing the website' do
  context "on initial landing page" do
    it "login button brings up modal" do
    	visit root_url
    	click_on "Log In"
    end

    xit "get notifications button is available" do
    end
  end

  # context "" do
  #   it "" do
  #   end
  # end
end