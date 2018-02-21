module SocialGraph

  class UserFromNode

    class << self
      def user_by node
        find_users_for(node.id).first
      end

      def friends_by node
        find_users_for node.friend_ids
      end

      def find_users_for node_ids
        User.where(id: node_ids)
      end
    end
  end
end
