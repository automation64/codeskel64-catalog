# Base image
FROM docker.io/library/ubuntu:21.04

# Prepare package installer
ENV container="docker"
ENV LC_ALL="C"
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt-get update

# Define requirements for application: X_PACKAGE_CAPS_X
ENV APP_X_PACKAGE_CAPS_X_PREREQS=""

# Define packages for application: X_PACKAGE_CAPS_X
ENV APP_X_PACKAGE_CAPS_X_PACKAGES=""

# Install packages for the application: X_PACKAGE_CAPS_X
RUN apt-get -y install $APP_X_PACKAGE_CAPS_X_PREREQS $APP_X_PACKAGE_CAPS_X_PACKAGES

# Configure packages: X_PACKAGE_CAPS_X

# Cleanup package manager
RUN apt-get clean

# Final command
CMD ["X_CMD_FINAL_X"]
