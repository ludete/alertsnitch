#!/bin/bash

set -EeufCo pipefail
IFS=$'\t\n'

echo "Creating DB"
mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --host=${MYSQL_HOST} --port=${MYSQL_PORT} -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

echo "Creating bootstrapped model"
mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --host=${MYSQL_HOST} --port=${MYSQL_PORT} "${MYSQL_DATABASE}" < ../db.d/mysql/0.0.1-bootstrap.sql

#echo "Applying fingerprint model update"
#mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --host=127.0.0.1 "${MYSQL_DATABASE}" < ../db.d/mysql/0.1.0-fingerprint.sql
echo "创建定期删除数据的事件任务"
mysql --user=root --password="${MYSQL_ROOT_PASSWORD}" --host=${MYSQL_HOST} --port=${MYSQL_PORT} "${MYSQL_DATABASE}" < ../db.d/mysql/event.sql

echo "Done creating model"