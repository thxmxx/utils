#!/bin/sh

DB_PORT=27017
TIMESTAMP=`date +%F-%H%M`;
BACKUP_NAME="$MONGO_DATABASE-$TIMESTAMP" 1>&2;

echo "Performing backup of $MONGO_DATABASE. BACKUPS_DIR=$BACKUPS_DIR" 1>&2;
echo "--------------------------------------------" 1>&2;
if ! mkdir -p $BACKUPS_DIR; then
	echo "Can't create backup directory in $BACKUPS_DIR. Go and fix it!" 1>&2;
exit 1;
fi;
mongodump -h $HOSTNAME -u $DB_USER -p $DB_PASSWORD -d $MONGO_DATABASE --authenticationDatabase=admin -o $BACKUPS_DIR/$BACKUP_NAME --verbose;
find $BACKUPS_DIR -mtime +$DAYSTORETAINBACKUP -exec rm -rf {} +;
echo "--------------------------------------------" 1>&2;
echo "Database backup complete!" 1>&2;
