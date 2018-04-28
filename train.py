# Given start and end year, train word2vec on the docs during that time
# TODO
from dataset import DataLoader
import logging
from gensim.models import word2vec
import click

@click.command()
@click.argument('start-year')
@click.argument('end-year')
def train(start_year, end_year):
    print('about to train on documents between ' + str(start_year) + ' and ' + end_year)
    loader = DataLoader('./data', start_year, end_year)

    logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)
    model = word2vec.Word2Vec(loader, iter=10, min_count=10, size=300, workers=4)

    filename = './model-' + start_year + '-' + end_year
    model.save(filename)
    print('saved model to ' + filename)

if __name__ == '__main__':
    train()
