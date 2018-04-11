module SocialGraph
  module Speciality
    class << self

      def register_skill_with_root_node(resource)
        topic = resource.symbolized_topic_name
        node = resource.specialist.as_node
        RELATIONSHIP.create(topic, node, Related.root) unless is_speciality_registered?(topic,node)
      end

      def is_speciality_registered?(topic, node)
        !(Related.root.incoming(topic).find(node).nil?)
      end

      def specialist_count(topic)
        Related.root.incoming(topic).relationships.count
      end
    end
  end
end
