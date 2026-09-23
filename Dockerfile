# Use Node.js 18 alpine as the base image
FROM node:18-alpine

# Create app directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 3001

# Set the user to 'node' for security
USER node

# Start the application
CMD ["npm", "start"]
