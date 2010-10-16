require 'strange_loop_tweets'
require 'tweet_text_histogram'

tweets = get_strangeloop_tweets

tweet_corpus = create_histogram_from tweets


sorted_pairs = tweet_corpus.sort { |left, right|
  -1 * ( left[1] <=> right[1])
}

counter = 0
sorted_pairs.each{|pair|
  puts "#{pair[0]}: #{pair[1]}" if counter <= 10
  counter += 1
}

puts "Total corpus count: #{sorted_pairs.length}"