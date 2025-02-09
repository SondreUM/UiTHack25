# Use a base image with SSH installed (you can choose a different base image if needed)
FROM ubuntu:latest

# Install SSH server
RUN apt-get update && apt-get install openssh-server sudo -y

# Set the root password for the SSH server
RUN echo 'root:u6rrmEJORb!CH=oZg1#e' | chpasswd

# Delete default user
RUN userdel -r ubuntu

# Create home directories for challenge user
RUN mkdir /home/david

# Set read permissions for home directory
RUN chmod 755 /home/david

# Create challenge users
RUN useradd -d /home/david -s /bin/bash david && echo 'david:' | chpasswd

# Enable password authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN service ssh start

# SSH port (optional, change if needed)
EXPOSE 22
EXPOSE 443

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]


# NB!!! build steps have yet to be decided
# docker build TBD
# docker run TBD