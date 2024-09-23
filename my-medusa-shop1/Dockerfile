# Use the official Node.js 16 image as the base image
FROM node:16

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the package.json and package-lock.json files to the working directory
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code to the working directory
COPY . .

# Expose the port that Medusa will run on
EXPOSE 9000

# Set environment variables
ENV NODE_ENV=production

# Command to start the Medusa server
CMD ["npm", "run", "start"]
