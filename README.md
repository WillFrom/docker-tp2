# Projet WordPress avec Docker et Docker Compose

Ce projet a pour objectif de créer un environnement de développement pour WordPress en utilisant Docker et Docker Compose. Il utilise trois conteneurs Docker pour exécuter NGINX, PHP-FPM et MySQL, orchestrés via Docker Compose pour faciliter le déploiement et la gestion.

## Table des matières

- [Pré-requis](#pré-requis)
- [Structure du projet](#structure-du-projet)
- [Étapes d'installation](#étapes-dinstallation)
  - [1. Cloner le dépôt ou créer le répertoire du projet](#1-cloner-le-dépôt-ou-créer-le-répertoire-du-projet)
  - [2. Télécharger WordPress](#2-télécharger-wordpress)
  - [3. Configurer les fichiers Docker](#3-configurer-les-fichiers-docker)
    - [3.1. Dockerfile pour PHP-FPM](#31-dockerfile-pour-php-fpm)
    - [3.2. Dockerfile pour NGINX](#32-dockerfile-pour-nginx)
    - [3.3. Configuration NGINX](#33-configuration-nginx)
    - [3.4. Fichier docker-compose.yml](#34-fichier-docker-composeyml)
  - [4. Lancer les services avec Docker Compose](#4-lancer-les-services-avec-docker-compose)
  - [5. Installer WordPress](#5-installer-wordpress)
- [Informations supplémentaires](#informations-supplémentaires)
  - [Gestion des conteneurs](#gestion-des-conteneurs)
  - [Volumes et persistance des données](#volumes-et-persistance-des-données)
- [Conclusion](#conclusion)

---

## Pré-requis

Avant de commencer, assurez-vous d'avoir les éléments suivants installés sur votre machine :

- **Docker** : [Instructions d'installation](https://docs.docker.com/get-docker/)
- **Docker Compose** : [Instructions d'installation](https://docs.docker.com/compose/install/)
- **Git**: pour cloner le dépôt nécessaire.

---

## Structure du projet

La structure du projet est organisée comme suit :

```
projet
├── app                     # Contient les fichiers WordPress
├── http                    # Contient le Dockerfile et la configuration pour NGINX
│   ├── Dockerfile
│   └── default.conf
├── php                     # Contient le Dockerfile pour PHP-FPM
│   └── Dockerfile
└── docker-compose.yml      # Fichier pour orchestrer les conteneurs avec Docker Compose
```

---

## Étapes d'installation

### 1. Cloner le dépôt ou créer le répertoire du projet

Si vous avez un dépôt Git, clonez-le :

```bash
git clone https://github.com/votre-utilisateur/votre-projet.git
cd votre-projet
```

Sinon, créez un nouveau répertoire pour votre projet :

```bash
mkdir projet
cd projet
```

### 2. Télécharger WordPress

Téléchargez la dernière version de WordPress et placez-la dans le dossier `app` :

1. Créez le dossier `app` s'il n'existe pas :

   ```bash
   mkdir app
   ```

2. **Téléchargez WordPress** :

   - Accédez au dossier `app` :

     ```bash
     cd app
     ```

   - Téléchargez la dernière version de WordPress :

     ```bash
     curl -O https://wordpress.org/latest.tar.gz
     ```

3. **Extrayez les fichiers** :

   ```bash
   tar -xzvf latest.tar.gz
   ```

4. **Déplacez les fichiers de WordPress à la racine du dossier `app`** :

   ```bash
   mv wordpress/* .
   ```

5. **Supprimez les fichiers inutiles** :

   ```bash
   rm -rf wordpress latest.tar.gz
   cd ..
   ```

### 3. Configurer les fichiers Docker

#### 3.1. Dockerfile pour PHP-FPM

- Dans le dossier `php`, créez un fichier nommé `Dockerfile`.
- Configurez-le pour utiliser l'image PHP-FPM appropriée.
- Installez les extensions PHP requises pour WordPress (par exemple, `mysqli`, `pdo_mysql`, `gd`, `mbstring`, etc.).
- Définissez le répertoire de travail dans le conteneur.

#### 3.2. Dockerfile pour NGINX

- Dans le dossier `http`, créez un fichier nommé `Dockerfile`.
- Utilisez l'image NGINX officielle comme base.
- Copiez votre configuration personnalisée de NGINX dans le conteneur.
- Exposez le port 80.

#### 3.3. Configuration NGINX

- Dans le dossier `http`, créez un fichier nommé `default.conf`.
- Configurez NGINX pour servir les fichiers WordPress.
- Assurez-vous que les requêtes PHP sont redirigées vers le conteneur PHP-FPM.
- Configurez la gestion des permaliens en utilisant `try_files`.

#### 3.4. Fichier `docker-compose.yml`

- À la racine du projet, créez un fichier nommé `docker-compose.yml`.
- Définissez les services suivants :

  - **wordpress** : construit à partir du Dockerfile dans `./php`, utilise le volume `./app:/app`, se connecte au réseau `app-network`.
  - **nginx** : construit à partir du Dockerfile dans `./http`, expose le port `8080:80`, dépend de `wordpress`, utilise le volume `./app:/app`, se connecte au réseau `app-network`.
  - **db** : utilise l'image `mysql:5.7`, définit les variables d'environnement pour la base de données, utilise un volume pour persister les données, se connecte au réseau `app-network`.

- Déclarez les volumes et réseaux nécessaires.

### 4. Lancer les services avec Docker Compose

Dans le répertoire racine du projet, exécutez la commande suivante pour construire les images et démarrer les conteneurs :

```bash
docker-compose up --build
```

Cette commande va :

- Construire les images pour les services définis.
- Lancer les services `db`, `wordpress` et `nginx`.
- Créer le réseau personnalisé pour permettre la communication entre les conteneurs.
- Monter les volumes pour persister les données et partager les fichiers de l'application.

### 5. Installer WordPress

Une fois les conteneurs démarrés, ouvrez votre navigateur web et accédez à :

```
http://localhost:8080
```

Vous devriez voir l'écran d'installation de WordPress.

#### Étapes de l'installation :

1. **Sélectionnez la langue** et cliquez sur **"Continuer"**.

2. **Informations de connexion à la base de données** :

   - **Nom de la base de données** : utilisez le nom défini dans `docker-compose.yml` (par exemple, `wordpress`).
   - **Identifiant** : utilisez l'utilisateur défini (par exemple, `wpuser`).
   - **Mot de passe** : utilisez le mot de passe défini (par exemple, `wppassword`).
   - **Adresse de la base de données** : utilisez le nom du service de la base de données (par exemple, `db`).
   - **Préfixe des tables** : laissez la valeur par défaut ou personnalisez-la.

3. Cliquez sur **"Lancer l'installation"**.

4. **Informations sur le site** :

   - **Titre du site** : choisissez un nom pour votre site.
   - **Identifiant** : définissez un identifiant pour l'administrateur.
   - **Mot de passe** : choisissez un mot de passe sécurisé.
   - **Votre adresse de messagerie** : saisissez votre adresse e-mail.

5. Cliquez sur **"Installer WordPress"**.

6. Une fois l'installation terminée, connectez-vous à l'interface d'administration avec les identifiants créés.

---

## Informations supplémentaires

### Gestion des conteneurs

**Démarrer les services en arrière-plan** :

```bash
docker-compose up -d
```

**Arrêter les services** :

```bash
docker-compose down
```

**Afficher les logs des services** :

```bash
docker-compose logs -f
```

### Volumes et persistance des données

- **Base de données** : un volume nommé (par exemple, `db_data`) assure la persistance des données MySQL.
- **Fichiers WordPress** : le volume `./app:/app` monte le dossier `app` de l'hôte dans les conteneurs, conservant ainsi les plugins, thèmes et fichiers téléchargés.

---
