# NAMO GeoWeb

![Logo horizontal NAMO](apache/init/optional/logos/horizontalNAMO.svg)

Vous consultez actuellement le dépôt comprenant les fichiers permettant le déploiement de la plateforme NAMO GeoWEB avec [Docker](https://www.docker.com/). Si vous souhaitez plus d'informations sur l'application NAMO GeoWeb en elle-même, accéder à la documentation utilisateur ou avoir plus d'informations sur la licence (CECILL), [c'est par ici](https://github.com/GradelerM/NAMOgeoweb).

Vous pouvez ensuite suivre les indications de ce README pour déployer votre instance de NAMO GeoWeb.

---

## Installation de Docker et docker-compose

Commencez par installer Docker et docker-compose sur la machine sur laquelle vous souhaitez déployer NAMO GeoWeb.

* [installer Docker](https://docs.docker.com/get-docker/)
* [installer Docker Compose](https://docs.docker.com/compose/install/)

## Cloner le dépôt Git

Créez un nouveau dossier et clonez le dépôt NAMOgeoweb-docker avec la commande `git clone` :

```bash
git clone https://github.com/GradelerM/NAMOgeoweb-docker
```

## Configurer l'application

Vous pouvez conserver les valeurs par défaut pour tester l'application, mais il est impératif de modifier les fichiers de configuration avant une mise en production.

**Attention : pour votre sécurité, nous vous recommandons de choisir des mots de passe solides. Voir par exemple [les conseils de la CNIL pour un bon mot de passe](https://www.cnil.fr/fr/les-conseils-de-la-cnil-pour-un-bon-mot-de-passe).**

### Configuration obligatoire

#### Le fichier .env

Le premier et le plus important des fichiers de configuration à éditer.

`APACHE PORT` permet de configurer le port du container php:apache. Il est par défaut redirigé sur le port 8081 de la machine hôte.

`POSTGRES_PORT` permet de configurer le port du container postgres. Il est par défaut redirigé sur le port 5431 de la machine hôte.

`POSTGRES_USER` est le nom du superutilisateur de la base de données postgres (voir 'Environment variables' de l'[image docker PostgreSQL](https://hub.docker.com/_/postgres/)). _Nous vous conseillons de conserver "namo" ou "postgres"._

`POSTGRES_PASSWORD` est le mot de passe du superutilisateur (voir 'Environment variables' de l'[image docker PostgreSQL](https://hub.docker.com/_/postgres/)).

`POSTGRES_DB` est le nom de la base de données à créer (voir 'Environment variables' de l'[image docker PostgreSQL](https://hub.docker.com/_/postgres/)). _Nous vous conseillons de conserver le nom "namo"._

`ADMIN_USERNAME` est le nom d'utilisateur du premier administrateur de la plateforme NAMO, et l'identifiant qu'il utilisera pour se connecter et autoriser la création d'autres utilisateurs ([voir documentation NAMO GeoWeb](https://github.com/GradelerM/NAMOgeoweb/wiki/Administrator-interface)).

`ADMIN_PASSWORD` est le mot de passe de cet administrateur.

`ADMIN_MAIL` est le mail de cet administrateur sur lequel il recevra des notifications relatives à la plateforme.

### Configuration optionnelle

## Installation

## Après l'installation

## Notes

### L'envoi des mails

L'envoi des mails n'est pas encore complètement opérationnel sur NAMO GeoWeb via Docker. Les messages n'arrivent pas encore à destination 