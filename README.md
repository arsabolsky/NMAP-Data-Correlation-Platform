# NMAP-Data-Correlation-Platform

Create an NMAP database where users will be able to quickly search and correlate nmap results for relevant information such as operating system, open ports, and IPs.

## Project Outline:

### Features

- **FastAPI Backend:** High-performance asynchronous API framework.
- **MySQL Database:** Relational data storage for scan results.
- **Dev Container Setup:** Ready-to-code VS Code environment with all tools pre-configured.
  <!-- - **Project Structure:** Scalable directory organization (Models, Schemas, API V1). -->

## Getting Started

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Visual Studio Code](https://code.visualstudio.com/) with the **Dev Containers** extension.

### How to Run

1. **Open in VS Code:** Open the project folder on your machine.
2. **Reopen in Container:** When prompted, click **Reopen in Container** (or press `Cmd+Shift+P` / `Ctrl+Shift+P` and type "Reopen in Container").
3. **Run and Debug:** Go to the "Run and Debug" sidebar (or press `F5`) and select **Python: FastAPI**.

### Environment Variables

All configuration is handled in a `.env` file in the .devcontainer (long story but basically I can't use `../.env` 🤷‍♂️) directory. This file is ignored by git to protect your secrets.

To get started:

1. Copy the template: `cp .env.example .env`
2. Update the values in `.env` if needed.

#### Example `.env` Structure:

```bash
# Database Credentials
MYSQL_ROOT_PASSWORD=root_password
MYSQL_DATABASE=nmap_db
MYSQL_USER=user
MYSQL_PASSWORD=password

# Application Connection String (SQLAlchemy)
DATABASE_URL=mysql+pymysql://user:password@db-service:3306/nmap_db
```

<!-- ## Architecture

- **`app/main.py`**: The application entry point.
- **`app/api/v1/`**: Directory for versioned API routes.
- **`app/core/`**: Global configuration and settings. -->

<!-- ## Accessing Documentation

Once the server is running, you can access the interactive documentation at:

- **Swagger UI:** [http://localhost:8000/docs](http://localhost:8000/docs)
- **Redoc:** [http://localhost:8000/redoc](http://localhost:8000/redoc) -->

## Docker Management

These commands should be run from the root of the project directory.

### Start the environment

```bash
docker compose -f .devcontainer/docker-compose.yml up -d
```

### Rebuild and start (use after changing Dockerfile or .env)

```bash
docker compose -f .devcontainer/docker-compose.yml up -d --build
```

### Stop the containers (preserves data)

```bash
docker compose -f .devcontainer/docker-compose.yml stop
```

### Tear down the environment (removes containers/networks)

```bash
docker compose -f .devcontainer/docker-compose.yml down
```

### Reset everything (removes containers, networks, and WIPES database volumes)

```bash
docker compose -f .devcontainer/docker-compose.yml down -v
```

### View Logs

```bash
docker compose -f .devcontainer/docker-compose.yml logs -f
```

## Key Concepts

### What is an APIRouter?

In a FastAPI app, a **Router** acts as a "Traffic Controller". Instead of putting all your URLs into one giant `main.py` file, you use routers to group related endpoints (like all `/scans` or all `/users`) into their own files. This keeps the code organized, allows for easy versioning (like `/api/v1` and `/api/v2`), and makes it simpler to manage large projects.

## Database Management

- **phpMyAdmin:** [http://localhost:8080](http://localhost:8080) (Root Password: `root_password`)

## Database & Migration Guide

### Software Used

- **MySQL 8.0+**: Primary relational database with strict data integrity enforcement.
- **phpMyAdmin**: Web-based administration tool.
- **Docker & Docker Compose**: Orchestrates the API and Database services.

### Connection Details

- **Host:** `127.0.0.1`/`localhost` (Local) or `db-service` (Inside Docker container)
- **Port:** `3306`
- **User:** `user` (Defined in `.env`)
- **Database:** `nmap_db`

### Running Migrations Manually

Run these scripts in order to set up your environment (1-init.sql & 2-insert.sql run automatically on first Docker Compose Up):

1. **Initialize Schema:**

    ```bash
    mysql -h 127.0.0.1 -P 3306 -u user -p nmap_db < Migrations/init/1-init.sql
    ```

2. **Insert Sample Data:**

    ```bash
    mysql -h 127.0.0.1 -P 3306 -u user -p nmap_db < Migrations/2-insert.sql
    ```

    _Loads test companies, locations, employees, and scans._

3. **Clear Database:**
    ```bash
    mysql -h 127.0.0.1 -P 3306 -u user -p nmap_db < Migrations/3-delete.sql
    ```
