FROM ubuntu:16.04
MAINTAINER Paul Manninger, paul.manninger@inspection.gc.ca

#Environmental Variables/Paths
ENV DEBIAN_FRONTEND interactive
ENV PATH="/centrifuge/:${PATH}"
ENV PATH="/ncbi-blast/bin:${PATH}"
ENV TERM=xterm

RUN apt-get update -y
RUN apt-get install -y build-essential
RUN apt-get install -y wget 
RUN apt-get install -y zip
RUN apt-get install -y bash
RUN apt-get install -y python
		
#Download Centrifuge
RUN wget ftp://ftp.ccb.jhu.edu/pub/infphilo/centrifuge/downloads/centrifuge-1.0.3-beta-Linux_x86_64.zip
RUN unzip centrifuge-1.0.3-beta-Linux_x86_64.zip -d /
RUN mv centrifuge-1.0.3-beta centrifuge
RUN rm centrifuge-1.0.3-beta-Linux_x86_64.zip

#Download NCBI-Blast - Required for centrifuge-download
RUN wget ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/ncbi-blast-2.6.0+-x64-linux.tar.gz
RUN tar -xvzf ncbi-blast-2.6.0+-x64-linux.tar.gz
RUN mv ncbi-blast-2.6.0+ ncbi-blast
RUN rm ncbi-blast-2.6.0+-x64-linux.tar.gz

#Centrifuge Indexes
RUN export TERMINFO=/usr/lib/terminfo
RUN centrifuge-download -o taxonomy taxonomy
RUN centrifuge-download -o library -m -d "bacteria" refseq > seqid2taxid.map

#Build Index
RUN cat library/*/*.fna > input-sequences.fna
## build centrifuge index with 4 threads
centrifuge-build -p 4 --conversion-table seqid2taxid.map \
                 --taxonomy-tree taxonomy/nodes.dmp --name-table taxonomy/names.dmp \
                 input-sequences.fna abv
