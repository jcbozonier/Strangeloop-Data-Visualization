Edge = Struct.new(:from, :to)

def get_tweep_connections_from tweets
  tweep_edges = {}
  tweets.each{ |tweet|
    tweep = tweet['from_user']
    to_nodes = extract_all_tweeps_from tweet
    
    if to_nodes.length > 0
      to_nodes.each{ |node|
        raise "node is blank!!" if node == ''
        edge_a = Edge.new(tweep, node)
        edge_b = Edge.new(node, tweep)

        if tweep_edges.has_key? edge_a 
          tweep_edges[edge_a] += 1
        elsif tweep_edges.has_key? edge_b
          tweep_edges[edge_b] += 1
        else
          tweep_edges[edge_a] = 1
        end
      }
    end
  }
  
  return tweep_edges
end

def create_protovis_data_from tweeps, tweep_edges
  counter = 0
  tweep_index_lookup = {}

  File.open('strangeloop_words.js', 'w'){|file|
    file.puts 'var miserables = {'
    file.puts 'nodes:['
    
    tweeps.each{|tweep|
      tweep_index_lookup[tweep] = counter
      file.puts "{nodeName:\"#{tweep}\", group:1}, //#{tweep_index_lookup[tweep]}"
      counter += 1
    }
    
    file.puts '],'
    file.puts 'links:['
    
    tweep_edges.each{ |edge, strength|
      from_tweep = edge[:from]
      to_tweep = edge[:to]
      
      raise "bad to tweep!!" if not tweep_index_lookup.include? to_tweep
      raise "bad to tweep!!" if not tweep_index_lookup.include? from_tweep
      
      from_index = tweep_index_lookup[from_tweep]
      to_index = tweep_index_lookup[to_tweep]
      
      file.puts "{source:#{from_index}, target:#{to_index}, value: #{(2)**strength}},"
    }
    
    file.puts ']};'
  }
end