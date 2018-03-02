require 'related/follower'

module SocialGraph

  class UserAsNode < Related::Node
    include Related::Follower

    validates_presence_of :user_id

    def add_friend(other)
      RELATIONSHIP.create(:friend, self, other)
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

    def follows?(other)
      follows?(other)
    end

    def follow(other)
      follow!(other)
    end

    def unfollow(other)
      unfollow(other)
    end

    #TODO verify if the relationshp  needs ot be destroyed first

    def block(from, to)
      Related::Relationship.create(:block, from, to)
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
