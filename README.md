# ubuntu-terraform
Ubuntu terraform docker image with ibm cloud cli


If you are like me, and you go to Ikea to build stuff follow the below steps;
otherwise just run the following command from the CMD or Shell (provided you installed `docker`)

```sh
docker run -ti blumareks/terraform-ibmcloud:1.0.0 /bin/bash
```

## download this repo
lets start with the steps

```sh
git clone https://github.com/blumareks/ubuntu-terraform
cd ubuntu-terraform
```

## install docker
install `Docker Desktop` from the following url: https://www.docker.com/get-started/
- optionally you can also use plain `podman` or `docker`

## run and use the image 
first `docker` run will download the main image (ubuntu linux)
test it first from `CMD` terminal (so it downloads ubuntu)

```sh
D:\corp\ubuntu-terraform>docker run ubuntu echo test
```
This should run a latest image of ubuntu, and then run inside of it the command echo, with a parameter test - so basically we will see the results `test`, after that the container will exit to a regular prompt.

The result should be something like this:

```
D:\corp\ubuntu-terraform>docker run ubuntu echo test
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
ff65ddf9395b: Pull complete
Digest: sha256:d4f6f70979d0758d7a6f81e34a61195677f4f4fa576eaf808b79f17499fd93d1
Status: Downloaded newer image for ubuntu:latest
test

D:\corp\ubuntu-terraform>
```

The second run won't download it supposedly - you would only see the result: `test`


## build the image
Now as the image is downloaded and the Docker Desktop running you can build your image for terraform and ibm cloud cli:

(use your "docker login" instead of blumareks)

you should be in the `ubuntu-terraform` directory (check with `dir` or `pwd` (in Shell) command)

```sh
docker build -t blumareks/terraform-ibmcloud:0.0.1 .
```

Finally you can run the image:
```sh
docker run -ti blumareks/terraform-ibmcloud:0.0.3 /bin/bash
root@2c05157a4b9d:/# ls
LICENSE.txt  dev                              home   media  proc  sbin  terraform_1.9.8_linux_amd64.zip  var
bin          elasticsearch-kibana-codeengine  lib    mnt    root  srv   tmp
boot         etc                              lib64  opt    run   sys   usr
root@2c05157a4b9d:/# cd elasticsearch-kibana-codeengine/
root@2c05157a4b9d:/elasticsearch-kibana-codeengine# ls
LICENSE  README.md  terraform  terraform.tfvars
root@2c05157a4b9d:/elasticsearch-kibana-codeengine# nano terraform.tfvars
```

edit your terraform.tfvars file


Now edit the fields:
```sh
 ibmcloud_api_key = "<your_api_key_from_step_1>"
 region = "<IBM region to deploy the Code Engine application>"
 es_host = "<the hostname of your elasticsearch deployment>"
 es_port = "<the port number  of your elasticsearch deployment>"
 es_username = "<the username of your elasticsearch deployment>"
 es_password = "<the password of your elasticsearch user>"
```
when you are done press `^X` (ie. ctrl+X) and save it

and then check once more the file and then run the last two commands:
```sh
cat terraform.tfvars

terraform init 
terraform apply --auto-approve
```

