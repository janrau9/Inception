# Inception Docker Project

**Inception** is a multi-service, containerized web application architecture that demonstrates modern DevOps practices. This project deploys a secure and scalable WordPress website using Docker Compose, with the following key components:

- **NGINX**: Acts as a secure reverse proxy, configured with TLS (HTTPS) to serve web content.
- **MariaDB**: Provides a robust, persistent database backend for WordPress.
- **WordPress**: A popular content management system (CMS) for dynamic web content.

All services are orchestrated using Docker Compose, which ensures seamless inter-container networking, persistent storage via Docker volumes, and simplified deployment.

---

## Table of Contents

- [Overview](#overview)
- [Architecture](#architecture)
- [Technology Stack](#technology-stack)
- [Deployment](#deployment)
- [Testing & Validation](#testing--validation)
- [Why This Architecture?](#why-this-architecture)
- [Conclusion](#conclusion)
- [Contact](#contact)

---

## Overview

The Inception Docker Project demonstrates how to build and deploy a full-stack web application using Docker. The project consists of three main containers:

1. **NGINX Container**:  
   - Serves as a secure reverse proxy that handles HTTPS traffic exclusively (port 443).  
   - Provides SSL/TLS termination and forwards requests to the WordPress application.

2. **MariaDB Container**:  
   - Hosts the database for the WordPress site.  
   - Uses Docker volumes for persistent storage, ensuring that your data remains available even if the container is recreated.

3. **WordPress Container**:  
   - Runs WordPress along with PHP (typically via PHP-FPM) to serve dynamic content.  
   - Connects to the MariaDB container using Docker’s internal networking.

---

## Architecture

- **Containerization**:  
  Each service runs in its own Docker container, ensuring separation of concerns and easier scalability.

- **Networking**:  
  Docker Compose creates a default network (or a custom-defined network) that allows containers to communicate using service names (e.g., the WordPress container connects to the database using the hostname `mariadb`).

- **Persistent Storage**:  
  Docker volumes are used to store the database data and (if needed) WordPress content. This guarantees data persistence across container restarts and redeployments.

- **Security**:  
  NGINX is configured to accept traffic only on port 443, ensuring all communications are secured via TLS/SSL.

---

## Technology Stack

- **Docker & Docker Compose**: For containerization and multi-service orchestration.
- **NGINX**: A high-performance web server and reverse proxy that provides secure HTTPS access.
- **MariaDB**: A robust, open-source relational database management system.
- **WordPress**: The leading content management system (CMS) for building dynamic websites.
- **Linux (Debian/Alpine)**: The base images used to build lightweight, secure containers.

---

## Deployment

### Prerequisites

- Docker Engine and Docker Compose installed on your host machine or VM.
- A `.env` file in the project root (optional) containing necessary environment variables, for example:
  ```env
  WEB_CONTENT_PATH=/home/yourusername/data/wp_data
  DB_DATA_PATH=/home/yourusername/data/db_data
  MYSQL_ROOT_PASSWORD=yourRootPassword
  MYSQL_DATABASE=wordpress
  MYSQL_USER=wordpressUser
  MYSQL_PASSWORD=wordpressPassword
  DOMAIN_NAME=jberay.42.fr
  WP_ADMIN_USER=yourAdminUser
  WP_ADMIN_PASSWORD=yourAdminPassword
  WP_ADMIN_EMAIL=admin@example.com

## Build and Run
```
git clone https://github.com/janrau9/Inception.git
cd Inception
make
```
## Manual testing
```
curl -I https://jberay.42.fr
```
