# Use the official lightweight Python image based on Debian Slim
FROM python:3.11-slim

# Set environment variables to prevent interactive prompts during package installations
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary system dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the environment file into the container
COPY .env .

# Copy the rest of the application code into the container
COPY . .

# Expose the port Streamlit will run on
EXPOSE 8501

# Run the Streamlit app
CMD ["streamlit", "run", "app.py"]
