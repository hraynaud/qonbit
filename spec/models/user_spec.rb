require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user){FactoryBot.create(:user)}
  let(:friend){FactoryBot.create(:user)}

  it "should be valid" do
    expect(user).to be_valid
  end

  pending "should be have a membership" do
    user.is_member.should be_true
  end

  pending "should have an associated related node" do
    user.as_node.should_not be_nil
  end

  pending "should have an initial score ==DEFAULT_INITIAL_SCORE" do
    user.score.should == ScoreKeeper::STARTING_SCORE
  end

  describe "#befriend" do
    pending "should create friendship" do
      user.befriend(friend)
      user.friends_with?(friend).should be_true
    end
  end

  describe "#adjust_score_by" do
    pending "should increment/decrement the score by the appropriate amount" do
      previous = user.score
      user.adjust_score_by(-5)
      user.score.should == previous-5
    end
  end


end
