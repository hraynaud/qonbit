require 'rails_helper'

RSpec.describe User, type: :model do
  context "with oauth tokens" do
    subject(:user){FactoryBot.build(:user)}
    it {is_expected.to be_invalid}
  end

  context "with oauth tokens" do
    subject(:user){FactoryBot.build(:user, :with_auth_tokens)}
    it {is_expected.to be_valid}

    it "adds user to social graph when created" do
      expect(user).to receive(:add_to_social_graph)
      user.save
    end
  end
end
