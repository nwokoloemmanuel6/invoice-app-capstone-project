# ---- Base Node ----
FROM 747184226799.dkr.ecr.us-east-1.amazonaws.com/invoice-client:latest AS base

# Set working directory
WORKDIR /app

# Copy over package.json and install dependencies
COPY package.json .
RUN yarn install

# Copy application files
COPY . .

# Build the application
RUN yarn build

# ---- Nginx stage ----
FROM nginx:1.21.1-alpine AS release

# Copy the build output from the 'base' stage to the default Nginx public folder
COPY --from=base /app/build /usr/share/nginx/html

# Copy the Nginx configuration file
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
