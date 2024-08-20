# Start with a base image
FROM ubuntu:20.04

# Create a group and user
RUN groupadd -r appgroup && useradd -r -g appgroup appuser

# Set the home directory for the new user
WORKDIR /home/appuser

# Copy application files to the container
COPY . /home/appuser

# Change ownership of the application files to the non-root user
RUN chown -R appuser:appgroup /home/appuser

# Switch to the non-root user
USER appuser

# Specify the command to run the application
CMD ["./your-application-executable"]

