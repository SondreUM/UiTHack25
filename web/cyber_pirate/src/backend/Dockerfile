# # Use the official Ubuntu 18.04 LTS as a base image
# FROM ubuntu:18.04

# # Avoid prompts from apt
# ENV DEBIAN_FRONTEND=noninteractive

# # Update the package list and install Python 3 and pip
# RUN apt-get update -y \
#   && apt-get install -y python3-pip \
#   && apt-get clean \
#   && rm -rf /var/lib/apti/lists/*

# # Install Flask, specifying the version to ensure reproducibility
# RUN pip3 install Flask
# RUN pip3 install flask-cors

# # Copy the Python server script and the database file into the container
# COPY server.py /
# COPY database.sqlite /

# # Set the working directory to the root (not strictly necessary here, as this is the default)
# WORKDIR /

# # Expose port 5000 for the Flask server
# EXPOSE 5000

# # Run the server.py script using Python 3 when the container launches
# CMD ["python3", "server.py"]

# Use the official Ubuntu 22.04 LTS as a base image
FROM ubuntu:22.04

# Avoid prompts from apt during installation
ENV DEBIAN_FRONTEND=noninteractive

# Set the working directory
WORKDIR /app

# Update the package list and install necessary packages
RUN apt-get update -y && \
    apt-get install -y python3-pip python3-dev build-essential && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy the Python server script and the database file into the container
COPY server.py /app/
COPY database.sqlite /app/

# Install Flask and its dependencies
RUN pip3 install --no-cache-dir Flask flask-cors

# Expose port 5001 for the Flask server
EXPOSE 8006

# Run the server.py script using Python 3 when the container launches
CMD ["python3", "server.py"]
