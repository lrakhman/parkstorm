require 'rails_helper'

RSpec.describe User, :type => :model do
  it "combines first and last name into full name" do
    user = User.new(firstname: "Peter", lastname: 'Mandril')
    expect(user.fullname).to eq("Peter Mandril")
  end
end
