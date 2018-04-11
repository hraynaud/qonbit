require 'spec_helper'
require 'social_graph'
module SocialGraph
  describe Navigator do

    describe "#traverse" do
      before(:all) do
        create_graph
      end

      context "depth 4" do

        it "should print my social graph" do
          depth = 4
          friend_graph = @user1.traverse(depth)
          expect(friend_graph.keys.count).to eq 12
        end
      end

      context "depth 2" do
        it "should print my social graph" do
          depth = 2
          friend_graph = @user1.traverse(depth)
          binding.pry
          expect(friend_graph.keys.uniq.count).to eq 8 
        end
      end

      context "depth 1" do
        it "should print my social graph" do
          depth = 1
          friend_graph = @user1.traverse(depth)

          expect(friend_graph.keys.count).to eq 5
        end
      end

      context "depth 0" do
        it "should print my social graph" do
          depth = 0
          friend_graph = @user1.traverse(depth)
          expect(friend_graph.keys.count).to eq 1
        end
      end
    end

    describe "#search_graph_by_topic" do
      before(:each) do
        create_graph
       Related::Relationship.create(:fencing, @konn3, Related.root)
       Related::Relationship.create(:fencing, @eleonora, Related.root)

      end
      context "I should have two results at depth of 5" do
        let(:depth) {4}
        it "should find all connections with a certain skill up to the specfied depth" do
          result = @user1.find_connected_by_topic(:fencing, depth)
          expected = [@eleonora, @konn3]

          all_found = true
          expected.each do |node|
            result.include?(node) ? next : (all_found =false; break)
          end
          expect(all_found).to be true
          expect(result.size).to eq 2
        end
      end

      context "I have one result at depth of 3" do
        let(:depth) {2}
        before(:each) do
          Related::Relationship.create(:fencing, @konn5, Related.root)
        end

        it "should find all connections with a certain skill up to the specfied depth" do
          result = @user1.find_connected_by_topic(:fencing, depth)
          expected = [@eleonora, @konn5]
          all_found = true
          expected.each do |node|
            result.include?(node) ? next : (all_found =false; break)
          end
          expect(all_found).to be false
          expect(result.size).to eq 1
        end
      end
    end

    private

    def create_graph

      @user1=UserAsNode.create(:user_id => 1000, :name => "Herby")
      @marek= UserAsNode.create(:user_id => 1, :name => "Marek")
      @sudesh= UserAsNode.create(:user_id => 2,:name => "Sudesh")
      @miguel= UserAsNode.create(:user_id => 3,:name => "Miguel")
      @damir= UserAsNode.create(:user_id => 4,:name => "Damir")
      @eleonora= UserAsNode.create(:user_id => 5,:name => "Eleonora")
      @kevin= UserAsNode.create(:user_id => 6,:name => "Kevin")
      @sebastian= UserAsNode.create(:user_id => 7,:name => "Sebastian")
      @konn1= UserAsNode.create(:user_id => 8,:name => "Konn1")
      @konn2= UserAsNode.create(:user_id => 9,:name => "Konn2")
      @konn3= UserAsNode.create(:user_id => 10,:name => "Konn3")
      @konn4= UserAsNode.create(:user_id => 11,:name => "Konn4")
      @konn5= UserAsNode.create(:user_id => 12,:name => "Konn5")
      @konn6= UserAsNode.create(:user_id => 13,:name => "Konn6")



      SocialGraph::Relationship.add_friend(@user1,@sudesh)
      SocialGraph::Relationship.add_friend(@user1,@kevin)
      SocialGraph::Relationship.add_friend(@user1,@konn1) # can reach directly
      SocialGraph::Relationship.add_friend(@user1,@marek)

      SocialGraph::Relationship.add_friend(@marek,@damir)
      SocialGraph::Relationship.add_friend(@marek,@kevin)
      SocialGraph::Relationship.add_friend(@marek,@konn2) # can reach konn2 in 1 hop through marek

      SocialGraph::Relationship.add_friend(@konn1,@konn3) #can reach in 1 hop through  konn1

      SocialGraph::Relationship.add_friend(@kevin,@sebastian) 

      SocialGraph::Relationship.add_friend(@damir,@miguel)
      SocialGraph::Relationship.add_friend(@damir,@eleonora)
      SocialGraph::Relationship.add_friend(@damir,@konn3) #I can reach konn3 in 2 hops through marek then damir


      SocialGraph::Relationship.add_friend(@eleonora,@konn5)

      SocialGraph::Relationship.add_friend(@konn5,@konn6)

      SocialGraph::Relationship.add_friend(@konn4,@konn6)
    end
  end
end
