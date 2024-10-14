docker network create app-network

##création d'image à la racine du projet 
docker build -t custom-nginx -f http/Dockerfile .

docker build -t custom-php-fpm -f php/Dockerfile .

##Lancement du container Script 
docker run -d --name script --network app-network custom-php-fpm

##Lancement du container Http
docker run -d --name http --network app-network -p 8080:8080 custom-nginx

##Vérification du réseau (il doit y avoir les duex containers à l'intérieur)
docker network inspect app-network  

#Test simple de reqête PHP dna sle container Script pour verifier si php-fpm est capable de traiter des scripts php 
docker exec -it script php -r "phpinfo();"
