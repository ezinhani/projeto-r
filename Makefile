USER=resolutte
APP_NAME=resolutte

.DEFAULT_GOAL := list

.PHONY: list
list:
	@echo "Menu:"
	@echo "1 	> 	docker-compose up -d"
	@echo "2 	> 	docker-compose down"
	@echo "3 	> 	docker-compose build All"
	@echo "4 	> 	docker-compose build 'Image'"
	@echo "5 	> 	Pull Local"
	@echo "6 	> 	Push Local"
	@echo "7 	> 	Pull Dockerhub"
	@echo "8 	> 	Push Dockerhub"
	@echo "k 	> 	K8S - kubectl apply"
	@echo "e 	> 	Exec -it 'Conteiner'"

DataUp:
	docker-compose -f ~/docker/docker-db/docker-compose.yml --env-file ~/docker/docker-db/.env up -d mysql redis mongo

DataDown:
	docker-compose -f ~/docker/docker-db/docker-compose.yml  --env-file ~/docker/docker-db/.env down

.PHONY: docker-compose up -d
1:	DataUp
	docker-compose up -d

.PHONY: docker-compose down
2:	DataDown
	docker-compose down

.PHONY: docker-compose build All
3:
	docker-compose stop
	docker-compose rm -f
	docker-compose pull
	docker-compose build --no-cache
	docker-compose up -d --force-recreate --remove-orphans

.PHONY: docker-compose build Image
4:
	@echo -n "Digite o nome da(s) imagem(ns): ";\
	read imagem;\
	docker-compose stop $$imagem;\
	docker-compose rm -f $$imagem;\
	docker-compose pull $$imagem;\
	docker-compose build --no-cache $$imagem;\
	docker-compose up -d --force-recreate --remove-orphans $$imagem

RegistryUp:
	docker-compose -f ~/docker/docker-registry/docker-compose.yml up -d

RegistryDown:
	docker-compose -f ~/docker/docker-registry/docker-compose.yml down

RegistryLogin:
	USER=localhost:5000
	docker login --username registry --password-stdin < ~/docker/docker-registry/.docker/docker-registry/config/login.txt localhost:5000

DockerhubLogin:
	docker login -u ${USER}

DPullToDockerhub:
	docker pull ${USER}/${APP_NAME}-app
	docker pull ${USER}/${APP_NAME}-nginx
	docker pull ${USER}/${APP_NAME}-node
	docker pull ${USER}/${APP_NAME}-mysql
	docker pull ${USER}/${APP_NAME}-postgres
	docker pull ${USER}/${APP_NAME}-redis
	docker pull ${USER}/${APP_NAME}-redis-webui
	docker pull ${USER}/${APP_NAME}-mongo
	docker pull ${USER}/${APP_NAME}-mongo-webui
	docker pull ${USER}/${APP_NAME}-adminer
	docker pull ${USER}/${APP_NAME}-mailhog
	docker pull ${USER}/${APP_NAME}-minio

DPushToDockerhub:
	docker push ${USER}/${APP_NAME}-app
	docker push ${USER}/${APP_NAME}-nginx
	docker push ${USER}/${APP_NAME}-node
	docker push ${USER}/${APP_NAME}-mysql
	docker push ${USER}/${APP_NAME}-postgres
	docker push ${USER}/${APP_NAME}-redis
	docker push ${USER}/${APP_NAME}-redis-webui
	docker push ${USER}/${APP_NAME}-mongo
	docker push ${USER}/${APP_NAME}-mongo-webui
	docker push ${USER}/${APP_NAME}-adminer
	docker push ${USER}/${APP_NAME}-mailhog
	docker push ${USER}/${APP_NAME}-minio

DTagToDockerhub:
	docker tag ${APP_NAME}-nginx        		${USER}/${APP_NAME}-nginx
	docker tag ${APP_NAME}-app          		${USER}/${APP_NAME}-app
	docker tag ${APP_NAME}-node         		${USER}/${APP_NAME}-node
	docker tag ${APP_NAME}-mysql        		${USER}/${APP_NAME}-mysql
	docker tag ${APP_NAME}-postgres     		${USER}/${APP_NAME}-postgres
	docker tag ${APP_NAME}-redis        		${USER}/${APP_NAME}-redis
	docker tag ${APP_NAME}-redis-webui  		${USER}/${APP_NAME}-redis-webui
	docker tag ${APP_NAME}-mongo        		${USER}/${APP_NAME}-mongo
	docker tag ${APP_NAME}-mongo-webui  		${USER}/${APP_NAME}-mongo-webui
	docker tag ${APP_NAME}-adminer      		${USER}/${APP_NAME}-adminer
	docker tag ${APP_NAME}-mailhog      		${USER}/${APP_NAME}-mailhog
	docker tag ${APP_NAME}-minio        		${USER}/${APP_NAME}-minio

