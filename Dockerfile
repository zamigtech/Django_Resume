# Use the official Python base image
FROM python:3.10-slim

LABEL authors="zamiqaliyev"

# Update package list and install necessary packages
RUN apt-get update && \
    apt-get install -y python3-dev build-essential && \
    rm -rf /var/lib/apt/lists/*

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV VIRTUAL_ENV=/opt/venv

# Upgrade pip and install virtualenv
RUN pip install --upgrade pip && \
    pip install virtualenv && \
    python -m virtualenv $VIRTUAL_ENV

ENV PATH="$VIRTUAL_ENV/bin:$PATH"

# Add and install requirements
ADD ./requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt

# Copy the application code
COPY . /srv/app

# Set the working directory
WORKDIR /srv/app


