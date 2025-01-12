FROM ubuntu:latest

# Install SSH server
RUN apt-get update && apt-get install openssh-server sudo -y

# Set the root password for the SSH server
RUN echo 'root:SuperDup3rH3mm31ig' | chpasswd

# Delete default user
RUN userdel -r ubuntu

# Create home directory for challenge user
RUN mkdir /home/noob1

# Set read permission for home directory
RUN chmod 755 /home/noob1

# Create challenge user
RUN useradd -d /home/noob1 -s /bin/bash noob1 && echo 'noob1:noobyPenguin' | chpasswd

# Insert flag and give challenge user read permission on it
ADD flag.txt /home/noob1/flag.txt
RUN chmod 644 /home/noob1/flag.txt

# Permit root login via SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Enable password authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# SSH port (optional, change if needed)
EXPOSE 22

# Start SSH service
RUN service ssh start
CMD ["/usr/sbin/sshd", "-D"]

# docker build -t noob1 .
# docker run -dp 6000:22 --rm noob1