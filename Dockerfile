# Use the official Python image
FROM python:3.13-slim

# Install uv
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

WORKDIR /app

# Copy only the dependency files first to leverage Docker layer caching
COPY pyproject.toml uv.lock ./

# Install dependencies without the project itself 
# --no-install-project ensures we don't fail if the code isn't copied yet
# --index-url forces the public PyPI if your environment is hijacking it
RUN uv sync --frozen --no-install-project --no-dev

# Copy the rest of the application
COPY . .

# Ensure the app is installed
RUN uv sync --frozen --no-dev

# Cloud Run expects the app to listen on the PORT environment variable
ENV PYTHONUNBUFFERED=1
ENV PORT=8080

# Run the server
CMD ["uv", "run", "server.py"]