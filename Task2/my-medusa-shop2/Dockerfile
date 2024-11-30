# Use Node.js 18 Alpine image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and yarn.lock (if it exists)
COPY package.json yarn.lock ./

# Set the Yarn registry to Yarn's official registry (or a custom mirror)
RUN yarn config set registry https://registry.yarnpkg.com

# Install dependencies using Yarn
RUN yarn install

# Copy all the project files into the container
COPY . .

# Expose the default Medusa port
EXPOSE 9000

# Start Medusa
CMD ["yarn", "start"]
