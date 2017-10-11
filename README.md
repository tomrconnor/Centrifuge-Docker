# Centrifuge-Docker
Docker container for Centrifuge

#Build
docker build -t centrifuge .
#RunServer
docker run -v /mnt/nas00:/mnt/nas00 -it centrifuge
#RunNormal
docker run -it centrifuge
#RunRemove
docker run --rm -it centrifuge
#Clean
docker rm -f $(docker ps -aq)

