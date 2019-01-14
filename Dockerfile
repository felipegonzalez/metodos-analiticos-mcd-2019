FROM rocker/verse:3.5.1

RUN cat /etc/os-release 

RUN apt-get update \ 
    && apt-get install -y libudunits2-dev 

RUN \
  apt-get update && \
  apt-get install -y build-essential libssl-dev libffi-dev python3 python3-dev && \
  apt-get install -y python3-pip 
  
RUN \
  pip3 install --upgrade tensorflow && \
  pip3 install --upgrade keras scipy h5py pyyaml requests Pillow pandas matplotlib


RUN r -e 'devtools::install_github("rstudio/sparklyr")'
RUN r -e 'sparklyr::spark_install(version = "2.1.0")'

RUN mkdir /home/rstudio/.cache \
  && mv /root/spark/ /home/rstudio/.cache \
  && chown -R rstudio:rstudio /home/rstudio/.cache
ENV RSTUDIO_SPARK_HOME /home/rstudio/.cache/spark/spark-2.1.0-bin-hadoop2.7

RUN r -e 'devtools::install_github("bmschmidt/wordVectors")'
Run r -e 'devtools::install_github("kevinykuo/sparklygraphs")'

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