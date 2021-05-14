######
# To build it, place yourself in iRODS directory:
#    docker build --tag=irods:0.1 -f Dockerfile .
#
# To run it:
# - launch a container in background with (you can change the name as you please):
#    docker run --name irods -dit irods:0.1

# - then execute command line inside the container with:
#    docker exec irods ls
#    docker exec irods iinit
#    docker exec irods ils
######

FROM ubuntu:18.04

MAINTAINER David Corre <corre@iap.fr>

# Create user
ENV USR usr

RUN useradd -m ${USR} || :

RUN  \
   apt-get update \
   && apt-get install -y wget lsb-core \
   && wget -qO - https://packages.irods.org/irods-signing-key.asc | apt-key add - \
   && echo "deb [arch=amd64] https://packages.irods.org/apt/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/renci-irods.list \
   && apt-get update \
   && apt-get install -y irods-runtime irods-icommands vim \
   && rm -rf /var/lib/apt/lists/*


WORKDIR /home/${USR}/

COPY .irods .irods

# change ownership from root to USR
RUN chown -R ${USR}:${USR}  /home/${USR} 

# switch ownership
# (all commands are root until a USER command changes that)
USER ${USR}:${USR}   

# create a data directory that will be used to share volume with host machine
RUN \
    mkdir data

# define entrypoint which is the default executable at launch
ENTRYPOINT ["bash"]
