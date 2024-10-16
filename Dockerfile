# Use the official Python image with slim (Debian-based)
FROM python:3.12-slim

# Set the working directory inside the container
WORKDIR /app

# Install the necessary system dependencies using apt (Debian-based package manager)
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    g++ \
    libffi-dev \
    make \
    && rm -rf /var/lib/apt/lists/*

# Copy the requirements file into the container
COPY requirements.txt .

# Install the dependencies in the container
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application files to the container
COPY app .

RUN python generate-model.py

# Expose port 8000 to allow external access to the app
EXPOSE 8000

# Command to run the application using Uvicorn (FastAPI server)
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
