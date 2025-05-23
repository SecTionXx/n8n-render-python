# n8n with Python Support

n8n automation platform with Python3 and OCR capabilities for Render deployment.

## Features
- n8n latest version
- All required dependencies
- Ready for Render deployment

## Environment Variables
- `TYPHOON_OCR_API_KEY`: Your OCR API key
- `N8N_HOST`: Your Render app URL
- `PORT`: 5678

## Deployment on Render

1. Fork this repository
2. Connect your GitHub account to Render
3. Create a new Web Service on Render
4. Select this repository
5. Set the following:
   - **Build Command**: Leave empty (Docker build)
   - **Start Command**: Leave empty (uses Dockerfile CMD)
   - **Environment Variables**:
     - `TYPHOON_OCR_API_KEY`: Your API key
     - `N8N_HOST`: Your Render app URL (e.g., https://your-app.onrender.com)
     - `PORT`: 5678

## Local Development

```bash
# Build the Docker image
docker build -t n8n-python .

# Run the container
docker run -p 5678:5678 \
  -e TYPHOON_OCR_API_KEY=your_api_key \
  -e N8N_HOST=http://localhost:5678 \
  n8n-python
```

## Python Packages Included
- typhoon-ocr
- requests
- pillow
- pdf2image
- pytesseract

## Usage
Once deployed, access your n8n instance at your Render app URL. You can now use Python code nodes with all the included packages for automation workflows.

## License
MIT