module SocialGraph
  class Membership
    def self.add_to_social_graph user
      node = UserAsNode.create(:user_id => user.id, :name => user.name)
      user.update_column(:node_id, node.id)
      node
    end

    def self.remove_node_for_user user
      node = get_user_node(user)
      node.destroy
    end

    def self.get_user_node user
      begin
        Related::Node.find(user.node_id, :model => lambda {|attributes| attributes['user_id'] ? UserAsNode : Related::Node })
      rescue Related::NotFound
        #Should never get here
      end
    end
  end
end
