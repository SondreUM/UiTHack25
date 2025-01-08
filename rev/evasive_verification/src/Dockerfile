# Use the latest nginx Alpine image
FROM nginx:alpine

LABEL category="rev"
LABEL source="UiTHack25"
LABEL version="1.0"
LABEL description="Evasive Verification Challenge"
LABEL author="@SondreUM"


# Replace the default nginx configuration with our custom configuration
COPY nginx.conf /etc/nginx/nginx.conf
# RUN chown nginx:nginx /etc/nginx/nginx.conf

# add certs
# COPY /fullchain.pem /etc/nginx/fullchain.pem
# COPY /privkey.pem /etc/nginx/privkey.pem

# Copy flag into the nginx directory
COPY www /usr/share/nginx/static
RUN chown -R nginx:nginx /usr/share/nginx/static

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]

# docker build -t evasive_verification .
# docker run -dp 5005:80 -it --rm evasive_verification