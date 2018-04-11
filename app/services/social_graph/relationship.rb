module SocialGraph
  module Relationship
    class << self
      def create_friendship_if_none_exists(resource)
        return if resource.specialist.friends_with?(resource.user)

        add_friend(resource.user, resource.specialist)
        add_friend(resource.specialist, resource.user)
      end

      def establish_following_relationship(resource)
        specialist = resource.specialist
        user = resource.user
        user.follow(specialist) unless (user.follows?(specialist) || user.blocks?(specialist))
      end

      def add_friend(from, to)
        Related::Relationship.create(:friend, from, to)
      end

      def is_aquainted_with?(from, other)
        path = from.path_to(other).outgoing(:friend).depth(3)
        path.to_a.count.between?(1, ::AQUAINTANCE_DEPTH + 1) #array returns the destination path as part of result to add +1 depth
      end

      def block(from, to)
        Related::Relationship.create(:block, from, to)
      end
    end
  end
end
