ifneq (,$(wildcard ./.env))
    include .env
    export
endif

help:
	echo test

run:
	(cd "${APP_DEV_PATH}/${APP_NAME}-app-dev" && meteor)

up: deploy run-bundle

up--no-docker: deploy--no-docker run-bundle--no-docker

deploy:
	(cd "${APP_DEV_PATH}/${APP_NAME}-app-dev" && meteor build ${APP_DEV_PATH} --server-only --directory --architecture os.linux.x86_64)
	mv "${APP_PATH}/bundle" "${APP_PATH}/${APP_NAME}-app"
	cp -a "${APP_DEV_PATH}/${APP_NAME}-app-dev/build/." "${APP_PATH}/${APP_NAME}-app"
	cp -a "${APP_DEV_PATH}/${APP_NAME}-app-dev/.env" "${APP_PATH}/${APP_NAME}-app"

deploy--run: deploy run-bundle

deploy--no-docker:
	(cd "${APP_DEV_PATH}/${APP_NAME}-app-dev" && meteor build ${APP_PATH} --server-only --directory)
	mv "${APP_PATH}/bundle" "${APP_PATH}/${APP_NAME}-app"
	cp -a "${APP_DEV_PATH}/${APP_NAME}-app-dev/build/.gitignore" "${APP_PATH}/${APP_NAME}-app"
	cp -a "${APP_DEV_PATH}/${APP_NAME}-app-dev/build/Makefile" "${APP_PATH}/${APP_NAME}-app"
	cp -a "${APP_DEV_PATH}/${APP_NAME}-app-dev/build/random-list-app.code-workspace" "${APP_PATH}/${APP_NAME}-app"
	cp -a "${APP_DEV_PATH}/${APP_NAME}-app-dev/.env.example" "${APP_PATH}/${APP_NAME}-app"
	cp -a "${APP_DEV_PATH}/${APP_NAME}-app-dev/.env" "${APP_PATH}/${APP_NAME}-app"
	(cd ${APP_PATH}/${APP_NAME}-app/programs/server && npm install)

deploy--run--no-docker: deploy--no-docker run-bundle--no-docker

clear-docker-cache:
	docker builder prune -f
	docker builder prune -f

run-bundle:
	docker-compose -p ${APP_NAME} -f "${APP_PATH}/${APP_NAME}-app/docker-compose.yaml" --env-file .env up

run-bundle--no-docker:
	source "./.env"
 	(cd "${APP_PATH}/${APP_NAME}-app" && node main.js)

del-bundle:
	rm -r -f "${APP_PATH}/${APP_NAME}-app"