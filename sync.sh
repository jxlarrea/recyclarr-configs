#!/bin/bash

SCRIPT_DIR=$(dirname "$(realpath "$0")")
CF_DIR="$SCRIPT_DIR/includes/custom_formats"
LOCATION="$(which recyclarr)"

echo "Checking if Recyclarr is installed..."
# Check if the Recyclarr was found
if [ -z "$LOCATION" ]; then
    echo "Error: Recyclarr is not installed or not in the PATH."
    exit 1
else
    echo "Recyclarr found at: $LOCATION"
fi


# Removing old files
echo "Deleting old file..."
rm -f "$CF_DIR/radarr_new_cf.yml"
rm -f "$CF_DIR/sonarr_new_cf.yml"
echo "Done."

# Download latest custom formats from Trash Guides
echo "Downloading latest Custom Formats..."

CMD="$LOCATION list custom-formats radarr --raw >> $CF_DIR/radarr_new_cf.yml"
eval "$CMD"

# Check the exit status
if [ $? -ne 0 ]; then
    echo "Error: Recyclarr returned an error while attempting to sync CFs for Radarr."
    exit 1
fi

CMD="$LOCATION list custom-formats sonarr --raw >> $CF_DIR/sonarr_new_cf.yml"
eval "$CMD"

# Check the exit status
if [ $? -ne 0 ]; then
    echo "Error: Recyclarr returned an error while attempting to sync CFs for Sonarr."
    exit 1
fi


echo "Done."

# Fix formatting
echo "Fixing formatting..."
sed -e '/^Muxers)/ s/^#*/#/' -i "$CF_DIR/radarr_new_cf.yml"
sed -e '/^Muxers)/ s/^#*/#/' -i "$CF_DIR/sonarr_new_cf.yml"

sed '1i custom_formats:\n    - trash_ids:\n' -i "$CF_DIR/radarr_new_cf.yml"
sed '1i custom_formats:\n    - trash_ids:\n' -i "$CF_DIR/sonarr_new_cf.yml"
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
done < "$CF_DIR/radarr_exclusions.txt"

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
done < "$CF_DIR/sonarr_exclusions.txt"

# Comment out unneeded custom formats
echo "Commenting out custom formats..."
for i in "${arrRadarr[@]}"; do
    # Escape special characters in the format ID
    escaped_id=$(echo "$i" | sed 's/[\/&]/\\&/g')
    # Comment out the line matching the format ID
    sed -e "/$escaped_id/ s/^#*/#/" -i "$CF_DIR/radarr_new_cf.yml"
done

for i in "${arrSonarr[@]}"; do
    # Escape special characters in the format ID
    escaped_id=$(echo "$i" | sed 's/[\/&]/\\&/g')
    # Comment out the line matching the format ID  
    sed -e "/$escaped_id/ s/^#*/#/" -i "$CF_DIR/sonarr_new_cf.yml"
done

mv "$CF_DIR/radarr_new_cf.yml" "$CF_DIR/radarr_all_cf.yml"
mv "$CF_DIR/sonarr_new_cf.yml" "$CF_DIR/sonarr_all_cf.yml"

echo "Done."

echo "Running 'recyclarr sync'..."

CMD="$LOCATION sync"
eval "$CMD"
