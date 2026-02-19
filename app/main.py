# app/main.py
# The main entry point of the FastAPI application.
from fastapi import FastAPI

from app.api.v1.router import router as v1_router
from app.core.config import settings

# Initialize the FastAPI application with global settings
app = FastAPI(
    title=settings.PROJECT_NAME,
    version=settings.VERSION,
    description="A platform for searching and correlating NMAP scan results."
)

# Include the V1 router with a prefix
app.include_router(v1_router, prefix="/api/v1")

# Legacy root route for health checks or basic info


@app.get("/")
async def root():
    print('helloworld')
    return {
        "project": settings.PROJECT_NAME,
        "docs": "/docs",
        "api_v1": "/api/v1"
    }

# If you run using python -m app.main it will just run it with uvicorn like YOU should.
# uvicorn app.main:app --reload
if __name__ == "__main__":
    import uvicorn
    uvicorn.run("app.main:app", host="0.0.0.0", port=8000, reload=True)
