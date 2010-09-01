#!/bin/sh
# auto backup wwwroot data and mysql db
BACKUP_PATH=/tmp/autobackups
DATE_NAME=`date +%y%m%d`
mkdir $BACKUP_PATH
# package
mysqldump -umonster -pytrip123123 --databases pasite > $BACKUP_PATH/pasite.sql
mysqldump -umonster -pytrip123123 --databases personlab_production > $BACKUP_PATH/personlab.sql
mysqldump -umonster -pytrip123123 --databases lanxs > $BACKUP_PATH/lanxs.sql
tar zcf $BACKUP_PATH/pasite_db_$DATE_NAME.tar.gz $BACKUP_PATH/pasite.sql
tar zcf $BACKUP_PATH/personlab_db_$DATE_NAME.tar.gz $BACKUP_PATH/personlab.sql
tar zcf $BACKUP_PATH/lanxs_db_$DATE_NAME.tar.gz $BACKUP_PATH/lanxs.sql

# sendmail
echo "pasite.org db backup" | mutt -a $BACKUP_PATH/pasite_db_$DATE_NAME.tar.gz -s "pasite.org db backup" -c huacnlee@gmail.com
echo "huacnlee.com db backup" | mutt -a $BACKUP_PATH/personlab_db_$DATE_NAME.tar.gz -s "huacnlee.com db backup" -c huacnlee@gmail.com
echo "lanxs.com db backup" | mutt -a $BACKUP_PATH/lanxs_db_$DATE_NAME.tar.gz -s "lanxs.com db backup" -c huacnlee@gmail.com

# clear tmp file
rm -R $BACKUP_PATH

