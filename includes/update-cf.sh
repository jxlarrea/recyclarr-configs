#!/bin/bash

# Removing old file
echo "Deleting old file..."
rm -f radarr-new-cf.yml
rm -f sonarr-new-cf.yml
echo "Done."

# Download latest custom formats from Trash Guides
echo "Downloading latest Custom Formats..."
recyclarr list custom-formats radarr --raw >> radarr-new-cf.yml
recyclarr list custom-formats sonarr --raw >> sonarr-new-cf.yml
echo "Done."

# Fix formatting
echo "Fixing formatting..."
sed -e '/^Muxers)/ s/^#*/#/' -i radarr-new-cf.yml
sed -e '/^Muxers)/ s/^#*/#/' -i sonarr-new-cf.yml

sed '1i custom_formats:\n    - trash_ids:\n' -i radarr-new-cf.yml
sed '1i custom_formats:\n    - trash_ids:\n' -i sonarr-new-cf.yml
echo "Done."

# Read unneeded Radarr custom formats from an external file, ignoring comments and trimming whitespace
declare -a arrRadarr=()
while IFS= read -r line; do
    # Skip full-line comments and empty lines
    [[ "$line" =~ ^#.*$ || -z "$line" ]] && continue
    # Remove inline comments and trim whitespace
    cleaned_line=$(echo "$line" | sed -e 's/#.*//' -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
    # Skip the line if it becomes empty after cleaning
    [[ -z "$cleaned_line" ]] && continue
    arrRadarr+=("$cleaned_line")
done < "radarr-all-cf-exclusions.txt"

# Comment out unneeded custom formats
echo "Commenting out uneeded Radarr custom formats..."
for i in "${arrRadarr[@]}"; do
    # Escape special characters in the format ID
    escaped_id=$(echo "$i" | sed 's/[\/&]/\\&/g')
    # Comment out the line matching the format ID
    sed -i -e "/$escaped_id/ s/^#*/#/" radarr-new-cf.yml
done
echo "Done."
