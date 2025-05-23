# Dockerfile ที่แก้ไขแล้ว
FROM n8nio/n8n:latest

# Switch to root user
USER root

# Install system dependencies
RUN apk update && \
    apk add --no-cache \
        python3 \
        py3-pip \
        python3-dev \
        gcc \
        musl-dev \
        linux-headers \
        curl \
        build-base \
        libffi-dev \
        openssl-dev && \
    ln -sf /usr/bin/python3 /usr/bin/python

# Upgrade pip first
RUN python3 -m pip install --upgrade pip

# Install Python packages one by one for better error tracking
RUN pip3 install --no-cache-dir requests
RUN pip3 install --no-cache-dir pillow
RUN pip3 install --no-cache-dir typhoon-ocr

# Install optional packages (if these fail, build continues)
RUN pip3 install --no-cache-dir pdf2image || echo "pdf2image install failed, continuing..."
RUN pip3 install --no-cache-dir pytesseract || echo "pytesseract install failed, continuing..."

# Set environment variables
ENV PYTHONPATH="/usr/lib/python3.12/site-packages:/usr/local/lib/python3.12/site-packages"
ENV PYTHON_EXECUTABLE="/usr/bin/python3"
ENV PATH="/usr/local/bin:/usr/bin:/bin:${PATH}"

# Create directories
RUN mkdir -p /app/doc && \
    mkdir -p /home/node/.n8n && \
    chown -R node:node /app && \
    chown -R node:node /home/node

# Switch back to node user
USER node

# Set working directory
WORKDIR /home/node

# Expose port
EXPOSE 5678

# Start n8n
CMD ["n8n", "start"]
