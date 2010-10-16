#!/usr/bin/env python
# encoding: utf-8
"""
strangeloop_classify.py

Created by Hilary Mason on 2010-10-15.
Copyright (c) 2010 bit.ly. All rights reserved.
"""

import sys, os

import nltk
from nltk.tokenize import *

class StrangeParse(object):
    
    def __init__(self, filename):
        self.load_settings()
        
        f = open(filename, 'r')
        tweets = f.readlines()
        f.close()
        
        words = [w.lower().strip('.') for w in word_tokenize('\n'.join(tweets)) if w.lower() not in self.stop_words]
        words = [w for w in words if len(w) > 3]
        significant_words = [w for w, c in nltk.FreqDist(words).items() if c > 1]
        
        nodes = [] # name, group
        connections = [] # source, target, value
        
        nodes = [w for w in significant_words]
        
        for word in significant_words:
            for tweet in tweets:
                if word in tweet:
                    s = nodes.index(word)
                    for term in word_tokenize(tweet):
                        if term in significant_words:
                            if term != word:
                                t = nodes.index(term)
                                connections.append((s, t, 1))
                                
        nodes = [(n, 1) for n in nodes]
    
    def print_nodes(self, nodes):
        # {nodeName:"Babet", group:4},
        for nodename, group in nodes:
            print "{nodeName:\"%s\", group:%s}," % (nodename, group)
            
    def print_connections(self, connections):
        # {source:1, target:0, value:1},
        for s, t, v in connections:
            print "{source:%s, target:%s, value:%s}," % (s, t, v)
        
    def load_settings(self):
        # stopwords = nltk.corpus.stopwords.words('english') # TODO
        self.stop_words = ['#', '@', ':', ',', ';', 'the', 'rt', 'of', 'i', 'to', 'a', 'at', '&quot', 'on', 'and', "'s", 'for', 'is', 'in', 'you', '.', ')', 'my', '!', 'with', '(', 'http', '?', 'are', 'it', "n't", '-', 'we', 'if', '*', '--']
        
    

if __name__ == '__main__':
    s = StrangeParse("strangeloop")

