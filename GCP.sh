#!/bin/sh

# Set your google email
EMAIL=nirgeier@gmail.com

# # Check if Google Cloud SDK is already authenticated
# if gcloud auth list --format "value(account)" | grep -q "${EMAIL}"; then
#   echo "Already authenticated with Google Cloud SDK."
# else
#   # Authenticate to Google Cloud SDK
#   gcloud auth login ${EMAIL} 
#   echo "Successfully authenticated with Google Cloud SDK."
# fi

# # Spin the cloud machine and store the IP in variable
# cloud_connection_input=$(gcloud alpha cloud-shell ssh --dry-run)

# # Extract the IP from the connection string
# ip_address=$(echo "$cloud_connection_input" | grep -Eo "([0-9]{1,3}\.){3}[0-9]{1,3}")

# echo "Setting new Ip address: ${ip_address}"

# Define the SSH config file path
ssh_config_file="$HOME/.ssh/config"

# Set variables
entry="GoogleConsole"
ip="12.12.12.12"

# Update hostname IP
#sed -i "/^Host $entry/,/^$/ s/^ *HostName .*/    HostName $ip/" /Users/nirg/.ssh/config
# sed -i '/^Host $entry/, /{n;s/^ *HostName.*/    HostName      1.1.1.1/;}' ssh_config_file
#sed -i 's/^\( *Host GoogleConsole\)\(.*\)\(HostName *\)\([^ ]*\)/\1\2\31.1.1.1/' /Users/nirg/.ssh/config


# Exit the script
exit 0