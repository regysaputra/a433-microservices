# Use Node.js 18 alpine as the base image
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
# Using 'npm ci' for a more reliable build in production-like environments
RUN npm ci --only=production

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
# The service uses process.env.PORT, so we'll document 3000 as default
EXPOSE 3000

# Set the user to 'node' for security
USER node

# Start the application
CMD ["npm", "start"]
