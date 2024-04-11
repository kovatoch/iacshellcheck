#!/bin/bash
#
# NAME: stop.sh
#
# SYNOPSIS: stop.sh
#
# DESCRIPTION: Stop a given application (Camel integration) on JBoss or SpringBoot
#
# MANDATORY PARAMETERS:
# 1. Host name
# 2. Integration name
#

HOW_TO_CALL="$0 HostName IntegrationName"

DIR=`dirname $0`
[ $# -ne 2 ] && { echo $HOW_TO_CALL; exit 1; }

HOST_NAME=$1
INTEGRATION_NAME=$2
SEPARATOR="###############################################################"
ADMIN_PORT=9999
#JBOSS_HOME=D:/jboss/EAP-6.3.0/jboss-eap-6.3
JBOSS_CLIENT=${JBOSS_HOME}/bin/jboss-cli.sh
ONELINE_FILE=${DIR}/oneline.txt
SERVER_DIR=$DIR/server
ACT_DATE=`date`
OUT_LOG=/$DEPLOY/start_stop_integration.log
date > ${ONELINE_FILE}

JAR_FILE=`ls $SERVER_DIR/${INTEGRATION_NAME}/${INTEGRATION_NAME}-*.jar 2> /dev/null | head -1`

echo $SEPARATOR
echo "Stop the application $INTEGRATION_NAME on $HOST_NAME ..."
echo "$ACT_DATE Stop the application $INTEGRATION_NAME on $HOST_NAME ..."  >> $OUT_LOG
if [ "$JAR_FILE" = "" ]; then

  # Stop the application on JBoss
  CURRENT_INTEGRATION=`${JBOSS_CLIENT} --controller=${HOST_NAME}:${ADMIN_PORT} --connect --command="ls deployment" < ${ONELINE_FILE} | grep ${INTEGRATION_NAME}`

  # Stop integration
  [ "${CURRENT_INTEGRATION}" != "" ] && { ${JBOSS_CLIENT} --controller=${HOST_NAME}:${ADMIN_PORT} --connect --command="undeploy ${CURRENT_INTEGRATION} --keep-content" < ${ONELINE_FILE}; echo ${CURRENT_INTEGRATION} stopped; } || { echo ${INTEGRATION_NAME} not deployed and cannot be stopped; exit 1; }
else
  # Stop the application with SpringBoot
  $DIR/stopspringboot.sh $INTEGRATION_NAME
  exit $?
fi