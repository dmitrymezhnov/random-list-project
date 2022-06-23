 ifneq (,$(wildcard ./.env))
    include .env
    export
endif

help:
	echo "coming soon..."

install-meteor:
	npm install meteor -g

init:
	nvm use ${NODE_VERSION}

extract:
	meteor create --svelte ${APPS_DEV_PATH}/${APP_NAME}-app
	mv "${APPS_DEV_PATH}/${APP_NAME}-app" "${APP_DEV_PATH}"
	(cd "${APP_DEV_PATH}" && rm -r -f client imports server tests)
	cp -a "./build/." "${APP_DEV_PATH}"
	cp -a "./.env" "${APP_DEV_PATH}"
	cp -a "./.env.example" "${APP_DEV_PATH}"
	(cd "${APP_DEV_PATH}" && make set-up)

extract--run: extract run

extract--deploy: extract deploy

extract--up: extract up

set-up:
	meteor npm install
	meteor add dev-error-overlay
	meteor add accounts-password
	meteor npm install --save bcrypt
	meteor remove insecure
	meteor remove autopublish
	meteor add meteortesting:mocha
	meteor npm install --save-dev chai

set-up--run: set-up run

run:
	(cd "${APP_DEV_PATH}" && meteor)

up: deploy run-bundle

deploy:
	(cd "${APP_DEV_PATH}" && make deploy)

deploy--run: deploy run-bundle

clear-docker-cache:
	docker builder prune -f
	docker builder prune -f

run-bundle:
	docker-compose -p ${APP_NAME} -f "${COMPOSE_PATH}" --env-file .env up

del-app:
	rm -r -f "${APP_DEV_PATH}"

del-bundle:
	rm -r -f "${APP_PATH}"

del: del-app del-bundle

test:
	echo "test"