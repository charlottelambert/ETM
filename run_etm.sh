#!/bin/bash

set -e
# cd scripts
# python3 data_ob.py /work/clambert/thesis-data/sessionsAndOrdinarys-txt-tok
# cd ..
export CKPT_PATH=./results/sessionsAndOrdinarys-txt-tok/etm_min_df_0_max_df_1.0_K_30_Htheta_800_Optim_adam_Clip_0.0_ThetaAct_relu_Lr_0.005_Bsz_1000_RhoSize_300_trainEmbeddings_1

python3 main.py --mode train --dataset min_df_0_max_df_1.0 --data_path ./scripts/sessionsAndOrdinarys-txt-tok/min_df_0_max_df_1.0 --num_topics 30 --train_embeddings 1 --epochs 1000
python3 main.py --mode eval --dataset min_df_0_max_df_1.0 --data_path ./scripts/sessionsAndOrdinarys-txt-tok/min_df_0_max_df_1.0 --num_topics 30 --train_embeddings 1 --tc 1 --td 1 --load_from $CKPT_PATH --write_neighbors=1

export CKPT_PATH=./results/OB_LL-txt-tok/etm_min_df_0_max_df_1.0_K_30_Htheta_800_Optim_adam_Clip_0.0_ThetaAct_relu_Lr_0.005_Bsz_1000_RhoSize_300_trainEmbeddings_1

python3 main.py --mode train --dataset min_df_0_max_df_1.0 --data_path ./scripts/OB_LL-txt-tok/min_df_0_max_df_1.0 --num_topics 30 --train_embeddings 1 --epochs 1000
python3 main.py --mode eval --dataset min_df_0_max_df_1.0 --data_path ./scripts/OB_LL-txt-tok/min_df_0_max_df_1.0 --num_topics 30 --train_embeddings 1 --tc 1 --td 1 --load_from $CKPT_PATH --write_neighbors=1

export CKPT_PATH=./results/sessionsAndOrdinarys-txt-tok-bi/etm_min_df_0_max_df_1.0_K_30_Htheta_800_Optim_adam_Clip_0.0_ThetaAct_relu_Lr_0.005_Bsz_1000_RhoSize_300_trainEmbeddings_1

python3 main.py --mode train --dataset min_df_0_max_df_1.0 --data_path ./scripts/sessionsAndOrdinarys-txt-tok-bi/min_df_0_max_df_1.0 --num_topics 30 --train_embeddings 1 --epochs 1000
python3 main.py --mode eval --dataset min_df_0_max_df_1.0 --data_path ./scripts/sessionsAndOrdinarys-txt-tok-bi/min_df_0_max_df_1.0 --num_topics 30 --train_embeddings 1 --tc 1 --td 1 --load_from $CKPT_PATH --write_neighbors=1

export CKPT_PATH=./results/sessionsAndOrdinarys-txt-tok-bi-tng/etm_min_df_0_max_df_1.0_K_30_Htheta_800_Optim_adam_Clip_0.0_ThetaAct_relu_Lr_0.005_Bsz_1000_RhoSize_300_trainEmbeddings_1

python3 main.py --mode train --dataset min_df_0_max_df_1.0 --data_path ./scripts/sessionsAndOrdinarys-txt-tok-bi-tng/min_df_0_max_df_1.0 --num_topics 30 --train_embeddings 1 --epochs 1000
python3 main.py --mode eval --dataset min_df_0_max_df_1.0 --data_path ./scripts/sessionsAndOrdinarys-txt-tok-bi-tng/min_df_0_max_df_1.0 --num_topics 30 --train_embeddings 1 --tc 1 --td 1 --load_from $CKPT_PATH --write_neighbors=1
