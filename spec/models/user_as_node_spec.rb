require 'spec_helper'
require 'social_graph'
module SocialGraph
  describe UserAsNode do
    let(:ar_user) {User.create_with_direct_auth("test@test.com", "my-password-secret")}
    let(:user1) {UserAsNode.create(:user_id => ar_user.id, :name => ar_user.name)}
    let(:user2) {double("Node")}
    let(:node3) {double("Node")}
    let(:node4) {double("Node")}

    describe "#befriend" do
      it "should add friends" do
        user1.befriend3(user2)
        #user1.acolytes.size.should == 1
        #user1.idols.size.should == 1
      end
    end



    describe "#acolytes" do
      it "should show my groupies" do
        RELATIONSHIP.create(:friend, user2, user1)
        RELATIONSHIP.create(:friend, node3, user1)
        user1.acolytes.size.should == 2
        user1.idols.size.should == 0
      end
    end

    describe "#idols" do
      it "should return those i'm sweating'" do
        user1.add_friend(user2)
        user1.add_friend(node3)

        user1.idols.size.should == 2
        user1.acolytes.size.should == 0
      end
    end

    describe "#friends" do
      it "should show all my friends" do
        user1.add_friend(user2)
        user1.add_friend(node3)

        RELATIONSHIP.create(:friend, node3, user1)
        RELATIONSHIP.create(:friend, user2, node3)

        user1.friends.size == 2
        RELATIONSHIP.create(:friend, node4, user1)

        user1.friends.size == 3
        user1.acolytes.size.should == 2
        user1.idols.size.should == 2
      end
    end

    describe "#aquaintance" do
      it "should tell me who is an aquaintace" do
        create_graph

        user1.aquaintance?(miguel).should be_true
        user1.aquaintance?(eleonora).should be_true
        user1.aquaintance?(konn4).should be_false
        user1.aquaintance?(konn2).should be_true
        user1.aquaintance?(konn6).should be_false
        user1.aquaintance?(sudesh).should be_true
      end
    end

  end
end
