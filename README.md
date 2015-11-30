Drupal 7 environment for Decompose intended to help developers quickly start a Drupal 7 environment and run it on a production server.

# Requirements

- [Decompose](https://github.com/dmp1ce/decompose)
- [Docker](http://www.docker.com/)
- [Docker Compose](http://docs.docker.com/compose/)

# Quick Start

``` sh
decompose --init https://github.com/dmp1ce/decompose-drupal-7.git
# Download Drupal 7 into containers/source/source/httpdocs
decompose build && decompose up
```
