#!/bin/bash


SMTP_SERVER="10.10.67.55"
MAIL_FROM="dwssap@dajie-inc.com"
MAIL_TO="dj-net@dajie-inc.com"
NEW_PASSWD=`mkpasswd -l 16 -C 5 -d 4 -s 0`;
#echo ${NEW_PASSWD}
PING_CHECK=`ping -w 2 -c 3 ${SMTP_SERVER} | grep time=`;
#echo ${PING_CHECK};
if [[ -z "${PING_CHECK}" ]]
then
        echo "Can not reach SMTP server!!!"
echo "

###################################################################

        !!!Please change the password of root manually!!!
                And Reboot the system

###################################################################

";

passwd root;

else
        /usr/bin/python /root/sendmail.py --host=${SMTP_SERVER} --from=${MAIL_FROM} --to=${MAIL_TO} -c "passwd is ${NEW_PASSWD}" -s "dwssap"
        echo "New password has been send to ${MAIL_TO} , please check your email";
#       echo ${NEW_PASSWD} | passwd --stdin root
        echo "root:${NEW_PASSWD}" | chpasswd;
fi
