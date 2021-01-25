#!/bin/sh

export FLASK_APP=project/__init__.py
export FLASK_ENV=development
export DATABASE_URL=postgresql://hello_flask:hello_flask@postgres:5432/hello_flask_dev
export SQL_PORT=5432
export SQL_HOST=postgres
export DATABASE=postgres

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

ip=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
#ip=${MY_IP}

python manage.py create_db --ip $ip

exec "$@"