def extract_all_tweeps_from tweet
  text_to_parse = tweet['text']
  tweeps = []
  
  halt_characters = ['@', ' ', '', '"', '\'', '.', '/', ':', '!', ')', '(', ',']
  
  parsing_tweep = false
  tweep_name = ''
  text_to_parse.each_char{|character|
    if parsing_tweep and halt_characters.include? character
      tweeps.push tweep_name if tweep_name != ''
      tweep_name = ''
      parsing_tweep = false
    end
    
    if parsing_tweep 
      tweep_name += character
    end
    
    if character == '@'
      parsing_tweep = true
    end
  }
  
  return tweeps
end

def get_all_tweeps_referenced_in tweets
  tweeps = []
  tweets.each{ |tweet|
    tweep = tweet['from_user']
    tweeps.push tweep if not tweeps.include? tweep
    
    to_nodes = extract_all_tweeps_from tweet
    to_nodes.each{|node|
      tweeps.push node if not tweeps.include? node
    }
  }
  return tweeps
end