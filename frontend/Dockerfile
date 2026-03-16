# Use the official Node.js image as the base
FROM node:18-alpine

# Install git and any other tools you need for development
RUN apk add --no-cache git

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json to install dependencies
COPY package.json ./

# Install the project dependencies
RUN npm install

# Copy the rest of the application source code
COPY . .

# Expose the port the app runs on
EXPOSE 5173

# Start the application
# By default, Vite only listens on localhost (127.0.0.1). 
# Inside a container, localhost is the container itself. 
# --host tells Vite to listen on all network interfaces, which allows the traffic from your
# browser to actually reach the server inside the container.
CMD ["npm", "run", "dev", "--", "--host"]