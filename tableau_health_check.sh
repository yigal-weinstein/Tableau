#!/bin/bash

tableau_node_ip=$(aws ec2 describe-instances \
	--filter "Name=tag:Name,Values=node1.green.tableau.dm.ring.com" \
	--query 'Reservations[].Instances[].PrivateIpAddress' --output text)
script_path=/home/ec2-user/tableau_health_check
tableau_health_json=${script_path}/systeminfo.json

export PATH=$PATH:~/.local/bin/xq
# Get Tableau's current health status to be used to add custom CloudWatch metrics
curl http://${tableau_node_ip}/admin/systeminfo.xml -k |  xq '.' > ${tableau_health_json}

# Obtain 

#status - The status of the process on the node. There are a total of 11 states:

# Active (0)
# Passive (1)
# Unlicensed (2)
# Busy (3)
# Down (4)
# ReadOnly (5)
# ActiveSyncing (6)
# StatusNotAvailable (7)
# StatusNotAvailableSyncing (8)
# NotAvailable (9)
# DecommisionedReadOnly (10)
# DecommissionFailedReadOnly (11)
# info taken from https://help.tableau.com/current/server/en-us/service_status_xml.htm

# Any service not in an Active state over a long enough period should cause an alert. 

# To use CloudWatch Metrics the current limitations appear to mean converting
# the original JSON's state fields with the numeric map above
