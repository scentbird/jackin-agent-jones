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
