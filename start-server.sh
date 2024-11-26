#!/bin/bash

# Function to start the container
start_container() {
  # Check if a dist folder with files exists in any nested directory
  if ! find . -name "dist" -type d -exec test -f {} \; | grep -q .; then
    echo "No dist folder found. Running npm run build in ./client..."
    cd client && npm run build && cd ..
  fi

  # Build the image
  docker build -t dmp .

  # Run the container in detached mode
  docker run -d -p 3000:3000 --name dmp-container dmp
  echo -e "Open in browser: \x1B]8;;http://localhost:3000\x1B\\localhost:3000\x1B]8;;\x1B\\"
}

# Function to stop and remove the container
stop_container() {
  # Stop the container
  docker stop dmp-container

  # Remove the container
  docker rm dmp-container
  echo "Container stopped and removed"
}

# Check the argument
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
