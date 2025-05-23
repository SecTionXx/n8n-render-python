FROM n8nio/n8n:latest

# Use the default user and working directory from n8n image
USER node
WORKDIR /home/node

# Expose port
EXPOSE 5678

# Start n8n
CMD ["n8n", "start"]