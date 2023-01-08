import numpy as np
import pandas as pd
import re
import nltk
nltk.download('punkt')
nltk.download('stopwords')
nltk.download('corpus')
from nltk import word_tokenize
import string
from flask_ngrok import run_with_ngrok
from flask import Flask
from flask import request
from flask import jsonify
from flask import json
from nltk.stem.porter import PorterStemmer
from nltk.stem import WordNetLemmatizer
nltk.download('wordnet')
nltk.download('omw-1.4')
from nltk.corpus import wordnet
nltk.download('averaged_perceptron_tagger')
from nltk.corpus import stopwords

app= Flask(__name__)



#@app.route('/maw',methods=['POST'])
#def index():
  #input=request.files['text']
  #with open('text.txt') as f:
   # lines = f.read()
  #low=lines.lower()
 # punc=remove_punctuation(low)
  #return "<h1>lines</h1>"

PUNCT_TO_REMOVE = string.punctuation
def remove_punctuation(aa):
    """custom function to remove the punctuation"""
    return aa.translate(str.maketrans('', '', PUNCT_TO_REMOVE))
  

 #Remove Panctuation
#PUNCT_TO_REMOVE = string.punctuation
#def remove_punctuation(text):
   # """custom function to remove the punctuation"""
   # aa=text.maketrans(' ', ' ', PUNCT_TO_REMOVE)
   # return text.translate(aa)

#Stemmatization
stemmer = PorterStemmer()
def stem_words(text):
    return " ".join([stemmer.stem(word) for word in text.split()])

#Lemmatization
lemmatizer = WordNetLemmatizer()
def lemmatize_words(text):
    return " ".join([lemmatizer.lemmatize(word) for word in text.split()])

lemmatizer = WordNetLemmatizer()
wordnet_map = {"N":wordnet.NOUN, "V":wordnet.VERB, "J":wordnet.ADJ, "R":wordnet.ADV}
def lemmatize_words2(text):
    pos_tagged_text = nltk.pos_tag(text.split())
    return " ".join([lemmatizer.lemmatize(word, wordnet_map.get(pos[0], wordnet.NOUN)) for word, pos in pos_tagged_text])

#Stopwords
STOPWORDS = set(stopwords.words('english'))
stopword={"is","are","be"}
def remove_stopwords(text):
    """custom function to remove the stopwords"""
    return " ".join([word for word in str(text).split() if word not in stopword])

@app.route('/yaw',methods=['POST'])
def index():
  finput=request.get_data(as_text=True)
  print(finput)
  low=finput.lower()
  PUNCT_TO_REMOVE = string.punctuation
  def remove_punctuation(aa):
    """custom function to remove the punctuation"""
    return aa.translate(str.maketrans('', '', PUNCT_TO_REMOVE))
  punc=remove_punctuation(low)
  print (punc)
  stemm=stem_words(punc)
  print (stemm)
  lemm=lemmatize_words(stemm)
  print(lemm)
  lemm2=lemmatize_words2(lemm)
  print(lemm2)
  stop=remove_stopwords(lemm2)
  print(stop)
  #input=finput('Text') 
  #low=input.lower()
  
  return json.dumps(stop)


##def index():
  input=str(request.args['query'])
  tokens = word_tokenize(input)
  low=tokens.lower()
  return low
  #return "Hello"
    
@app.route("/get_yaw")
def get_yaw():
  return "<h1>Yaaaaaw</h1>"  
@app.route("/hel")
def maw():
  return "<h1>Helloooooo</h1>"  
def hello():
    return jsonify({'Hello, World!'})
app.run()
