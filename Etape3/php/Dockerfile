# Utiliser l'image PHP 7.4 avec FPM
FROM php:7.4-fpm

# Installer les dépendances système
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    libonig-dev \
    libxml2-dev \
    libzip-dev \
    zip \
    unzip

# Installer les extensions PHP requises
RUN docker-php-ext-configure gd --with-jpeg --with-freetype
RUN docker-php-ext-install pdo_mysql mysqli mbstring exif pcntl bcmath gd zip

# Copier le code de l'application dans le conteneur
COPY ../app /app

# Définir le répertoire de travail
WORKDIR /app
