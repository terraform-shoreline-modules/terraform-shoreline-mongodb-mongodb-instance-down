
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# MongoDB instance down
---

This incident type refers to an issue where the MongoDB instance is down. This can cause disruption to any applications or services that rely on the database. It requires immediate attention from the appropriate personnel to diagnose and resolve the issue to minimize the impact on the affected systems.

### Parameters
```shell
# Environment Variables

export HOSTNAME="PLACEHOLDER"

export PORT="PLACEHOLDER"

export DATABASE="PLACEHOLDER"

export COLLECTION="PLACEHOLDER"

export INSTANCE_NAME="PLACEHOLDER"

export MONGODB_DATA_DIRECTORY="PLACEHOLDER"
```

## Debug

### Check if MongoDB is running
```shell
systemctl status mongodb
```

### Check MongoDB logs for errors
```shell
journalctl -u mongodb | grep ERROR
```

### Check MongoDB connectivity
```shell
mongo ${HOSTNAME}:${PORT}
```

### Check MongoDB database status
```shell
mongo ${HOSTNAME}:${PORT}/${DATABASE} --eval "db.stats()"
```

### Check MongoDB collection status
```shell
mongo ${HOSTNAME}:${PORT}/${DATABASE} --eval "db.${COLLECTION}.stats()"
```

### Check MongoDB process usage
```shell
top -p $(pgrep -d',' mongod)
```

### Check MongoDB disk usage
```shell
df -h ${MONGODB_DATA_DIRECTORY}
```

## Repair

### Define the affected MongoDB instance
```shell
INSTANCE=${INSTANCE_NAME}
```

### Restart the MongoDB service
```shell
sudo systemctl restart mongodb.service
```

### Check the status of the MongoDB service
```shell
STATUS=$(sudo systemctl status mongodb.service | grep "Active:" | awk '{print $2}')
```

### Check if the service has started successfully
```shell
if [ "$STATUS" == "active" ]; then

    echo "MongoDB service has been restarted successfully."

else

    echo "Failed to restart MongoDB service."

fi
```