FROM jupyter/scipy-notebook

RUN mkdir app
RUN mkdir app/model
WORKDIR app
ENV MODEL_DIR=/home/jovyan/app/model
ENV MODEL_FILE_LDA=clf_lda.joblib
ENV MODEL_FILE_NN=clf_nn.joblib

COPY . .
RUN pip install -r requirements.txt 
RUN python3 train.py
