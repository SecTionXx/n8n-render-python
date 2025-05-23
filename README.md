# n8n Automation Platform

n8n automation platform for Render deployment.

## Features
- n8n latest version
- Ready for Render deployment

## Environment Variables
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
     - `N8N_HOST`: Your Render app URL (e.g., https://your-app.onrender.com)
     - `PORT`: 5678

## Local Development

```bash
# Build the Docker image
docker build -t n8n .

# Run the container
docker run -p 5678:5678 \
  -e N8N_HOST=http://localhost:5678 \
  n8n
```

## Usage
Once deployed, access your n8n instance at your Render app URL for automation workflows.

## License
MIT