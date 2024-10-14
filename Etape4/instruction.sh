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

#Création d'un container data et connecter au réseau app-network (Pas besoin de dockerfile ici puisqu'on appelle une image déjà disponible dans docker hub sans faire de modification) l'image mysql va ête télécharger et copier dans le container
docker run -d --name data --network app-network -e MYSQL_ROOT_PASSWORD=root_password -e MYSQL_DATABASE=mydatabase -e MYSQL_USER=myuser -e MYSQL_PASSWORD=mypassword mysql:latest

##Création d'une base de données dans mysql pour que quand la page se refres il y a une création de données qui se fait 
##connextion au container MySql
docker exec -it data mysql -umyuser -pmypassword mydatabase

##Création de la table test_table qui est inscrite dans le fichier test_bdd.php
CREATE TABLE test_table (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

##Véification de la table
SHOW TABLES;

##Vérification de la structure de la table
DESCRIBE test_table;
 
exit
##Lancement Compose
docker-compose up --build

##Démarrez les services (création de container...)
docker-compose up -d

#Si problème au niveau de la connexion à la page localhost il faut vider les volumes et refaire
docker-compose down -v
docker-compose up -d --build