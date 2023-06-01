the directory dbAdmin is the physical counterpart of /opt/dbAdmin declared as VOLUME in the
docker database server image openroberta/db_server:<hsqldb-version>

dbAdmin contains
* the log file 'ora-db.log' and
* the directory 'dbBackup' with database backups