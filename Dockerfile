# Use the official Node.js 14 image as the base for the application.
FROM node:14

# Use a Node.js 14-compatible npm version that supports package.json overrides.
# This lets the graceful-fs override fix Gulp 3's "primordials" error.
RUN npm install --global npm@8.19.4

# Set /app as the working directory for subsequent instructions and startup.
WORKDIR /app

# Copy the build context into /app, excluding files listed in .dockerignore.
COPY . .

# Enable production mode and use the item-db container as the database host.
ENV NODE_ENV=production DB_HOST=item-db

# Install production dependencies, allowing npm scripts to run as root,
# then build the application only if installation succeeds.
RUN npm install --production --unsafe-perm && npm run build

# Document that the application listens on port 8080; publish it with docker run -p.
EXPOSE 8080

# Run npm start by default when the container launches.
CMD ["npm", "start"]
