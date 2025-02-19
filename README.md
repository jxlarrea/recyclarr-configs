# Recyclarr Configurations
A comprehensive set of [Recyclarr](https://github.com/recyclarr/recyclarr) files designed for maximum quality 4K/HDR and 1080p downloads via Radarr and Sonarr. This setup creates Custom Formats and Quality Profiles in both Sonarr and Radarr, ensuring the highest quality releases are always prioritized. Separate profiles are available for:

- 4K/HDR/DV
- 4K/SDR
- 1080p
  
Uncompressed audio formats, such as TrueHD and DTS-MA, are also given preference to ensure premium sound quality.

Additionally, the configuration imports all Custom Formats from [TRaSH Guides](https://trash-guides.info/) (with a few exceptions), even if some are not directly assigned to any profiles.

There are also two "Optimized" profiles for 4K and 1080p downloads, designed to offer a perfect balance between quality and file size.

## How to Use

**Edit the Configuration File**

Open `recyclarr.yml` and add the URL and API key for your Radarr and Sonarr instances.

**Run the Sync Script**

Run the `sync.sh` script to:

1. Pull all available Custom Formats from TRaSH Guides.
2. Sync Recyclarr with your Sonarr and Radarr setups.

Make sure that the script is executable by running:

```
chmod +x sync.sh
```

## Ensuring Regular Updates

To maintain the most current version of all Custom Formats, it is recommended to run the `sync.sh` script daily. This can be automated by configuring a cron job using the `crontab -e` command. Make sure that your crontab file includes the `PATH` environment variable. The example below will run `sync.sh` at 8:00 AM every day.

```
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

0 8 * * *  /your/path/to/sync.sh
```
