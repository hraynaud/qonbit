module SocialGraph
  class UserToNodeAdapter

    def initialize user
      @user_node = user.as_node
    end

    def add_friend(other_user)
      @user_node.add_friend(other_user)
    end

    def friends_with?(other_user)
      @user_node.friends_with?(other_user.as_node)
    end

    def follows?(other_user)
      @user_node.follows?(other_user.as_node)
    end

    def follow(other_user)
      @user_node.follow!(other_user.as_node)
    end

    def unfollow(other_user)
      @user_node.unfollow(other_user.as_node)
    end

    def blocks?(other_user)
      @user_node.blocks?(other_user.as_node)
    end

    #Unfollows and then blocks
    def block(other_user)
      @user_node.unfollow(other_user.as_node)
      @user_node.block(other_user.as_node)
    end

    def friends
      users_from friend_nodes
    end

    def following
      users_from following_nodes
    end

    def followers
      users_from follower_nodes
    end

    private

    def friend_nodes
      @user_node.friends
    end

    def follower_nodes
      @user_node.followers
    end

    def following_nodes
      @user_node.following
    end

    def users_from nodes
      User.where(id: pull_user_ids(nodes))
    end

    def pull_user_ids list
      list.to_a.map(&:user_id)
    end

  end
end
