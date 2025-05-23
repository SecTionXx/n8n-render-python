# Dockerfile ใช้ Python Base Image
FROM python:3.12-alpine

# Install Node.js และ npm (สำหรับ n8n)
RUN apk add --no-cache nodejs npm curl

# Install n8n globally
RUN npm install -g n8n

# Install Python packages (ไม่มี PEP 668 issues)
RUN pip install --no-cache-dir \
    typhoon-ocr \
    requests \
    pillow \
    pdf2image \
    pytesseract

# Create node user (ตาม n8n standard)
RUN addgroup -g 1000 node && \
    adduser -u 1000 -G node -s /bin/sh -D node

# Create directories
RUN mkdir -p /app/doc /home/node/.n8n && \
    chown -R node:node /app /home/node

# Set environment variables
ENV N8N_USER_FOLDER="/home/node/.n8n"
ENV PYTHONPATH="/usr/local/lib/python3.12/site-packages"
ENV PYTHON_EXECUTABLE="/usr/bin/python3"

# Switch to node user
USER node
WORKDIR /home/node

# Expose port
EXPOSE 5678

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:5678/healthz || exit 1

# Start n8n
CMD ["n8n", "start"]
