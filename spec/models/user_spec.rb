require 'rails_helper'

RSpec.describe User, type: :model do
  context "without oauth or direct_auth" do
    subject(:user){FactoryBot.build(:user)}
    it {is_expected.to be_invalid}

    it "does not add itself to social graph " do
      expect(user).to_not receive(:add_to_social_graph)
      user.save
    end
  end

  context "with oauth tokens" do
    subject(:user){FactoryBot.build(:user, :with_auth_tokens)}
    it {is_expected.to be_valid}

    it "adds user to social graph when created" do
      expect(user).to receive(:add_to_social_graph)
      user.save
    end
  end

  describe ".create_with_direct_auth" do
    context "email and pwd provided" do
      it "creates new user" do
        expect{User.create_with_direct_auth("test@test.com", "my-password-secret")}.to change{User.count}.by(1)
      end
    end

    context "both email and password nil" do
      it "doesn't create new user" do
        expect{User.create_with_direct_auth(nil, nil)}.to change{User.count}.by(0)
      end
    end

    context "password is nil" do
      it "doesn't create new user" do
        expect{User.create_with_direct_auth("test@test.me", nil)}.to change{User.count}.by(0)
      end
    end

    context "both email and password nil" do
      it "doesn't create new user " do
        expect{User.create_with_direct_auth("test@test.me", nil)}.to change{User.count}.by(0)
      end
    end

  end
end
