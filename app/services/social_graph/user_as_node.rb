require 'related/follower'

module SocialGraph

  class UserAsNode < Related::Node
    include Related::Follower
    include Navigator
    validates_presence_of :user_id

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

    def acolytes
      inbound
    end

    def idols
      outbound
    end

    def traverse_graph
    end

    #TODO verify if the relationshp  needs ot be destroyed first

    private

    

    def inbound
      incoming(:friend)
    end

    def outbound
      outgoing(:friend)
    end
  end
end
