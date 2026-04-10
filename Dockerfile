FROM projectjackin/construct:trixie

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install additional system packages for Java builds
RUN sudo apt-get update && \
    sudo apt-get install -y --no-install-recommends \
    build-essential \
    libssl-dev \
    openssl \
    pkg-config && \
    sudo apt-get autoremove -y && \
    sudo rm -rf /var/lib/apt/* \
               /var/cache/apt/* \
               /tmp/*

USER claude

ENV MISE_TRUSTED_CONFIG_PATHS=/workspace

# Set Docker API version for Testcontainers compatibility with Docker 29.x
RUN echo "api.version=1.44" > /home/claude/.docker-java.properties

# Create gradle cache directory
RUN mkdir -p /home/claude/.gradle

# Language runtimes
RUN mise install node@lts && \
    mise use -g --pin node@lts

RUN mise install java@oracle-graalvm-21.0.7 && \
    mise install java@oracle-graalvm-23.0.2 && \
    mise use -g --pin java@oracle-graalvm-23.0.2

RUN mise install protoc@latest && \
    mise use -g --pin protoc@latest

# Global npm packages
RUN mise exec node@lts -- npm install -g ctx7

# Docker convenience functions
RUN cat >> /home/claude/.zshrc <<'ZSHRC'

# Stop and remove all Docker containers
docker_stop_rm_all() {
  docker stop $(docker ps -qa) 2>/dev/null
  docker rm $(docker ps -qa) 2>/dev/null
}

# Full Docker cleanup (containers, images, networks, volumes)
docker_clean_all() {
  docker_stop_rm_all
  docker rmi --force $(docker images -qa) 2>/dev/null
  docker network rm $(docker network ls -q) 2>/dev/null
  docker system prune --force
  docker volume prune --force
}
ZSHRC