DTagToUser:
	docker tag ${USER}/${APP_NAME}-app           ${APP_NAME}-app
	docker tag ${USER}/${APP_NAME}-nginx         ${APP_NAME}-nginx
	docker tag ${USER}/${APP_NAME}-node          ${APP_NAME}-node
	docker tag ${USER}/${APP_NAME}-mysql         ${APP_NAME}-mysql
	docker tag ${USER}/${APP_NAME}-postgres      ${APP_NAME}-postgres
	docker tag ${USER}/${APP_NAME}-redis         ${APP_NAME}-redis
	docker tag ${USER}/${APP_NAME}-redis-webui   ${APP_NAME}-redis-webui
	docker tag ${USER}/${APP_NAME}-mongo         ${APP_NAME}-mongo
	docker tag ${USER}/${APP_NAME}-mongo-webui   ${APP_NAME}-mongo-webui
	docker tag ${USER}/${APP_NAME}-adminer       ${APP_NAME}-adminer
	docker tag ${USER}/${APP_NAME}-mailhog       ${APP_NAME}-mailhog
	docker tag ${USER}/${APP_NAME}-minio         ${APP_NAME}-minio

DRmiImageDockerhub:
	docker rmi -f ${USER}/${APP_NAME}-app
	docker rmi -f ${USER}/${APP_NAME}-nginx
	docker rmi -f ${USER}/${APP_NAME}-node
	docker rmi -f ${USER}/${APP_NAME}-mysql
	docker rmi -f ${USER}/${APP_NAME}-postgres
	docker rmi -f ${USER}/${APP_NAME}-redis
	docker rmi -f ${USER}/${APP_NAME}-redis-webui
	docker rmi -f ${USER}/${APP_NAME}-mongo
	docker rmi -f ${USER}/${APP_NAME}-mongo-webui
	docker rmi -f ${USER}/${APP_NAME}-adminer
	docker rmi -f ${USER}/${APP_NAME}-mailhog
	docker rmi -f ${USER}/${APP_NAME}-minio

DRmiImageUser:
	docker rmi -f ${APP_NAME}-app
	docker rmi -f ${APP_NAME}-nginx
	docker rmi -f ${APP_NAME}-node
	docker rmi -f ${APP_NAME}-mysql
	docker rmi -f ${APP_NAME}-postgres
	docker rmi -f ${APP_NAME}-redis
	docker rmi -f ${APP_NAME}-redis-webui
	docker rmi -f ${APP_NAME}-mongo
	docker rmi -f ${APP_NAME}-mongo-webui
	docker rmi -f ${APP_NAME}-adminer
	docker rmi -f ${APP_NAME}-mailhog
	docker rmi -f ${APP_NAME}-minio

.PHONY: Pull in docker registry
5:	RegistryUp RegistryLogin DPullToDockerhub DRmiImageUser DTagToUser DRmiImageDockerhub RegistryDown

.PHONY: Push in docker registry
6:	RegistryUp RegistryLogin DTagToDockerhub DPushToDockerhub DRmiImageDockerhub RegistryDown

.PHONY: Pull in docker registry
7:	DockerhubLogin DPullToDockerhub DRmiImageUser DTagToUser DRmiImageDockerhub

.PHONY: Push in docker registry
8:	DockerhubLogin DTagToDockerhub DPushToDockerhub DRmiImageDockerhub

.PHONY: K8S - kubectl apply
k:
	kubectl apply -f k8s/

.PHONY: Exec -it image
e:
	@echo -n "Digite o nome da imagem: ";\
	read imagem;\
	docker exec -it $$imagem bash

.PHONY: Executar comandos artisan <c1> <c2> <c3> <c4> <c5>
artisan:
	@echo -n "Digite o comando: ";\
	read artisan;\
	docker-compose run --rm artisan $$artisan

.PHONY: Executar comandos do composer
composer:
	@echo -n "Digite o comando: ";\
	read composer;\
	docker-compose run --rm composer $$composer

.PHONY: Executar comandos do npm
npm:
	@echo -n "Digite o comando: ";\
	read npm;\
	docker-compose run --rm --entrypoint npm npm $$npm
