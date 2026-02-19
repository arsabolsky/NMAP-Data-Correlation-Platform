# app/api/v1/router.py
# -------------------------------------------------------------------------
# WHAT IS A ROUTER?
# Think of an APIRouter as a "mini-FastAPI" instance or a "Traffic Controller".
#
# As your app grows, putting every URL (endpoint) in main.py becomes messy. 
# A Router allows you to group related endpoints together in separate files.
#
# Key Benefits:
# 1. Organization: Keep user-related routes in one file, and NMAP-related routes in another.
# 2. Prefixes: We can tell this router that all its paths should start with "/api/v1" 
#    automatically in main.py.
# 3. Versioning: Easily manage different API versions (v1, v2, etc.) side-by-side.
# -------------------------------------------------------------------------
from fastapi import APIRouter

# Create an APIRouter instance for V1 endpoints
router = APIRouter()

# Root endpoint for the V1 API
@router.get("/")
async def v1_root():
    return {"message": "Welcome to V1 of the NMAP-Data-Correlation API"}
