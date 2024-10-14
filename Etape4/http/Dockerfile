# Use the official NGINX image
FROM nginx:latest

# Remove the default configuration file
RUN rm /etc/nginx/conf.d/default.conf

# Copy your custom configuration file into the container
COPY default.conf /etc/nginx/conf.d/default.conf

# Set the working directory
WORKDIR /app

# Expose port 80
EXPOSE 80
