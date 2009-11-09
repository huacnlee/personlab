#!/bin/sh
# auto backup wwwroot data and mysql db
BACKUP_PATH=/tmp/autobackups
DATE_NAME=`date +%y%m%d`
mkdir $BACKUP_PATH
# package
mysqldump -umonster -p123123 --databases pasite > $BACKUP_PATH/pasite.sql
mysqldump -umonster -p123123 --databases personlab_production > $BACKUP_PATH/personlab.sql
tar zcf $BACKUP_PATH/pasite_db_$DATE_NAME.tar.gz $BACKUP_PATH/pasite.sql
tar zcf $BACKUP_PATH/personlab_db_$DATE_NAME.tar.gz $BACKUP_PATH/personlab.sql
tar zcf $BACKUP_PATH/pasite_src_$DATE_NAME.tar.gz /opt/huacnlee/wwwroot/pasite/
tar zcf $BACKUP_PATH/personlab_src_$DATE_NAME.tar.gz /opt/huacnlee/wwwroot/personlab/

# sendmail
echo "pasite.org db backup" | mutt -a $BACKUP_PATH/pasite_db_$DATE_NAME.tar.gz -s "pasite.org db backup" huacnlee@gmail.com
echo "pasite.org source backup" | mutt -a $BACKUP_PATH/pasite_src_$DATE_NAME.tar.gz -s "pasite.org source backup" huacnlee@gmail.com
echo "huacnlee.com db backup" | mutt -a $BACKUP_PATH/personlab_db_$DATE_NAME.tar.gz -s "huacnlee.com db backup" huacnlee@gmail.com
echo "huacnlee.com source backup" | mutt -a $BACKUP_PATH/personlab_src_$DATE_NAME.tar.gz -s "huacnlee.com source backup" huacnlee@gmail.com

# remove website runtime log
sudo rm /opt/huacnlee/wwwroot/pasite/log/*
sudo rm /opt/huacnlee/wwwroot/personlab/log/*

# clear tmp file
rm -R $BACKUP_PATH

