# NMAP-Data-Correlation-Platform

Create an NMAP database where users will be able to quickly search and correlate nmap results for relevant information such as operating system, open ports, and IPs.

## Features
- **FastAPI Backend:** High-performance asynchronous API framework.
- **MySQL Database:** Relational data storage for scan results.
- **Dev Container Setup:** Ready-to-code VS Code environment with all tools pre-configured.
- **Project Structure:** Scalable directory organization (Models, Schemas, API V1).

## Getting Started

### Prerequisites
- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Visual Studio Code](https://code.visualstudio.com/) with the **Dev Containers** extension.

### How to Run
1. **Open in VS Code:** Open the project folder on your machine.
2. **Reopen in Container:** When prompted, click **Reopen in Container** (or press `Cmd+Shift+P` / `Ctrl+Shift+P` and type "Reopen in Container").
3. **Run and Debug:** Go to the "Run and Debug" sidebar (or press `F5`) and select **Python: FastAPI**.

### Environment Variables
All configuration is handled in the `.env` file in the root directory.

## Architecture
- **`app/main.py`**: The application entry point.
- **`app/api/v1/`**: Directory for versioned API routes.
- **`app/models/`**: SQL database models.
- **`app/schemas/`**: Pydantic models for data validation.
- **`app/core/`**: Global configuration and settings.

## Accessing Documentation
Once the server is running, you can access the interactive documentation at:
- **Swagger UI:** [http://localhost:8000/docs](http://localhost:8000/docs)
- **Redoc:** [http://localhost:8000/redoc](http://localhost:8000/redoc)

## Key Concepts
### What is an APIRouter?
In a FastAPI app, a **Router** acts as a "Traffic Controller". Instead of putting all your URLs into one giant `main.py` file, you use routers to group related endpoints (like all `/scans` or all `/users`) into their own files. This keeps the code organized, allows for easy versioning (like `/api/v1` and `/api/v2`), and makes it simpler to manage large projects.

## Database Management
- **phpMyAdmin:** [http://localhost:8080](http://localhost:8080) (Root Password: `root_password`)
