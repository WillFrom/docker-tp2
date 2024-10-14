# Utiliser l'image PHP avec FPM
FROM php:7.4-fpm

# Installer les extensions PDO et PDO_MySQL
RUN docker-php-ext-install pdo pdo_mysql 

# Copier le code de l'application dans le conteneur
COPY ./app /app

# Définir le répertoire de travail
WORKDIR /app
