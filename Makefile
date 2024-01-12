include sessions_backend/.env

start:
	sh start.sh

stop: # Stop the project
	@echo "Stopping the project"
	$(DOCKER_COMPOSE) stop
	$(DOCKER_COMPOSE) down --volumes --remove-orphans
	@docker rm $(API_CONTAINER) || true
	@docker rm $(WEB_CONTAINER) || true
	@docker rm $(DB_CONTAINER) || true

stop-persist: ## Stop the project for Widnows Users
	@echo "Stopping the project persistant"
	$(DOCKER_COMPOSE) stop

db-backup: # DB Backup
	- docker exec -i $(DB_CONTAINER) /bin/bash -c "PGPASSWORD=$(DB_PASSWORD) pg_dump --username $(USERNAME) $(DB_NAME)" > db/dev/postgress.sql

db-connect: # DB Connect for MAC Users
	- $(DOCKER_COMPOSE) exec $(DB_CONTAINER) psql -U $(USERNAME) $(USERNAME)

db-connect-heroku: # DB Connect for MAC Users
	- pgcli $(DB_URI_HEROKU)

# db-execute: # DB execute PGCLI
# 	- $(DOCKER_COMPOSE) exec $(DB_CONTAINER) pgcli postgres://$(USERNAME):$(DB_PASSWORD)@0.0.0.0:5432/$(DB_NAME)

db-connect-windows: # DB Connect for Windows Users
	- winpty $(DOCKER_COMPOSE) exec $(DB_CONTAINER) psql -U $(USERNAME) $(USERNAME)

logs-backend: # Show the logs from the backend
	- $(DOCKER_COMPOSE) logs -f $(API_CONTAINER)

logs-web: # Show the logs from the backend
	- $(DOCKER_COMPOSE) logs -f $(WEB_CONTAINER)

ps: # List the running containers
	- $(DOCKER_COMPOSE) ps

console:
	- $(DOCKER_COMPOSE) exec $(API_CONTAINER) rails console

shell-db: ## Open a sh shell in the Database
	- docker exec -it $(DB_CONTAINER) bash

shell-api:
	- docker exec -it $(API_CONTAINER) bash

db-restore:
	- $(DOCKER_COMPOSE) exec -T $(DB_CONTAINER) pg_restore -U $(USERNAME) -d $(USERNAME) < /path/name.pgsql

logs-db:
	- $(DOCKER_COMPOSE) logs -f $(DB_CONTAINER)

dump-table:
	- $(DOCKER_COMPOSE) exec db pg_dump -U $(USERNAME) -st $(table) $(DB_NAME) > db/dumps/$(table).txt

migration-create:
	- $(DOCKER_COMPOSE) exec $(API_CONTAINER) rails generate migration $(method)

migration-rollback:
	- $(DOCKER_COMPOSE) exec $(API_CONTAINER) rails db:rollback

install:
	- $(DOCKER_COMPOSE) exec $(API_CONTAINER) bundle install

routes:
	- $(DOCKER_COMPOSE) exec $(API_CONTAINER) rails routes

migration-create-column:
	- $(DOCKER_COMPOSE) exec $(API_CONTAINER) rails generate migration AddFieldsDeletionToUser deletion:boolean

migration-migrate:
	- $(DOCKER_COMPOSE) exec $(API_CONTAINER) rake log db:migrate

test-generate-controller: 
	- $(DOCKER_COMPOSE) exec $(API_CONTAINER) rails g rspec:controller $(controller)

test-generate-model: 
	- $(DOCKER_COMPOSE) exec $(API_CONTAINER) rails g rspec:model $(model)

test-run:
	- $(DOCKER_COMPOSE) exec $(API_CONTAINER) rspec

test-stats:
	- $(DOCKER_COMPOSE) exec $(API_CONTAINER) rails stats