#!/bin/bash
set -e

# Ensure user directory exists
mkdir -p /data/bin/user

# Install GW1000 driver if not present
if [ ! -f /data/bin/user/gw1000.py ]; then
    echo "Installing GW1000/Ecowitt driver..."
    cp /opt/weewx-extras/gw1000.py /data/bin/user/gw1000.py
    echo "Driver installed."
fi

# Ensure __init__.py exists for Python imports
touch /data/bin/user/__init__.py

# Ensure extensions.py exists
if [ ! -f /data/bin/user/extensions.py ]; then
    echo "# User extensions" > /data/bin/user/extensions.py
fi

# Call the original entrypoint
exec /home/weewx/entrypoint.sh "$@"
