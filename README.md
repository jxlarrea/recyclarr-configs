# Recyclarr Configs

A set of [Recyclarr](https://github.com/recyclarr/recyclarr) configuration files for maximum quality 4K/HDR and 1080p downloads via Radarr and Sonarr. Based on the [domalab/recyclarr-config](https://github.com/domalab/recyclarr-config) repository and heavily modified to fit my needs.

This configuration creates Custom Formats and Quality Profiles (on both Sonarr and Radarr) which aims to always grab the highest quality releases with separate profiles for 4K/HDR/DV, 4K/SDR and 1080p. Uncompressed audio formats (TrueHD and DTS-MA) are also preferred. 

It also imports every single Custom Format from [TRaSH Guides](https://trash-guides.info/)  (with a few of exceptions) even if some of those aren't assigned to any profiles. 

## How to Use
- Edit `recyclarr.yml` and insert your Radarr/Sonarr instance URL and api key.
- Run the `sync.sh` script to both pull all available Custom Formats from TRaSH GUides, and sync Recyclarr with your Sonarr and Radarr instances.
