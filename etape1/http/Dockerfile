# Utiliser l'image NGINX de base
FROM nginx:latest

# Copier la configuration personnalisée de NGINX (./http/default -- création de l'image à la racine du projet) - faire attention au chemin
COPY ./http/default.conf /etc/nginx/conf.d/default.conf

# Copier le code de l'application dans le conteneur
COPY ./app /app

# Exposer le port 8080
EXPOSE 8080
