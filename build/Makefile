ifneq (,$(wildcard ./.env))
    include .env
    export
endif

run:
	docker-compose -p ${APP_NAME} --env-file .env up