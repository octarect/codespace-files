FROM debian:bookworm-slim
WORKDIR /opt
COPY . /opt
RUN bash ./install.sh
