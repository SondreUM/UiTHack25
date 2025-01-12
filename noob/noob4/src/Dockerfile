# Use a base image with SSH installed (you can choose a different base image if needed)
FROM ubuntu:latest

# Install SSH server
RUN apt-get update && apt-get install openssh-server sudo -y

# Set the root password for the SSH server (CHANGE THIS PASSWORD!)
RUN echo 'root:SuperDup3rH3mm31ig' | chpasswd

# Delete default user
RUN userdel -r ubuntu

# Create home directories for challenge user
RUN mkdir /home/noob4

# Set read permissions for home directory
RUN chmod 755 /home/noob4

# Create challenge users
RUN useradd -d /home/noob4 -s /bin/bash noob4 && echo 'noob4:UiTHack25{Nev3r_f0rg3771_ctrl_shift_del}' | chpasswd

# noob4 flag
RUN cd /home/noob4
RUN echo "not correct" > "flag.txt"
RUN echo "not quite correct" > "-flag.txt"
RUN echo "UiTHack25{D45h1ng_5ki11s}" > "-flag.txt "
RUN chmod 644 -- "-flag.txt "
RUN chmod 644 -- "-flag.txt"
RUN chmod 644 -- "flag.txt"

# Permit root login via SSH
# RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Enable password authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

RUN service ssh start

# SSH port (optional, change if needed)
EXPOSE 22

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]

# docker build -t noob4 .
# docker run -dp 6003:22 --rm noob4