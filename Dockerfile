# --------------------
# STAGE 1: BUILDER
# This stage installs dependencies and discards temporary files.
# --------------------
FROM python:3.12-slim AS builder

# 1. Clone the repository
RUN git clone https://github.com/confluentinc/connect-migration-utility.git /app

# 2. Install dependencies into a virtual environment
# We install them into /venv to make separation easier
WORKDIR /app
RUN python3 -m venv /venv && \
    /venv/bin/pip install --no-cache-dir -r requirements.txt

# --------------------
# STAGE 2: FINAL IMAGE
# This stage is tiny and only copies the bare necessities.
# --------------------
FROM python:3.12-slim

# Copy only the virtual environment from the builder stage
COPY --from=builder /venv /venv
COPY --from=builder /app /app

# Set the path to use the virtual environment's executables
ENV PATH="/venv/bin:$PATH"
WORKDIR /app

# The final command
CMD ["sleep", "infinity"]
