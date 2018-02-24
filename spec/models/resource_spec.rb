require 'rails_helper'

RSpec.describe Resource, type: :model do

  describe Resource do
    context "without user, specialist and topic" do
      it {is_expected.to be_invalid}
    end

    context "with user, specialist and topic" do
      subject{complete_resource}

      it {is_expected.to be_valid}

      it "is pending" do
        expect(subject.pending?).to be true
      end
    end
  end

  private

  def complete_resource
    user = User.new
    specialist = User.new
    resource = Resource.new
    domain = Domain.new
    resource.specialist = specialist
    resource.user = user
    resource.domain = domain
    resource
  end

end
