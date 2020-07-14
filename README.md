# Resolutte

## Configurações Iniciais

Definir variáveis em Makefile:
```
USER=resolutte
APP_NAME=resolutte
```

Definir variáveis em .env:
```
COMPOSE_PROJECT_NAME=resolutte
APP_NAME=resolutte
```

Definir prefixo de nome de imagem em docker-compose.yml:

```
image: APP_NAME-nome_da_imagem
```