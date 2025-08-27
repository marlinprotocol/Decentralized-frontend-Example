# Use nginx:alpine as base image for serving static content
FROM nginx:alpine

# Copy the HTML file to nginx html directory
COPY index.html /usr/share/nginx/html/index.html

# Create custom nginx configuration directly in Dockerfile
RUN echo 'server { \
    listen 8080 default_server; \
    listen [::]:8080 default_server; \
    server_name _; \
    \
    location / { \
        root   /usr/share/nginx/html; \
        index  index.html index.htm; \
    } \
    \
    error_page   500 502 503 504  /50x.html; \
    location = /50x.html { \
        root   /usr/share/nginx/html; \
    } \
}' > /etc/nginx/conf.d/default.conf

# Expose port 8080
EXPOSE 8080

# Start nginx
CMD ["nginx", "-g", "daemon off;"]