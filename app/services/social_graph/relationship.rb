module SocialGraph
  module Relationship
    class << self
      def create(from, to)
        Related::Relationship.create(:friend, from, to)
        Related::Relationship.create(:friend, to, from)
      end

      def block(from, to)
        Related::Relationship.create(:block, from, to)
      end
    end
  end
end
