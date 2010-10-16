require 'strange_loop_tweets'
require 'tweep_extraction'
require 'tweep_connection_data_creation'

tweets = get_strangeloop_tweets
tweeps = get_all_tweeps_referenced_in tweets
tweep_edges = get_tweep_connections_from tweets
create_protovis_data_from tweeps, tweep_edges