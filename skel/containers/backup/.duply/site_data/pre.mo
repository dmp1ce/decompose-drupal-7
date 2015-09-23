#!/bin/bash

# Export mysql database
mysqldump -u {{PROJECT_DB_USER}} -p{{PROJECT_DB_PASSWORD}} -d {{PROJECT_DB_DATABASE}} -h db | gzip > /srv/http/sql_backup/app.sql.gz
