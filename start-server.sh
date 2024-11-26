#!/bin/bash

start_container() {
  if ! ls ./client | grep dist; then
    echo "No dist folder found. Running npm run build in ./client..."
    cd ./client && npm run build && cd ..
  fi

  docker build -t dmp .

  docker run -d -p 3000:3000 --name dmp-container dmp
  echo -e "Open in browser: \x1B]8;;http://localhost:3000\x1B\\localhost:3000\x1B]8;;\x1B\\"
}

stop_container() {
  docker stop dmp-container

  docker rm dmp-container
  echo "Container stopped and removed"
}

case "$1" in
start)
  start_container
  ;;
stop)
  echo "Stopping container..."
  stop_container
  ;;
*)
  echo "Usage: $0 {start|stop}"
  exit 1
  ;;
esac

exit 0
