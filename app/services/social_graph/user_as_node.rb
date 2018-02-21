require 'related/follower'

module SocialGraph

  class UserAsNode < Related::Node
    include Related::Follower

    validates_presence_of :user_id

    def destroy_friendship(rel)
      rel.destroy
    end

    # Overrides the friends method ind Related::Follower
    def friends
      inbound.union(outbound)
    end

    def friends_with?(other)
      friends.include?(other)
    end

    def blocks?(other)
      outgoing(:block).find(other)
    end

    #TODO figure out why these don't work
    def follower_ids
      followers.map(&:user_id)
    end

    def following_ids
      following.map(&:user_id)
    end

    def friend_ids
      friends.map(&:user_id)
    end

    def aquaintance?(other)
      path = path_to(other).outgoing(:friend).depth(3)
      path.to_a.count.between?(1, ::AQUAINTANCE_DEPTH + 1) #array returns the destination path as part of result to add +1 depth
    end

    private

    def inbound
      incoming(:friend)
    end

    def outbound
      outgoing(:friend)
    end
  end
end
