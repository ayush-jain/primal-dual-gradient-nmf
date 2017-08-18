import gzip 
import simplejson 
from time import time
import sys

from sklearn.feature_extraction.text import TfidfVectorizer, CountVectorizer
from sklearn.decomposition import NMF, LatentDirichletAllocation
from sklearn.datasets import fetch_20newsgroups
import numpy as np

entry = []

def parse(filename): 
    f = gzip.open(filename, 'r') 
    i=0
    for l in f: 
        l = l.strip()
        colonPos = l.find('review/text:') 
        if colonPos == -1: 
			continue 

        rest = l[colonPos+13:] 
        #print(rest)
        entry.append(rest)
	i=i+1
	if(i==500):
		break
 

#for e in parse("Software.txt.gz"): 
	#for each in e:
		#print each
		#print "\n"




n_features = 500


def print_top_words(model, feature_names, n_top_words,A):
    count=0;
    for topic_idx, topic in enumerate(model.components_):
        print("Topic #%d:" % topic_idx)
        print(" ".join([feature_names[i]
                        for i in topic.argsort()[:-n_top_words - 1:-1]]))
	B=[feature_names[i]
                        for i in topic.argsort()[:-n_top_words - 1:-1]]
	max1 = 0;
	i=1	
	for text in entry:
		count = 0
		#if(i==19):
		#	print text
		#if(i==384):
		#	print text
		i=i+1
		for each in B:
			#print text			
			if each in text:
				count=count+1
		#print count		
		if(count>max1):
			max1=count	
	print("hey------\n")	
	print(max1)					 
    print('---------------endoftopic\n\n')

#dataset = fetch_20newsgroups(shuffle=True, random_state=1,remove=('headers', 'footers', 'quotes'))
#data_samples = dataset.data[:2]

#tf_vectorizer = CountVectorizer(max_features=n_features,stop_words='english')
tfidf_vectorizer = TfidfVectorizer(sublinear_tf=True, max_df=0.5,
                                 stop_words='english', max_features=n_features)

parse("Software.txt.gz")

#print(entry[0])

tf = tfidf_vectorizer.fit_transform(entry)

vocab = np.array(tfidf_vectorizer.get_feature_names())

print(vocab)
A= tf.todense()

#print(A)
#for row in A:
#	for each in row:
#		sys.stdout.write(str(each))
#	print()
#A = A.tolist()
#A = A[0:2]

A = tf.toarray()
A = A[0:500]
np.savetxt('data4500.txt', A, delimiter=' ') 
