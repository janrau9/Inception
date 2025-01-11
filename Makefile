# Variables
DOCKER_COMPOSE=docker-compose
SRC_DIR=./src
DATA_DIR=/home/jberay/data
WEB_DIR=$(DATA_DIR)/wp_data
DB_DIR=$(DATA_DIR)/db_data

# Default target: build and run containers
all:
	# Check if the directories exist, create them if not
	if [ ! -d $(WEB_DIR) ]; then mkdir -p $(WEB_DIR); fi
	if [ ! -d $(DB_DIR) ]; then mkdir -p $(DB_DIR); fi
	$(DOCKER_COMPOSE) -f $(SRC_DIR)/docker-compose.yml up --build -d

clean:
    # Remove data directory if it exists
	if [ -d $(DATA_DIR) ]; then sudo rm -rf $(DATA_DIR); fi

# Clean up
fclean: clean
    # Take down containers, volumes, and orphan containers
	$(DOCKER_COMPOSE) -f $(SRC_DIR)/docker-compose.yml down --volumes --remove-orphans --rmi all

# Rebuild and restart
re: clean all
