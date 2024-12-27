# Variables
DOCKER_COMPOSE = docker-compose
SRC_DIR = ./src

# Default target: build and run containers
all:
	$(DOCKER_COMPOSE) -f $(SRC_DIR)/docker-compose.yml up --build -d

# Clean up
clean:
	$(DOCKER_COMPOSE) -f $(SRC_DIR)/docker-compose.yml down --volumes --remove-orphans

# Rebuild and restart
re: clean all
