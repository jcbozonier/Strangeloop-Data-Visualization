require 'json'

def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r") 
  f.each_line do |line|
    data += line
  end
  return data
end

def get_strangeloop_tweets
  text_file_containing_tweets = 'formatted_tweets.json'
  raw_json_text = get_file_as_string text_file_containing_tweets
  tweets = JSON.parse(raw_json_text)
  
  tweets
end