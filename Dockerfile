# Use the Red Hat Universal Base Image (UBI) as the base image
FROM registry.access.redhat.com/ubi8/ubi:latest



# Install required dependencies
RUN yum -y install wget && \
    yum clean all && \
    rm -rf /var/cache/yum

# Download and install EPEL release package
RUN wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
    rpm -ivh epel-release-latest-8.noarch.rpm && \
    rm -f epel-release-latest-8.noarch.rpm

# Install ShellCheck
RUN yum -y install ShellCheck && \
    yum clean all && \
    rm -rf /var/cache/yum

# Set the working directory
WORKDIR /scripts

# Copy the script(s) to the container
COPY stop.sh .

# Specify the command to run when the container starts
CMD ["bash"]
