# app/core/config.py
# This file centralizes all application configurations and environment variables.
import os

class Settings:
    PROJECT_NAME: str = "NMAP-Data-Correlation-Platform"
    VERSION: str = "0.1.0"
    # Use the DATABASE_URL from .env or fallback to a default (though .env is required)
    DATABASE_URL: str = os.getenv("DATABASE_URL", "")

# Initialize the settings object
settings = Settings()
