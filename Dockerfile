FROM n8nio/n8n:latest

# Set environment variables for memory optimization
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false
ENV N8N_USER_FOLDER=/opt/render/.n8n
ENV NODE_OPTIONS="--max-old-space-size=350"

# Create the correct directory structure
USER root
RUN mkdir -p /opt/render/.n8n && \
    chown -R node:node /opt/render

# Switch back to node user
USER node

# Use the default entrypoint and command from n8n image