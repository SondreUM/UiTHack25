# Use a base image with SSH installed (you can choose a different base image if needed)
FROM ubuntu:latest

# Install SSH server
RUN apt-get update && apt-get install openssh-server sudo -y

# Set the root password for the SSH server
RUN echo 'root:u6rrmEJORb!CH=oZg1#e' | chpasswd

# Delete default user
RUN userdel -r ubuntu

# Create home directories for challenge user
RUN mkdir /home/noob2

# Set read permissions for home directory
RUN chmod 755 /home/noob2

# Create challenge users
RUN useradd -d /home/noob2 -s /bin/bash noob2 && echo 'noob2:UiTHack25{C4t_W0rk5_W0nd3rs}' | chpasswd

# Noob2 flag
RUN cd /home/noob2
RUN mkdir .secret
RUN chmod 755 .secret
ADD flag.txt /home/noob2/.secret/flag.txt
RUN chmod 644 /home/noob2/.secret/flag.txt

# Permit root login via SSH
# RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Enable password authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN service ssh start

# SSH port (optional, change if needed)
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]

# docker build -t noob2 .
# docker run -dp 6001:22 --rm noob2