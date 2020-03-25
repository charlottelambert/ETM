#!/bin/bash

set -e
cd scripts
python3 data_ob.py /work/clambert/thesis-data/sessionsAndOrdinarys-txt-tok
cd ..
export CKPT_PATH=./results/etm_min_df_10_K_30_Htheta_800_Optim_adam_Clip_0.0_ThetaAct_relu_Lr_0.005_Bsz_1000_RhoSize_300_trainEmbeddings_1

python3 main.py --mode train --dataset min_df_0 --data_path ./scripts/min_df_0 --num_topics 30 --train_embeddings 1 --epochs 1000
python3 main.py --mode eval --dataset min_df_0 --data_path ./scripts/min_df_0 --num_topics 30 --train_embeddings 1 --tc 1 --td 1 --load_from $CKPT_PATH --write_neighbors ./results/final_topics.txt
