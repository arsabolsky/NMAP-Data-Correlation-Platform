# NMAP Data Correlation Platform

A centralized platform for searching and correlating NMAP scan results. This tool allows users to quickly identify trends, operating systems, open ports, and IP addresses across their infrastructure.

## 🚀 Features

- **Frontend:** Modern, responsive UI built with **React (Vite)**, **Tailwind CSS 4.0**, and **Shadcn UI**.
- **Backend:** High-performance RESTful API powered by **PostgREST**, providing instant access to PostgreSQL tables and views.
- **Database:** **PostgreSQL** relational storage for scan results, companies, locations, and employee data.
- **Views:** Pre-configured database views for comprehensive reporting and easy data correlation.
- **Dev Container Setup:** Ready-to-code VS Code environment with all tools (Node, Postgres, PostgREST) pre-configured.

## 🛠️ Project Structure

- `frontend/`: React/Vite application with Tailwind CSS and Shadcn UI.
- `migrations/`: SQL migration scripts for database initialization, views, and seed data.
- `.devcontainer/`: Configuration for the Dockerized development environment.

## 🏁 Getting Started

### Prerequisites

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Visual Studio Code](https://code.visualstudio.com/) with the **Dev Containers** extension.

### How to Run

1.  **Clone the Repository.**
2.  **Environment Setup:**
    ```bash
    cp .env.example .env
    ```
    *(The defaults in `.env.example` are pre-configured to work with the Docker setup).*

#### Option A: VS Code Dev Containers (Recommended)
This is the easiest way to get started. VS Code will automatically handle all dependencies, database setup, and tool configurations.

3.  **Open in VS Code:** Open the project folder.
4.  **Reopen in Container:** When prompted, click **Reopen in Container** (or press `Cmd+Shift+P` and type "Reopen in Container"). 
    *   **Note:** Once the container builds, the environment is fully configured and services will start automatically.

#### Option B: Manual Docker Compose (No VS Code)
If you prefer not to use VS Code, you can still run the entire stack manually using Docker.

3.  **Start Services:**
    ```bash
    docker compose -f .devcontainer/docker-compose.yml up -d
    ```
4.  **Access:** The services will be available at the URLs listed in the [Accessing the Services](#-accessing-the-services) section below.

## 🔌 Accessing the Services

Once the container is running, the following services are available:

| Service      | URL                      | Description                       |
| :----------- | :----------------------- | :-------------------------------- |
| **Frontend** | `http://localhost:5173` | React/Vite Application            |
| **API**      | `http://localhost:3000` | PostgREST API                     |
| **Database** | `localhost:5432`         | PostgreSQL (Direct Connection)    |

## 🗄️ Database & Migration Guide

### Automatic Initialization

When the project is first started with `docker compose`, the scripts in `migrations/init/` are automatically executed in alphabetical order:

1.  `1-init.sql`: Creates core tables (`COMPANY`, `LOCATION`, `EMPLOYEE`, `SCAN`).
2.  `2-VIEW-company_and_locations.sql`: Company/Location relationship view.
3.  `3-VIEW-detailed_scan_report.sql`: Full scan reports view.
4.  `4-VIEWS-employees_and_locations.sql`: Employee location access view.
5.  `5-postgrest-setup.sql`: Configures permissions for the PostgREST API (`web_anon` role).
6.  `6-insert.sql`: Loads sample data.

### Manual Database Management

To run scripts manually, connect to the database container or use `psql` from your host:

#### From Host (using localhost)
```bash
psql -h localhost -U user -d nmap_db < migrations/delete.sql
```

#### From within Dev Container (using db-service)
```bash
psql -h db-service -U user -d nmap_db < migrations/delete.sql
```

## 🐳 Docker Management

These commands should be run from the root of the project directory.

### Rebuild and start (use after changing Dockerfile or .env)
```bash
docker compose -f .devcontainer/docker-compose.yml up -d --build
```

### Stop the containers (preserves data)
```bash
docker compose -f .devcontainer/docker-compose.yml stop
```

### Reset everything (removes containers and WIPES database volumes)
```bash
docker compose -f .devcontainer/docker-compose.yml down -v
```

### View Logs
```bash
docker compose -f .devcontainer/docker-compose.yml logs -f
```
