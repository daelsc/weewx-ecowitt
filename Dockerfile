FROM felddy/weewx:latest

# Switch to root for installation
USER root

# Download the Python3-only GW1000/Ecowitt driver (no 'six' dependency)
# Source: https://github.com/CameronD73/weewx-utilities
ADD https://raw.githubusercontent.com/CameronD73/weewx-utilities/main/drivers/gw1000/gw1000.py /opt/weewx-extras/gw1000.py

# Custom entrypoint to install driver on first run
COPY entrypoint-wrapper.sh /entrypoint-wrapper.sh
RUN chmod +x /entrypoint-wrapper.sh

ENTRYPOINT ["/entrypoint-wrapper.sh"]
