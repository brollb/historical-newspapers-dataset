import os
from os import path
import tarfile
from gensim import utils
from gensim.summarization.textcleaner import get_sentences

class DataLoader(object):
    def __init__(self, dirname, start, end):
        self.dirname = dirname
        self.start = int(start)
        self.end = int(end)

    def __iter__(self):
        files = [ f for f in os.listdir(self.dirname) if path.isfile(path.join(self.dirname, f)) ]
        for f in files:
            print(f)
            with tarfile.open(path.join(self.dirname, f), 'r:bz2') as t:
                for info in t:
                    if '.txt' in info.name:
                        year = int(info.name.split('/')[1])
                        if self.start <= year and year <= self.end:
                            tf = t.extractfile(info)
                            document = tf.read()
                            for sentence in get_sentences(str(document)):
                                # Get the sentences
                                # This is pretty noisy data currently and could use
                                # some preprocessing
                                print(utils.simple_preprocess(sentence))
                                yield utils.simple_preprocess(sentence)
