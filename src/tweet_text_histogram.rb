
def parsed_words_from text
  word_list = []
  demarcating_characters = [",", ".", "\"", "'", ";", "\n", "\r", "[", "]", "{", "}", "", " ", "(", ")", ":"]
  
  current_word = ""
  text.each_char{|this_character|
    if not demarcating_characters.include? this_character
      current_word += this_character
    else
      word_list.push current_word.downcase if current_word.length > 0 and current_word != "&quot"
      current_word = ""
    end
  }
  return word_list
end

def create_histogram_from tweets
  tweet_corpus = {}
  unimportant_list = %w{their didn't about would really going that's there &amp; this}
  
  
  tweets.each{|tweet|
    tweet_text = tweet['text']
    
    words_in_tweet = parsed_words_from(tweet_text)
    
    words_in_tweet.each{|word|
      next if word == nil or word.length < 5
      
      next if unimportant_list.include? word
      
      if tweet_corpus.key? word
        tweet_corpus[word] += 1
      else
        tweet_corpus[word] = 1
      end
    }
  }
  
  tweet_corpus
end