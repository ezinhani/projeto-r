#!/bin/bash

#On error no such file entrypoint.sh, execute in terminal - dos2unix entrypoint.sh

### BACK-END
cd backend

if [ ! -f ".env" ]; then
  cp .env.example .env
fi

if [ ! -f ".env.testing" ]; then
  cp .env.testing.example .env.testing
fi

composer install

php artisan key:generate
php artisan migrate
php artisan config:clear
php artisan clear:data
php artisan cache:clear
php artisan view:clear
php artisan route:clear
php artisan clear-compiled
php artisan config:cache
php artisan key:generate
php artisan migrate --seed

php-fpm

rm entrypoint.sh