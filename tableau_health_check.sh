#!/bin/bash

script_path=/home/ec2-user/tableau_health_check
tableau_health_json=${script_path}/systeminfo.json

# Get Tableau's current health status to be used to add custom CloudWatch metrics
curl -u ${user}:${pass} http://${tableau_node_ip}/admin/systeminfo.xml -k |  xq '.' > ${tableau_health_json}

# Obtain 

# There are 4 values that will return for each returned health value:
# (0) RUNNING: The node is running without error statuses for any service.
# (1) DEGRADED: A primary service - such as the repository - is in an error state.
# (2) ERROR: One or more services is in an error state.
# (3) STOPPED: The node is stopped.
# source https://help.tableau.com/current/server-linux/en-us/cli_status_tsm.htm


