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

DIR=$(dirname "$0")
[ $# -ne 2 ] && { echo "$HOW_TO_CALL"; exit 1; }

echo "$DIR"


