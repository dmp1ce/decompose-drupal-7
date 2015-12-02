Drupal 7 environment for Decompose intended to help developers quickly start a Drupal 7 environment and run it on a production server.

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
