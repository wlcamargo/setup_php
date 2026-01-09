# PHP Docker Setup

A complete Docker environment for PHP 7.2 development with MySQL 5.7, Apache, and automated Docker Hub deployment.

## Overview

This project provides a containerized development environment with:

- **PHP 7.2** with Apache and common extensions (mysqli, PDO, GD, ZIP, etc.)
- **MySQL 5.7** database server
- **Automated CI/CD pipeline** for Docker Hub deployments
- **Environment variables** for easy configuration
- **Persistent volumes** for database data

## Project Structure

```
.
├── docker-compose.yml          # Docker services configuration
├── .env                        # Environment variables
├── init.sql                    # MySQL initialization script
├── .github/
│   └── workflows/
│       └── deploy.yml          # CI/CD pipeline
└── src/                        # Application source code
    └── index.php               # PHP application files
```

## Prerequisites

- **Docker** and **Docker Compose** installed
- **Git** for version control

## Getting Started

### 1. Clone the Repository

```bash
git clone <repository-url>
cd setup_php
```

### 2. Configure Environment Variables

Edit the `.env` file with your credentials:

```env
MYSQL_ROOT_PASSWORD=
MYSQL_DATABASE=
MYSQL_USER=
MYSQL_PASSWORD=
```

### 3. Start Services

```bash
docker compose up -d
```

Services will be available at:

- **Web (PHP/Apache):** http://localhost:8083
- **MySQL:** localhost:3001

### 4. Stop Services

```bash
docker compose down
```

## Services

### Web Service (PHP 7.2)

- **Image:** webdevops/php-apache:7.2
- **Container Name:** php_app_72
- **Port:** 8083:80
- **Document Root:** /app (maps to ./src)
- **Timezone:** America/Sao_Paulo

### Database Service (MySQL 5.7)

- **Image:** mysql:5.7
- **Container Name:** mysql_db
- **Port:** 3001:3306
- **Default Database:** app_database
- **Root User:** root
- **App User:** developer

## Database Operations

### Execute SQL Query Directly

```bash
docker exec mysql_db mysql -uroot -prootpassword -e "SELECT * FROM app_database.your_table;"
```

### Access MySQL Shell

```bash
docker exec -it mysql_db mysql -uroot -prootpassword
```

### Connect as Developer User

```bash
docker exec -it mysql_db mysql -udeveloper -pSec@2025 -D app_database
```

## CI/CD Pipeline

### Automated Docker Hub Deployment

Every push to the `main` branch triggers an automatic build and deployment:

1. **Trigger:** Push to main branch
2. **Build:** Docker images for web and MySQL services
3. **Push:** Images sent to Docker Hub with tags:
   - `latest` - Most recent version
   - `<commit-sha>` - Specific commit version

### GitHub Secrets Required

Add these secrets to your GitHub repository:

- `DOCKER_HUB_USERNAME` - Your Docker Hub username
- `DOCKER_HUB_TOKEN` - Your Docker Hub access token

**Generate token:** https://hub.docker.com/settings/security

## Common Commands

```bash
# Start services
docker compose up -d

# Stop services
docker compose down

# View logs
docker compose logs -f

# Access web container shell
docker exec -it php_app_72 /bin/bash

# Access MySQL container shell
docker exec -it mysql_db /bin/bash

# Rebuild images
docker compose build --no-cache
```

## Troubleshooting

### Port Already in Use

If ports 8083 or 3001 are already in use, edit `docker-compose.yml`:

```yaml
ports:
  - "YOUR_PORT:PORT_INSIDE_CONTAINER"
```

### Database Connection Failed

Ensure MySQL container is running:

```bash
docker ps | grep mysql_db
```

Check logs:

```bash
docker compose logs db
```

### Permission Denied on src/

```bash
# Give write permissions
chmod -R 755 src/
```

## Environment Configuration

Key PHP settings can be configured via environment variables:

```env
PHP_DISPLAY_ERRORS=1
PHP_DATE_TIMEZONE=America/Sao_Paulo
WEB_DOCUMENT_ROOT=/app
```

## Development Workflow

1. Place PHP files in `./src/` directory
2. Files are automatically available at `http://localhost:8083`
3. Changes are reflected immediately (no rebuild needed)
4. Database queries run against MySQL on port 3001

## Persistence

- **Database Data:** Stored in `db_data` Docker volume
- **Application Files:** Mapped from `./src` directory

Data persists between container restarts.

## Contributing

1. Create feature branch: `git checkout -b feature/your-feature`
2. Commit changes: `git commit -m "Add feature"`
3. Push to main: `git push origin main`
4. Automatic deployment triggers on push

## Support

For issues or questions, check the troubleshooting section or consult Docker documentation.

## License

MIT License - Feel free to use this project for your needs.

## 🧑🏼‍🚀 Developer
| Desenvolvedor      | LinkedIn                                   | Email                        | Portfólio                              |
|--------------------|--------------------------------------------|------------------------------|----------------------------------------|
| Wallace Camargo    | [LinkedIn](https://www.linkedin.com/in/wallace-camargo-35b615171/) | wallacecpdg@gmail.com        | [Portfólio](https://wlcamargo.github.io/)   |