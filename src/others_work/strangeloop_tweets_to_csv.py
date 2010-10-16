import json, re

RE_MENTION = re.compile(r'@(\w+)')

f = open('formatted_tweets.json')
tweets = json.load(f)
f.close()

graph = {}

for tweet in tweets:
    from_user = tweet['from_user']
    for m in RE_MENTION.finditer(tweet['text']):
        to_user = m.group(0)[1:]

        pair1 = (from_user, to_user)
        pair2 = (to_user, from_user)

        if pair1 in graph:
            graph[pair1] += 1
        elif pair2 in graph:
            graph[pair2] += 1
        else:
            graph[pair1] = 1

for key, value in graph.items():
    print "%s, %s, %d" % (key[0], key[1], value)
