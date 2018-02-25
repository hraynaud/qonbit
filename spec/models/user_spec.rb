require 'rails_helper'

RSpec.describe User, type: :model do

  it {is_expected.to be_valid}

  it "adds user to social graph when created" do
    user = User.new
    expect(user).to receive(:add_to_social_graph)
    user.save
  end
end
