NAME = inception

all: up

build:
	docker-compose build

up:
	docker-compose up -d

down:
	docker-compose down

clean:
	docker system prune -af
	docker volume rm $(docker volume ls -q)

fclean: down clean

re: fclean all
