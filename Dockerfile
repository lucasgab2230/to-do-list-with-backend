# Use Ubuntu 24.04 LTS base image
FROM ubuntu:24.04

# Set working directory
WORKDIR /app

# Install Python 3.12 and pip
RUN apt-get update && \
    apt-get install -y python3.12 python3-pip sqlite3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set default Python version
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.12 1

# Copy requirements file
COPY requirements.txt .

# Install Python dependencies
RUN pip3 install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Expose port 5000 (default Flask port)
EXPOSE 5000

# Run the application
CMD ["python3", "app.py"]