module SocialGraph
  module Navigator

    def traverse(depth, graph={}, origin=nil)
      graph[self.id]=friends_array
      if depth > 0

        friends_array.each do |friend|
          graph = init_friend_sub_graph(friend, graph)
          friend.traverse(depth-1, graph)
        end
      end

      return graph
    end

    def init_friend_sub_graph friend, graph
      unless friend_sub_graph_exists? friend, graph
        graph[friend.id] = friend.friends_array.delete(self)
      end
      graph
    end

    def friend_sub_branch_exists? friend, graph
      graph.key?(friend.id)
    end

    def init_graph
      {self.id => friends_array}
    end

    def graph_from node
      graph = {}
      graph[node.id] = node.friends_array
      graph
    end

    def find_connected_by_topic(topic, depth=5)
      graph = traverse(depth)
      keys = graph.keys.uniq.flatten
      keys.map do |key|
        node = Related::Node.find(key)
        if node
          topic_node = find_topic_node(node)
          find_node_by_key node
        end
      end.compact
    end

    def find_topic_node
      Related.root.incoming(topic).find(node)
    end

    def find_user_node node 
      Related::Node.find(node.id, :model => lambda {|attributes| attributes['user_id'] ? UserAsNode : Related::Node })
    end

    # Print connections within a certain depth.
    # First bruteforces a topology
    def print_connected(depth = 1)
      graph = traverse(depth)

      graph.keys.each do |key|
        if key == self.id
          next
        end
        puts "incoming  #{friends.shortest_path_to(Related::Node.find(key)).to_a.map(&:name)}"
      end
    end

    def friends_array
      @friends_array ||=self.friends.to_a
    end

    private
    class FriendGraph
       def initialize root_node

       end
    end

  end
end
