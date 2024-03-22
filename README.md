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

Le premier et le plus important des fichiers de configuration à éditer. A noter, vous pouvez consultez la liste des ports déjà utilisés avec la commande `ss -lptun` sur un terminal.

`APACHE PORT` permet de configurer le port du container php:apache. Il est par défaut redirigé sur le port 8081 de la machine hôte.

`POSTGRES_PORT` permet de configurer le port du container postgres. Il est par défaut redirigé sur le port 5431 de la machine hôte.

`POSTGRES_USER` est le nom du superutilisateur de la base de données postgres (voir 'Environment variables' de l'[image docker PostgreSQL](https://hub.docker.com/_/postgres/)). _Nous vous conseillons de conserver "namo" ou "postgres"._

`POSTGRES_PASSWORD` est le mot de passe du superutilisateur (voir 'Environment variables' de l'[image docker PostgreSQL](https://hub.docker.com/_/postgres/)).

`POSTGRES_DB` est le nom de la base de données à créer (voir 'Environment variables' de l'[image docker PostgreSQL](https://hub.docker.com/_/postgres/)). _Nous vous conseillons de conserver le nom "namo"._

`ADMIN_USERNAME` est le nom d'utilisateur du premier administrateur de la plateforme NAMO, et l'identifiant qu'il utilisera pour se connecter et autoriser la création d'autres utilisateurs ([voir documentation NAMO GeoWeb](https://github.com/GradelerM/NAMOgeoweb/wiki/Administrator-interface)).

`ADMIN_PASSWORD` est le mot de passe de cet administrateur.

`ADMIN_MAIL` est le mail de cet administrateur sur lequel il recevra des notifications relatives à la plateforme.

`WEBCONNEXION_PASSWORD` est le mot de passe à attribuer au rôle `webconnexion` qui permet à l'application de se connecter à sa base de données. **Ce mot de passe doit être manuellement indiqué dans le fichier apache/init/config.php (voir étape suivante)**.

#### Le fichier config.php

Accédez ensuite au fichier `/apache/init/config.php` et modifiez les valeurs suivantes en fonction de celles entrées dans le fichier `.env`.

`$_SESSION['db_name']` est une **chaîne de caractères** qui prend la valeur de POSTGRES_DB. Elle contient le nom de la base de données à laquelle se connnecter.

`$_SESSION['db_password']` est une **chaîne de caratères** qui prend la valeur de WEBCONNEXION_PASSWORD. Elle contient le mot de passe pour que l'utilisateur `webconnexion` puisse accéder à la base de données.

> Note: conservez absolument les valeurs par défaut de $_SESSION['db_host'],  $_SESSION['db_port'] et $_SESSION['db_user'] si vous n'avez pas modifié le docker-compose.

Vous pouvez ensuite commencer à personnaliser votre instance de NAMO GeoWeb.

`$project_name` est une **chaîne de caractères** qui prend la valeur du nom de votre projet. Celui-ci apparaît à divers endroits dans l'application et dans les mails envoyés aux utilisateurs.

> Note : allez dans la section "configuration optionnelle" pour des explications sur les autres variables de config.php.

#### Le fichier about.html

Enfin, ouvrez le fichier `apache/init/optional/about.html`. Entrez ici des informations sur votre projet qui seront visibles quand l'utilisateur cliquera sur le bouton "A propos" du menu (texte à rédiger au [format HTML](https://w3tutoriels.com/html/html-formatage-texte/)).

**Si vous souhaitez personnaliser votre instance NAMO GeoWeb, appliquez aussi une configuration optionnelle. Sinon, passez directement à l'étape "installation".**

### Configuration optionnelle

#### Mail noreply

Vous pouvez éditer l'adresse mail "noreply" dans `apache/init/config.php`. Par défaut, il prendra la forme de noreply@namo.com mais vous pouvez le personnaliser avec le nom de votre projet.

#### Lien vers un dépôt / la documentation

Si vous avez votre propre dépôt NAMO GeoWeb ou bien une documentation spécifique à votre projet, vous pouvez remplacer les liens du dépôt officiel de NAMO et du wiki dans `/apache/init/config.php`.

`$repo_link` pointe vers votre dépôt.
`$wiki_link` pointe vers votre documentation.

> Note : Assurez-vous que vos propres dépôts et wikis contiennent au moins autant d'informations que ceux de NAMO GeoWeb.

#### Ajouter un logo

Si vous avez un logo pour votre projet, vous pouvez l'ajouter à la place du logo NAMO GeoWeb. Nous vous recommandons d'avoir une version "horizontale" du logo et une plus "verticale" ou "carrée".

Commencez par placer les images dans le dossier `/apache/init/optional/logos` puis indiquez leur nom **et leur extension** (PNG, SVG, JPEG, JPG, GIF) dans `/apache/init/config.php`.

`$vertical_logo` prend le nom et l'extension du logo vertical.

`$horizontal_logo` prend le nom et l'extension du logo horizontal.

#### Modifier les couleurs

Vous avez aussi la possibilité de modifier les couleurs de l'application dans le fichier `/apache/init/optional/palette.css`. Les variables avec la mention `hover` indiquent un changement de couleur au survol avec la souris.

Exemple : `--main` correspond à la couleur dominante de l'application et s'applique par exemple au bouton "Se connecter". `--main-hover` est une version plus sombre de `--main` pour assombrir le bouton quand l'utilisateur passe dessus avec sa souris.

## Installation

Une fois que vous avez terminé, ouvrez un terminal au niveau du fichier `docker-compose.yml` et lancez la commande suivante :

```bash
docker compose up
```

Attendez ensuite jusqu'à ce que vous voyiez apparaître la mention `database system is ready to accept connections`. Accédez ensuite à `localhost:8081` dans votre navigateur pour accéder à l'application.

## Après l'installation

Vous pouvez ensuite accéder à la carte et vous authentifier avec ADMIN_USERNAME et ADMIN_PASSWORD (définis dans `.env`) en cliquant sur le bouton "Se connecter". Ensuite, nous vous conseillons de suivre les indications du [wiki de l'application](https://github.com/GradelerM/NAMOgeoweb/wiki) pour ajouter de nouveaux utilisateurs, ajouter des sources de données et / ou commencer à rédiger des cartes narratives.

## Notes

L'application est toujours en cours de développement et c'est aussi le cas de ce docker-compose. Quelques éléments sont encore en cours d'amélioration, dont les suivants :

### L'envoi des mails

L'envoi des mails n'est pas encore complètement opérationnel sur NAMO GeoWeb via Docker. Les messages n'arrivent pas encore à destination 

## Financements

Le développement de la plateforme NAMO GeoWeb et NAMO GeoWeb Docker a été rendu possible par le projet FEDER Rivage porté par un consortium de recherche pluridisciplinaire et des bailleurs institutionnels dont les principaux sont la Région Guadeloupe et l'Union européenne de par le fonds Feder en Guadeloupe.
NaMo GeoWeb se base sur une idée origonale de Marie Gradeler et Jean-Pierre Chéry pour le projet RestEAUr'Lag, sur des financements de la Foindation de France.
