FROM ubuntu:22.04

# Update and install required packages
RUN apt-get update -y && \
    apt-get install -y fortune-mod cowsay netcat

# Set working directory
WORKDIR /wisdom

# Copy the bash script into the container
COPY wisecow/wisecow.sh .

# Expose port 4499 for external access
EXPOSE 4499

ENV PATH="/usr/games:${PATH}"

# Run the script when container starts
CMD ["bash", "wisecow.sh"]

