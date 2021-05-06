FROM mysql:5.7.8
COPY ./mysql/initDB.sql docker-entrypoint-initdb.d/
COPY ./mysql/populateDB.sql docker-entrypoint-initdb.d/