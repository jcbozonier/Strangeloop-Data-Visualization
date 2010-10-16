require 'net/http'

# WARNING! This will modify the json and could possibly break the project
# Make sure if you do this that you know how to get back to working data!

pages_remain = true
number = 1
file_containing_tweets = 'strangeloop_tweets.json'

while(pages_remain)
  open(file_containing_tweets, 'a') { |f|
    Net::HTTP.start("search.twitter.com") { |http|
      response = http.get("/search.json?q=%23strangeloop&rpp=100&page=#{number}")
      
      if response.body == '{"error":"page parameter out of range"}'
        pages_remain = false
      else
        f.puts response
        number += 1
      end
    }
  }
end