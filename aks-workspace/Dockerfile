FROM python:3.12.0a6-slim-bullseye

RUN apt-get update
RUN apt-get install -y git dos2unix unzip npm wget curl iputils-ping


WORKDIR /app
COPY . /app

RUN pip install -r requirements.txt

WORKDIR /files
##############################################
### Docker CLI
#############################################
ARG docker_latest_version_file_arg="docker-23.0.2.tgz"  
ENV DOCKER_LATEST_VERSION_FILE=${docker_latest_version_file_arg}
RUN echo "Download => https://download.docker.com/linux/static/stable/x86_64/${DOCKER_LATEST_VERSION_FILE}"
RUN curl -fL https://download.docker.com/linux/static/stable/x86_64/${DOCKER_LATEST_VERSION_FILE} -o docker.tgz && \ 
    tar --strip-components=1 -xvzf docker.tgz -C /usr/local/bin

##############################################
### Terraform
#############################################
ARG TERRAFORM_VERSION=1.4.2
RUN echo "Download => https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip"
RUN curl -fL https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform_linux_amd64.zip && \
    unzip -q terraform_linux_amd64.zip -d /usr/bin && \
    terraform --version

##############################################
### tflint
#############################################
ARG TFLINT_VERSION=0.45.0
RUN echo "Download =>   v${TFLINT_VERSION}/tflint_linux_amd64.zip"
RUN curl -fL https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip -o tflint.zip  && \
    unzip -q tflint.zip -d /usr/bin && \
    tflint --version

##############################################
### kubectl - latest
#############################################
RUN echo "Download =>   https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin

##############################################
### helm 3 - latest
#############################################
RUN echo "Download =>   https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 && \
    chmod +x get_helm.sh && ./get_helm.sh

RUN ls -al

RUN rm *

################################################################################
### Make all shell scripts default executable
################################################################################

# Make all shell scripts default executable
WORKDIR /git
RUN find . -name "*.sh" -print && \
    find /app -name "*.sh" -execdir chmod u+x {} +


################################################################################
### Add Azure CLI extensions
################################################################################

RUN az extension add --name azure-devops

################################################################################
### Add dotnet-certificate-tool
################################################################################
# WORKDIR /git/dotnet-certificate-tool
# RUN dotnet tool install --tool-path ./ dotnet-certificate-tool 

################################################################################
### Add color for ls, alias for terraform etc.
################################################################################
COPY .bashrc /root/.bashrc
RUN dos2unix /root/.bashrc

################################################################################
### Install Certificate
################################################################################
# COPY aksstartupnorge.pem /etc/ssl/certs/
# RUN update-ca-certificates --fresh

################################################################################
### Set default workspace directory
################################################################################

WORKDIR /app

ENTRYPOINT tail -f /dev/null