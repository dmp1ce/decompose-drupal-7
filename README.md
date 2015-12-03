Drupal 7 environment for Decompose intended to help developers quickly start a Drupal 7 website. Because this project uses Docker instead of a virtual machine, the website is suitable for production as well as development and testing!

# Requirements

- [Decompose](https://github.com/dmp1ce/decompose)
- [Docker](http://www.docker.com/)
- [Docker Compose](http://docs.docker.com/compose/)

# Quick Start

``` sh
decompose --init https://github.com/dmp1ce/decompose-drupal-7.git
decompose build && decompose up
```
Then visit `http://localhost/install.php` to install Drupal. Username, password and host information for the database is already entered into the settings.php so all you'll need to do is setup admin user.

Modify the `containers/source/source/drupal/make.yml` file to add the modules, themes and libraries you want. After modifying `make.yml`, run `decompose build && decompose up` again.

# Usage

Decompose uses skeleton files in the `.decompose/environment/skel` to create a starting point for working on Drupal 7. Decompose will also initialize a git repository, so `git status` will show all of the files which have been created for you. Some of the files created are `.mo` files which are template files and contain elements (variables) like `{{PROJECT_NAME}}`. These elements are defined throughout the project but primarily in `elements` and `.decompose/elements`. Many tasks can be done with a decompose process such as `decompose build` or `decompose up`.

## File structure

After `decompose --init https://github.com/dmp1ce/decompose-drupal-7.git` is run, the following directory structure will be created.
```
├── containers
│   ├── backup
│   ├── backup_data
│   ├── data
│   ├── nginx
│   ├── nginx_proxy
│   ├── php
│   └── source
├── docker-compose.yml.mo
├── elements
└── processes
```
The containers directory is the configuration for all containers used by Drupal 7. The backup and backup_data containers are used for backing up Drupal 7 files and database settings using Duply. The data container stores Drupal uploaded files. The nginx container containers the nginx configuration for Drupal. The nginx_proxy directory is a special directory for configuration the nginx_proxy container which can host multiple websites from the same host! See jwilder/nginx-proxy. The php directory has the php-fpm and php configuration. Finally, the source directory is a special directory for sharing the Drupal source between nginx and php containers.

The `docker-compose.yml.mo` is a template file for creating the `docker-compose.yml` file. This file configures how each container interacts with each other. It also configures various settings such as environment variables, labels and restart settings.

The elements file contains non-private elements. See [elements section](#elements).

The processes file contains non-private processes. See [processes section](#processes).

TODO: Go into more detail about each container which is used.

## Elements

TODO: Explain important elmeents

## Processes

TODO: Explain important processes

# Local development

For developing modules or hacking on Drupal core, you'll probably want to be able to edit files and see the results right away on the website without needing to rebuild the project with `decompose build && decompose up`. To avoid needing to rebuild the project, create host volumes for the directory you are working in. The `source` container in the `docker-compose.yml.mo` file has a commented out section which is an example of how to create these volumes for Drupal core, custom modules, custom themes and/or libraries. If you also want to use the overrides in production, you'll probably want them copied to the source container at build time. See the `containers/source/Dockerfile.mo` for a commented section example.
