FROM ubuntu:16.04
MAINTAINER Paul Manninger, paul.manninger@inspection.gc.ca

RUN apt-get update && apt-get install -y \
		wget \
		zip  \
		
RUN \
wget ftp://ftp.ccb.jhu.edu/pub/infphilo/centrifuge/downloads/centrifuge-1.0.3-beta-source.zip
unzip centrifuge-1.0.3-beta-source.zip
cd centrifuge-1.0.3-beta
make USE_SRA=1 NCBI_NGS_DIR=~/centrifuge-1.0.3-beta/NCBI-NGS NCBI_VDB_DIR=~/centrifuge-1.0.3-beta/NCBI-NGS
