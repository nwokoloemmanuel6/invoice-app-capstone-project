# ---- Builder stage ----
FROM 747184226799.dkr.ecr.us-east-1.amazonaws.com/invoice-server:latest AS builder
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install all dependencies
RUN npm install && npm install nodemon --save-dev

# Copy server files
COPY . .

# ---- Production stage ----
FROM node:14-alpine AS production
ENV NODE_ENV production
WORKDIR /usr/src/app

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install production dependencies only
RUN npm install --only=production

# Copy built application from builder stage
COPY --from=builder /usr/src/app .

EXPOSE 5000
CMD ["npm", "start"]
