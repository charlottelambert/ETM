# ETM

This repository is a fork of code accompanying the paper titled "Topic Modeling in Embedding Spaces" by Adji B. Dieng, Francisco J. R. Ruiz, and David M. Blei. (Arxiv link: https://arxiv.org/abs/1907.04907). The code is adapted to work with the Proceedings of Old Bailey in [this](https://github.com/charlottelambert/thesis) project.

note: if using TSV files, might need a text version of tsv file. This code won't do it. Need code from D-ETM repository [here](https://github.com/charlottelambert/DETM). See the `README.md` for instructions on generating a TSV file of the data.

## Steps to run

All the following steps are intended to be run on the TSV data representation of the Proceedings of Old Bailey. Go [here](https://github.com/charlottelambert/thesis/data) to see information about obtaining this data.

First, generate an embeddings file from the TSV corpus. The `TSV_CORPUS` input should be just the name of the tsv file, e.g., `sessionsAndOrdinarys-txt-tok.tsv`, not the full path. Include the full path in the `--data_file` argument.
```
data_path=TSV_CORPUS
CUDA_DEVICES=3 python3 skipgram.py \
  --data_file PATH_TO_CORPUS/$data_path-proc \
  --emb_file data/$data_path-embed \
  --dim_rho 100 --iters 50 --window_size 4
```

This will save an embedding file to `data/$data_path-embed` which will be used as input in the following step.

Next, using the same `TSV_CORPUS`, run the following commands:

```
data_path=TSV_CORPUS
min_df=50
max_df=0.9
num_topics=55
epochs=300
lr=0.004

mkdir -p results/$data_path

CUDA_VISIBLE_DEVICES=0 python3 main.py \
    --mode train \
    --dataset ob  \
    --data_path ~/detm/scripts/$data_path/min_df_$min_df\_max_df_$max_df\ \
    --num_topics $num_topics \
    --emb_path ~/detm/data/$data_path-embed \
    --epochs $epochs \
    --emb_size 100 \
    --rho_size 100 \
    --tc 1 \
    --td 1 \
    --lr $lr  \
    > results/$data_path/min_df_$min_df\_max_df_$max_df\_t_$num_topics\_epochs_$epochs\_lr_$lr.log
```

This will train an ETM model and save results to `results/$data_path` along with the log file.

## Original Documentation

All the below information is included in the documentation of the original repository for ETM.

### Explanation

ETM defines words and topics in the same embedding space. The likelihood of a word under ETM is a Categorical whose natural parameter is given by the dot product between the word embedding and its assigned topic's embedding. ETM is a document model that learns interpretable topics and word embeddings and is robust to large vocabularies that include rare words and stop words.

### Dependencies

+ python 3.6.7
+ pytorch 1.1.0

### Datasets

All the datasets are pre-processed and can be found below:

+ https://bitbucket.org/franrruiz/data_nyt_largev_4/src/master/
+ https://bitbucket.org/franrruiz/data_nyt_largev_5/src/master/
+ https://bitbucket.org/franrruiz/data_nyt_largev_6/src/master/
+ https://bitbucket.org/franrruiz/data_nyt_largev_7/src/master/
+ https://bitbucket.org/franrruiz/data_stopwords_largev_2/src/master/ (this one contains stop words and was used to showcase robustness of ETM to stop words.)
+ https://bitbucket.org/franrruiz/data_20ng_largev/src/master/

All the scripts to pre-process a given dataset for ETM can be found in the folder 'scripts'. The script for 20NewsGroup is self-contained as it uses scikit-learn. If you want to run ETM on your own dataset, follow the script for New York Times (given as example) called data_nyt.py  

### To Run

To learn interpretable embeddings and topics using ETM on the 20NewsGroup dataset, run
```
python main.py --mode train --dataset 20ng --data_path data/20ng --num_topics 50 --train_embeddings 1 --epochs 1000
```

To evaluate perplexity on document completion, topic coherence, topic diversity, and visualize the topics/embeddings run
```
python main.py --mode eval --dataset 20ng --data_path data/20ng --num_topics 50 --train_embeddings 1 --tc 1 --td 1 --load_from CKPT_PATH
```

To learn interpretable topics using ETM with pre-fitted word embeddings (called Labelled-ETM in the paper) on the 20NewsGroup dataset:

+ first fit the word embeddings. For example to use simple skipgram you can run
```
python skipgram.py --data_file PATH_TO_DATA --emb_file PATH_TO_EMBEDDINGS --dim_rho 300 --iters 50 --window_size 4
```

+ then run the following
```
python main.py --mode train --dataset 20ng --data_path data/20ng --emb_path PATH_TO_EMBEDDINGS --num_topics 50 --train_embeddings 0 --epochs 1000
```

### Citation

```
@article{dieng2019topic,
  title={Topic modeling in embedding spaces},
  author={Dieng, Adji B and Ruiz, Francisco J R and Blei, David M},
  journal={arXiv preprint arXiv:1907.04907},
  year={2019}
}
```
