import re

def analyze(sentence):
    loweredSentence = sentence.lower()
    wordList = list(filter(None, re.split('[.,!? ]', loweredSentence)))
    return wordList