Creation des docker:

docker run -d --name mariadb-container --network my_network -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=testdb mariadb:latest
# Ce conteneur exécute MariaDB avec un mot de passe root et crée une base de données appelée testdb


http:
docker run -d --name http --network my_network -p 8080:80 \
-v "C:\Users\neila\OneDrive\Bureau\Documents\EFREI\ML OPS\docker-tp2\Etape2\http\default.conf:/etc/nginx/conf.d/default.conf" \
-v "C:\Users\neila\OneDrive\Bureau\Documents\EFREI\ML OPS\docker-tp2\Etape2\app:/app" \
nginx
# Ce conteneur exécute NGINX, expose le port 8080 et utilise un fichier de configuration personnalisé pour pointer vers l'application


php:
docker run -d --name script --network my_network -v "C:\Users\neila\OneDrive\Bureau\Documents\EFREI\ML OPS\docker-tp2\Etape2\app:/app" php:7.4-fpm
# Ce conteneur exécute PHP avec FPM, partage le même volume que HTTP pour que NGINX puisse y accéder

Affichage de docker
docker ps
# Affiche tous les conteneurs actuellement actifs

docker logs http
# Affiche les logs du conteneur spécifié pour déboguer les erreurs éventuelles

docker inspect http
# Affiche les détails complets d'un conteneur, utile pour vérifier les configurations et réseaux

docker network inspect my_network
# Affiche les détails du réseau pour vérifier si les conteneurs sont bien connectés

docker exec -it <nom_du_conteneur> bash
# Ouvre un terminal interactif dans le conteneur spécifié, utile pour des tâches administratives


Etape 3:

Cration d'un nouveau docker pour avoir les config qu'il faut pour wordpress
docker run -d --name data --network my_network -e MYSQL_ROOT_PASSWORD=root -e MYSQL_DATABASE=wordpress data:latest
aadf6ff1d06ae68cb1bfeb7d740267f447dd55ba5d58315157c16237f780f344

docker run -d --name script --network my_network -v "C:\Users\neila\OneDrive\Bureau\Documents\EFREI\ML OPS\docker-tp2\Etape3\app:/app" script:latest

Installer les extensions PHP dans le conteneur 
docker exec -it script bash
docker-php-ext-install mysqli
exit

Installation de http avec wordpress
docker run -d --name http --network my_network -p 8080:80 -v "C:\Users\neila\OneDrive\Bureau\Documents\EFREI\ML OPS\docker-tp2\Etape3\http\default.conf:/etc/nginx/conf.d/default.conf" -v "C:\Users\neila\OneDrive\Bureau\Documents\EFREI\ML OPS\docker-tp2\Etape3\app\wordpress:/app" http:latest

Inspecter le réseau
docker network inspect my_network

docker run -d --name script -v "C:\Users\neila\OneDrive\Bureau\Documents\EFREI\ML OPS\docker-tp2\Etape3/"wordpress:/var/www/html php:7.4-fpm

docker run -d --name http -p 8080:80 -v "C:\Users\neila\OneDrive\Bureau\Documents\EFREI\ML OPS\docker-tp2\Etape3/http\default.conf:/etc/nginx/conf.d/default.conf"/nginx.conf:/etc/nginx/conf.d/default.conf -v "C:\Users\neila\OneDrive\Bureau\Documents\EFREI\ML OPS\docker-tp2\Etape3/http\default.conf:/etc/nginx/conf.d/default.conf" wordpress:/var/www/html --link script:script nginx:latest



création de l'image de http 
docker build -t http:latest -f http/Dockerfile .

docker build -t data:latest -f data/Dockerfile .

docker build -t script:latest -f php/Dockerfile .
