# Use a base image with SSH installed (you can choose a different base image if needed)
FROM ubuntu:latest

# Install SSH server
RUN apt-get update && apt-get install openssh-server sudo -y

# Set the root password for the SSH server
RUN echo 'root:u6rrmEJORb!CH=oZg1#e' | chpasswd

# Delete default user
RUN userdel -r ubuntu

# Create home directories for challenge user
RUN mkdir /home/noob3

# Set read permissions for home directory
RUN chmod 755 /home/noob3

# Create challenge users
RUN useradd -d /home/noob3 -s /bin/bash noob3 && echo 'noob3:UiTHack25{Hidd3n_but_c4n_b3_Cena}' | chpasswd

# noob3 flag
USER noob3 
RUN cd /home/noob3
ADD .bash_history.txt /home/noob3/.bash_history
USER root
RUN chown root /home/noob3/.bash_history
RUN chmod 744 /home/noob3/.bash_history

# Permit root login via SSH
# RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Enable password authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN service ssh start

# SSH port (optional, change if needed)
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]

# docker build -t noob3 .
# docker run -dp 6002:22 --rm noob3