Based on the [domalab/recyclarr-config](https://github.com/domalab/recyclarr-config) repository and heavily modified to fit my needs.

The focus of this configuration is to always grab the highest quality releases with separate profiles for 4K/HDR/DV, 4K/SDR and 1080p. Uncompressed audio formats (TrueHD and DTS-MA) are also preferred. 

It also imports every single Custom Format from [TRaSH Guides](https://trash-guides.info/) (with a few of exceptions) even if some of those aren't assigned to any profiles. 

The files in this repository should be placed in the recyclarr config/includes folder. Your `recyclarr.yml` file should look like this:

```yaml
sonarr:
  sonarr:
    base_url: http://xxx.xxx.xxx.xxx:8989
    api_key: [SONARR API KEY]
    include:
    - template: sonarr-quality-definition-series
    - template: sonarr-quality-definition-anime
    - config: sonarr-all-cf.yml # Imports every single CF from Trash Guides
    - config: sonarr.yml

radarr:
  radarr:
    base_url: http://xxx.xxx.xxx.xxx:7878
    api_key: [RADARR API KEY]
    include:
    - template: radarr-quality-definition-movie
    - config: radarr-all-cf.yml # Imports every single CF from Trash Guides
    - config: radarr.yml
```
