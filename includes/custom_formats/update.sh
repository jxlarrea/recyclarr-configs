#!/bin/bash

# Removing old file
echo "Deleting old file..."
rm -f radarr_new_cf.yml
rm -f sonarr_new_cf.yml
echo "Done."

# Download latest custom formats from Trash Guides
echo "Downloading latest Custom Formats..."
recyclarr list custom-formats radarr --raw >> radarr_new_cf.yml
recyclarr list custom-formats sonarr --raw >> sonarr_new_cf.yml
echo "Done."

# Fix formatting
echo "Fixing formatting..."
sed -e '/^Muxers)/ s/^#*/#/' -i radarr_new_cf.yml
sed -e '/^Muxers)/ s/^#*/#/' -i sonarr_new_cf.yml

sed '1i custom_formats:\n    - trash_ids:\n' -i radarr_new_cf.yml
sed '1i custom_formats:\n    - trash_ids:\n' -i sonarr_new_cf.yml
echo "Done."

# Read unneeded custom formats from an external file, ignoring comments and trimming whitespace
declare -a arrRadarr=()
while IFS= read -r line; do
    # Skip full-line comments and empty lines
    [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue
    # Remove inline comments and trim whitespace
    cleaned_line=$(echo "$line" | sed -e 's/#.*//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    # Skip the line if it becomes empty after cleaning
    [[ -z "$cleaned_line" ]] && continue
    arrRadarr+=("$cleaned_line")
done < "./radarr_exclusions.txt"

# Read unneeded Sonarr custom formats from an external file, ignoring comments and trimming whitespace
declare -a arrSonarr=()
while IFS= read -r line; do
    # Skip full-line comments and empty lines
    [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue
    # Remove inline comments and trim whitespace
    cleaned_line=$(echo "$line" | sed -e 's/#.*//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    # Skip the line if it becomes empty after cleaning
    [[ -z "$cleaned_line" ]] && continue
    arrSonarr+=("$cleaned_line")
done < "./sonarr_exclusions.txt"

# Comment out unneeded custom formats
echo "Commenting out custom formats..."
for i in "${arrRadarr[@]}"; do
    # Escape special characters in the format ID
    escaped_id=$(echo "$i" | sed 's/[\/&]/\\&/g')
    # Comment out the line matching the format ID
    sed -e "/$escaped_id/ s/^#*/#/" -i radarr_new_cf.yml
done

for i in "${arrSonarr[@]}"; do
    # Escape special characters in the format ID
    escaped_id=$(echo "$i" | sed 's/[\/&]/\\&/g')
    # Comment out the line matching the format ID  
    sed -e "/$escaped_id/ s/^#*/#/" -i sonarr_new_cf.yml
done

sed "1s/^/# $(date '+%Y-%m-%d %H:%M:%S')\n\n/" -i radarr_new_cf.yml
sed "1s/^/# $(date '+%Y-%m-%d %H:%M:%S')\n\n/" -i sonarr_all_cf.yml

mv radarr_new_cf.yml radarr_all_cf.yml
mv sonarr_new_cf.yml sonarr_all_cf.yml

echo "Done."
