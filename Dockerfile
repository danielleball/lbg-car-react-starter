# Use an official Node.js runtime as a parent image
FROM node:19-alpine as build
 
# Set the working directory
WORKDIR /app
 
# Copy package.json and install dependencies
COPY package.json ./
RUN npm install --force
 
# Copy the rest of the application code
COPY . .
 
# Build the application
RUN npm run build
 
# Expose the port the app runs on
FROM nginx:1.23-alpine
 
COPY --from=build /app/build /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
 
EXPOSE 80
 
#Start the application
CMD ["nginx", "-g","daemon off;"]