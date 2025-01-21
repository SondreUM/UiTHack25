# Dockerfile
FROM nginx:alpine

LABEL description="Big Picture Web"
LABEL category="web"
LABEL source="UiTHack25"
LABEL version="1.0"

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Copy web content
COPY index.html /usr/share/nginx/html/
COPY mobile.html /usr/share/nginx/html/

RUN chown -R nginx:nginx /usr/share/nginx/html/



EXPOSE 8080

# Default command
CMD ["nginx", "-g", "daemon off;"]

# docker build -t big_picture .
# docker run -dp 8001:8080 -it --rm big_picture