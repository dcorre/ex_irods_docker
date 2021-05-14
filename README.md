This docker file allows to install the iRODS CLI tools using a Ubuntu 18.04 image.

The reason is that binary distributions do not seem to be provided for Ubuntu 20.04.

For this example only `irods-runtime` and `irods-icommands` are installed. Other available binaries are listed [here](https://irods.org/download/).

Usage
-----

Prerequisites: git and docker are installed on your machine.   

Clone or download this project.   

First edit the `.irods/irods_environment.json` with your username. And other information depending on your needs and account.

Then build the docker image:
```shell
docker build --tag=irods:0.1 -f Dockerfile .
```

Run it in a deteached mode, with the name `irods`:
```shell
docker run --name irods -dit irods:0.1
```

This is just for illustration purpose, if you need to exchange data you need to mount a volume using the `-v` option:

```shell
docker run --name irods -dit -v /your_local_path_to_data/:/home/usr/data/ irods:0.1
```


Then you can either enter the docker container to type the irods commands:
```shell
docker container attach irods
```

Type `ctrl-p`+`ctrl-q` to exit.

And then initialise iRODS server wit:

```shell
iinit
```

Your password will be asked. Then you can use iRODS CLI commands.


If you need to stop the container:
```shell
docker stop irods
```

If you need to remove it, in order to run a new one with the same name for instance:
```shell
docker rm irods
```
