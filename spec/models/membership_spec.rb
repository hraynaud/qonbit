require 'rails_helper'
require 'social_graph'
module SocialGraph
  RSpec.describe Membership do
    let(:user){FactoryBot.create(:valid_user)}

    describe ".add_to_social_graph" do
      it "maps the user to user node in the graph" do
        User.skip_callback(:create, :after, :add_to_social_graph)
        node = Membership.add_to_social_graph user
        User.set_callback(:create, :after, :add_to_social_graph)
        expect(node.user_id).to eql(user.id)
        expect(user.node_id).to eql(node.id)
      end
    end

    describe ".remove_node_for_user" do
      it "removes the node in the graph for the user" do
        Membership.remove_node_for_user user
        expect(user.as_node).to be_nil
      end
    end

    describe ".get_user_node" do
      it "finds the node in the graph for the user" do
        node = Membership.get_user_node user
        expect(node).to_not be_nil
      end

      it "finds the node in the graph for the user" do
        user = double(node_id: "abcdefg")
        node = Membership.get_user_node user
        expect(node).to be_nil
      end
    end

  end
end
