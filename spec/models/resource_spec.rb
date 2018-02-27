require 'rails_helper'

RSpec.describe Resource, type: :model do

  context "without user, specialist and domain" do
    it {is_expected.to be_invalid}
  end


  context "with valid user, specialist and domain" do
    subject(:resource){complete_resource}

    it {is_expected.to be_valid}

    it "it's status is pending" do
      expect(resource.pending?).to be true
    end
  end

  context "with user and specialist are identical" do
    subject{FactoryBot.build(:resource_with_self_as_specialist)}
    it {is_expected.to be_invalid}
  end

  private

  def complete_resource
    FactoryBot.build(:resource, :complete)
  end

end
