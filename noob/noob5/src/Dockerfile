# Use a base image with SSH installed (you can choose a different base image if needed)
FROM ubuntu:latest

# Install SSH server
RUN apt-get update && apt-get install openssh-server sudo -y

# Set the root password for the SSH server (CHANGE THIS PASSWORD!)
RUN echo 'root:SuperDup3rH3mm31ig' | chpasswd

# Delete default user
RUN userdel -r ubuntu

# Create home directories for challenge user
RUN mkdir /home/noob5

# Set read permissions for home directory
RUN chmod 755 /home/noob5

# Create challenge users
RUN useradd -d /home/noob5 -s /bin/bash noob5 && echo 'noob5:UiTHack25{D45h1ng_5ki11s}' | chpasswd
RUN useradd -s /bin/bash noob5_2 && echo 'mr_captain:SuperUltraS3cretPWD' | chpasswd

# Disable ssh login for mr_captain
RUN echo 'DenyUsers	mr_captain' >> /etc/ssh/sshd_config

# noob5 flag
USER mr_captain
ADD flag.txt /home/noob5/flag.txt
RUN chmod 644 /home/noob5/flag.txt

# Permit root login via SSH
# RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Enable password authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN service ssh start

# SSH port (optional, change if needed)
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]

# docker build -t noob5 .
# docker run -dp 6004:22 --rm noob5