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
	meteor build ${APPS_PATH} --server-only --directory --architecture os.linux.x86_64
	mv "${APPS_PATH}/bundle" "${APP_PATH}"
	cp -a "${APP_DEV_PATH}/build/." "${APP_PATH}"
	cp -a "${APP_DEV_PATH}/.env" "${APP_PATH}"

deploy--run: deploy run-bundle

clear-docker-cache:
	docker builder prune -f
	docker builder prune -f

run-bundle:
	docker-compose -p ${APP_NAME} -f "${COMPOSE_PATH}" --env-file .env up

del-bundle:
	rm -r -f "${APP_PATH}"