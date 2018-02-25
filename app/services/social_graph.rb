module SocialGraph

  AQUAINTANCE_DEPTH = 3

  def self.add_node_for_user user
    node = UserAsNode.create(:user_id => user.id, :name => user.name)
    user.node_id = node.id
    save
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

  def graph_from node
    graph = {}
    graph[node.id] = node.friends.to_a
    graph
  end


  def traverse(graph, depth, origin=nil)
    if depth > 0
      connections = self.friends.to_a

      if (connections.include? origin)
        connections.delete origin
      end

      connections.each do |friend|
        if not graph.key?(friend.id)
          graph[friend.id] = friend.friends.to_a
        end

        friend.traverse(graph, depth-1, self)
      end
    end

    return graph
  end


  def find_connected_by_topic(origin_node, topic, depth=5)
    graph = init_graph origin_node 
    graph = traverse(graph, depth)
    keys = graph.keys.uniq.flatten
    res = []
    keys.each do |key|
      node = Related.root.incoming(topic).find(NODE.find(key))
      res << NODE.find(node.id,:model => lambda {|attributes| attributes['user_id'] ? UserAsNode : Related::Node }) unless node.nil?
    end

    res
  end

  # Print connections within a certain depth.
  # First bruteforces a topology
  def print_connected(depth = 1, filter = nil)
    # Reckon graph depending on depth

    graph = traverse(self.init_graph, depth)

    graph.keys.each do |key|
      if key == self.id
        next
      end
      puts "incoming  #{self.incoming(:friend).shortest_path_to(NODE.find(key)).to_a.map(&:name)}"
    end

  end


end
