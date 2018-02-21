require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user){FactoryBot.create(:user)}
  let(:friend){FactoryBot.create(:user)}

  it "should be valid" do
    expect(user).to be_valid
  end

  it "should have an associated related node" do
    expect(user.as_node).to_not be_nil
  end

end
