FROM debian:bookworm-slim
WORKDIR /opt

# Install dependencies
RUN apt-get update \
 && apt-get install -y curl groff npm python3 unzip \
 && curl -sL https://deb.nodesource.com/setup_20.x | bash - \
 && apt-get install -y nodejs
# Install AWS CLI
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
 && unzip awscliv2.zip \
 && ./aws/install
# Install CDK
RUN npm -g install aws-cdk
# Support IaC written in TypeScript
RUN npm -g install typescript

WORKDIR /app
CMD ["/bin/bash"]
