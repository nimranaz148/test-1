# Use a lightweight Python base image
FROM python:3.11-slim

# Install uv for fast dependency management
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# Set working directory
WORKDIR /app

# Enable bytecode compilation
ENV UV_COMPILE_BYTECODE=1

# Copy project files for dependency installation
COPY pyproject.toml uv.lock ./

# Install dependencies using uv sync (installs into /.venv by default)
RUN uv sync --frozen --no-dev

# Copy the rest of the application
COPY . .

# Add .venv/bin to PATH to use installed commands
ENV PATH="/app/.venv/bin:$PATH"

# Expose the application port
EXPOSE 8000

# Run the application
CMD ["python", "main.py"]
