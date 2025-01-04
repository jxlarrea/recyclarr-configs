# Recyclarr Configurations
A comprehensive set of [Recyclarr](https://github.com/recyclarr/recyclarr) files designed for maximum quality 4K/HDR and 1080p downloads via Radarr and Sonarr. This setup creates Custom Formats and Quality Profiles in both Sonarr and Radarr, ensuring the highest quality releases are always prioritized. Separate profiles are available for:

- 4K/HDR/DV
- 4K/SDR
- 1080p
  
Uncompressed audio formats, such as TrueHD and DTS-MA, are also given preference to ensure premium sound quality.

Additionally, the configuration imports all Custom Formats from [TRaSH Guides](https://trash-guides.info/) (with a few exceptions), even if some are not directly assigned to any profiles.

## How to Use

**Edit the Configuration File**

Open `recyclarr.yml` and add the URL and API key for your Radarr and Sonarr instances.

**Run the Sync Script**

Execute the `sync.sh` script to:

1. Pull all available Custom Formats from TRaSH Guides.
2. Sync Recyclarr with your Sonarr and Radarr setups.

Ensure the script is executable by running:

```
chmod +x sync.sh
```
