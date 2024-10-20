# by  Marek Sadowski 20241020
# Use the latest Ubuntu LTS as the base image
FROM ubuntu

# Install ddependencies for Terraform.
RUN apt update \
    && apt install -y wget \
    && apt install -y curl \
    && apt install -y unzip \
    && apt install -y vim \
    && apt install -y openssh-client \
    && apt install -y git \
    && git clone https://github.com/IBM/elasticsearch-kibana-codeengine.git 

# Download the latest version of Terraform from the official website
RUN wget https://releases.hashicorp.com/terraform/1.9.8/terraform_1.9.8_linux_amd64.zip

# Unzip the downloaded file:
RUN unzip terraform_1.9.8_linux_amd64.zip

# Move the terraform binary to a directory in your system's PATH.
RUN mv terraform /usr/local/bin/

# Verify that Terraform is installed by checking its version:
RUN terraform version

# IBM Cloud CLI download
RUN curl -fsSL https://clis.cloud.ibm.com/install/linux | sh

# Verify the installation
RUN ibmcloud help \
    && apt install -y nano \
    && rm terraform_1.9.8_linux_amd64.zip

COPY terraform.tfvars ./elasticsearch-kibana-codeengine

# Install  kubectr
RUN curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg \
    && echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list \
    && apt update \
    && apt install -y kubectl \
    && kubectl version --output=yaml

