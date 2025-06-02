# ReactJS Docker

Project created to review concepts of ReactJS and Docker.

## Create project

The following commands are based on the assumption that the git repository has been create in github previously.

```bash
git clone https://github.com/christianamenos/reactjsDocker.git

npm create vite@latest . -- --template react-ts
```

- **Current directory is not empty. Please choose how to proceed:**
  - Ignore files and continue
- **Package name:**
  - reactjsdocker
- **Select a framework:**
  - React
- **Select a variant:**
  - TypeScript

Run `npm install` and `npm run dev` after te installation to install dependencies and recognize them during the development, and for running the server in development mode.


## Managing Docker

### Running the docker image

**Note:** run the following commands from the root folder of the project. Where the `Dockerfile` file is located.

```bash
# Build the docker image, assinging the name we want
docker build -t christianamenos.com/react/typescript-front .

# Run a previously build docker image with the specified name, forwarding the exposed port into the local machine
docker run -p 8080:8080 christianamenos.com/react/typescript-front

# To run in interactive mode, you can use the following command. Can be useful to get additional details of the front server.
# docker run -it -p 8080:8080 christianamenos.com/react/typescript-front
```

### Stop and remove a container

```bash
# Check the running or built containers of the system, copy the container id for the next commands
docker ps

# Stop a running docker image
docker stop <CONTAINER_ID>

# Remove an existing docker image
docker rm <CONTAINER_ID>
```

### Debug the running container

The following commands allows to enter to the container to evaluate if the ReactJS server is running inside it.

```bash
# List the containers running in the machine, copy the value of column `NAMES`
docker ps

# Enter to the container using `sh` (in some cases this should be using `bash`, for alpine images, since they are minimal Docker images, it goes with `sh`)
docker exec -it typescript-front-<HASH_ID> sh

# Run the `curl` command to test the server is working on localhost on the specified port
curl localhost:8080

# NOTE: if the curl command is not available, you can temporary install it using the following command (it will be lost when the container restarts, to keep the command as permanent solution, you need to run the command as part of the `RUN` command in the docker file, we can have multiple `RUN` commands)
aok add --no-cache curl
```

### List images and remove images

```bash
# List images available
docker images

# Remove images
docker image rm <IMAGE_ID>

#If getting error: `conflict to delete <CONTAINER_ID> (must be forced) - image is being used by stopped container <HASH_ID>`, run the command:
docker container prune
```

## Troubleshooting

I has issues with the image not replying to the requests in the local machine. In my case it was because several images were conflicting with each other, using the same port number. Even if the container was stopped, it keeps the port busy. I had to prune the containers and re-run the commands to run the container again.

## Questions

- If a stopped container can cause problems, how should I do it to keep it working?
- How can I configure a server with these Docker images?
- How do I setup multiple Docker containers and let them commuinicate with each other?