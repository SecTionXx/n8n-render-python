FROM n8nio/n8n:latest

# Switch to root user เพื่อติดตั้ง packages
USER root

# Install Python3 และ dependencies
RUN apk update && \
    apk add --no-cache \
        python3 \
        py3-pip \
        python3-dev \
        gcc \
        musl-dev \
        linux-headers \
        curl && \
    ln -sf /usr/bin/python3 /usr/bin/python && \
    ln -sf /usr/bin/python3 /usr/local/bin/python

# Install Python packages
RUN pip3 install --upgrade pip && \
    pip3 install --no-cache-dir \
        typhoon-ocr \
        requests \
        pillow \
        pdf2image \
        pytesseract

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

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 \
    CMD curl -f http://localhost:5678/healthz || exit 1

# Start n8n
CMD ["n8n", "start"]