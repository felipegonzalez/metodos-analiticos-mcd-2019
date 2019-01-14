FROM rocker/verse:3.5.1

ENV SPARK_VERSION 2.3.0 
ENV SPARKLYR_VERSION 0.8.4

RUN cat /etc/os-release 

RUN apt-get update \ 
    && apt-get install -y libudunits2-dev 

RUN r -e 'devtools::install_version("sparklyr", version = Sys.getenv("SPARKLYR_VERSION"))' 
RUN r -e 'sparklyr::spark_install(version = Sys.getenv("SPARK_VERSION"), verbose = TRUE)'

RUN mv /root/spark /opt/ && \
chown -R rstudio:rstudio /opt/spark/ && \
ln -s /opt/spark/ /home/rstudio/

RUN \
  apt-get update && \
  apt-get install -y build-essential libssl-dev libffi-dev python3 python3-dev && \
  apt-get install -y python3-pip 
  
RUN \
  pip3 install --upgrade tensorflow && \
  pip3 install --upgrade keras scipy h5py pyyaml requests Pillow pandas matplotlib

RUN r -e 'devtools::install_github("bmschmidt/wordVectors")'
RUN r -e 'devtools::install_github("kevinykuo/sparklygraphs")'

RUN install2.r --error \
    reticulate \
    tensorflow \
    keras \
    arules \
    arulesViz \
    tidygraph \
    tidytext \
    textreuse \
    hash \
    text2vec \
    ggraph \
    tm \
    tsne
