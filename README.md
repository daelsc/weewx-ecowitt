# WeeWX Ecowitt Docker

Docker container for [WeeWX](https://weewx.com/) with the Ecowitt/GW1000 driver pre-installed. Perfect for running on Unraid or any Docker host.

## Supported Devices

- Ecowitt GW1000
- Ecowitt GW1100
- Ecowitt GW2000
- Ecowitt WH2650
- Ecowitt WH2680
- Ecowitt WN1900
- WS90 Wittboy sensor

## Quick Start

```bash
docker run -d \
  --name weewx \
  --restart unless-stopped \
  -v /path/to/data:/data \
  -e TZ=America/Los_Angeles \
  ghcr.io/daelsc/weewx-ecowitt:latest
```

## Configuration

1. Create a data directory for persistent storage
2. Copy `weewx.conf.example` to your data directory as `weewx.conf`
3. Edit `weewx.conf` with your settings:
   - Set your location (latitude, longitude, altitude)
   - Set your Ecowitt gateway IP address
   - Configure upload services (PWSweather, Wunderground, etc.)

### Example Configuration

```ini
[Station]
    location = "My Weather Station"
    latitude = 37.7749
    longitude = -122.4194
    altitude = 100, foot
    station_type = GW1000

[GW1000]
    driver = user.gw1000
    ip_address = 192.168.1.100
    port = 45000
    poll_interval = 5

[StdRESTful]
    [[PWSweather]]
        enable = true
        station = YOUR_STATION_ID
        password = YOUR_API_KEY
```

## Docker Compose

```yaml
version: '3'
services:
  weewx:
    image: ghcr.io/daelsc/weewx-ecowitt:latest
    container_name: weewx
    restart: unless-stopped
    volumes:
      - ./weewx-data:/data
    environment:
      - TZ=America/Los_Angeles
```

## Unraid

An Unraid template is available in the [unraid-templates](https://github.com/daelsc/unraid-templates) repository.

## Data Persistence

The `/data` volume contains:
- `weewx.conf` - Configuration file
- `archive/weewx.sdb` - SQLite database with historical data
- `bin/user/` - Custom drivers and extensions

## Credits

- [WeeWX](https://weewx.com/) - Weather station software
- [felddy/weewx](https://github.com/felddy/weewx-docker) - Base Docker image
- [CameronD73/weewx-utilities](https://github.com/CameronD73/weewx-utilities) - Python 3 GW1000 driver

## License

MIT
