# Use Node.JS 22 as the parent image
FROM node:22-alpine

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install node dependencieseeeee. We could use clean install (npm ci) if we had a package-lock.json; makes sense since it's a Docker container
RUN npm install

# Copy the rest of the files of the project
COPY . .

# Compile TypeScript to JavaScript
RUN npm run build

# Install lightweight web server
RUN npm install -g serve

# Expose the port of the server
EXPOSE 8080

# Define the command to run the service
CMD ["serve", "-s", "dist", "-l", "8080"]
