FROM n8nio/n8n:latest

# Set environment variables
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

# Use the default entrypoint and command from n8n image
# The n8n image already has the correct entrypoint configured