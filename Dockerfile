FROM alpine:latest

# Install dependencies
RUN apk add --no-cache wget unzip

# Set environment variable for Terraform version
ARG TERRAFORM_VERSION=1.0.0

# Run Terraform version
RUN echo TERRAFORM_VERSION=${TERRAFORM_VERSION}

# Download Terraform
RUN wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Unzip Terraform binary
RUN unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Move Terraform binary to /usr/local/bin
RUN mv terraform /usr/local/bin/

# Clean up
RUN rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

# Copy HCP Terraform Migrator
COPY tf-migrate /usr/local/bin/tf-migrate

# Verify installation
RUN terraform --version

# Verify installation
RUN tf-migrate --version