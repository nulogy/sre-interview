#!/usr/bin/env bash

until pg_isready -h "$PGHOST" -p "5432" -U "postgres"; do
  echo "Waiting for PostgreSQL..."
  sleep 2
done

psql "host=$PGHOST port=5432 user=postgres dbname=postgres" <<EOF
CREATE TABLE IF NOT EXISTS random_numbers (
    id SERIAL PRIMARY KEY,
    value SMALLINT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
EOF

while true; do
  VALUE=$RANDOM
  psql "host=$PGHOST port=5432 user=postgres dbname=postgres" <<EOF
INSERT INTO random_numbers (value) VALUES ($VALUE);
EOF
  echo "Added $VALUE"
  sleep 1
done
