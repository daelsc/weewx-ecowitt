FROM felddy/weewx:latest

# Download the Python3-only GW1000/Ecowitt driver (no 'six' dependency)
# Source: https://github.com/CameronD73/weewx-utilities
ADD https://raw.githubusercontent.com/CameronD73/weewx-utilities/main/drivers/gw1000/gw1000.py /tmp/gw1000.py

# The driver will be copied to /data/bin/user/ on first run if not present
# We store it in /opt for the entrypoint to use
RUN mkdir -p /opt/weewx-extras && \
    mv /tmp/gw1000.py /opt/weewx-extras/gw1000.py

# Custom entrypoint to install driver on first run
COPY entrypoint-wrapper.sh /entrypoint-wrapper.sh
RUN chmod +x /entrypoint-wrapper.sh

ENTRYPOINT ["/entrypoint-wrapper.sh"]
