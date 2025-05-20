#!/bin/bash

STEAM_LIBRARY_PATH="/<Path to your steam library>/SteamLibrary/steamapps"  # Path to steam lib
DESKTOP_FILE_DIR="$HOME/.local/share/applications"
STEAM_ICON_PATH="/usr/share/icons/hicolor/256x256/apps/steam.png"  # Default steam icon 
ICON_DOWNLOAD_DIR="$HOME/.local/share/icons/steam_game_icons"  # Icons save location 

# Create icons save location
mkdir -p "$ICON_DOWNLOAD_DIR"

# Filter Proton and Steam Linux Runtime
should_exclude() {
    local game_name="$1"
    if [[ "$game_name" =~ ^Proton ]] || [[ "$game_name" =~ ^"Steam Linux Runtime" ]]; then
        return 0
    fi
    return 1  
}

# Remove Proton shortcuts 
clean_proton_shortcuts() {
    echo "Deleting Protons shortcut..."
    for desktop_file in "$DESKTOP_FILE_DIR"/*.desktop; do
        if grep -q "Proton" "$desktop_file" || grep -q "Steam Linux Runtime" "$desktop_file"; then
            echo "Deleted: $(basename "$desktop_file")"
            rm "$desktop_file"
        fi
    done
}

clean_proton_shortcuts

# Download game icon from steam 
download_steam_icon() {
    local appid="$1"
    local icon_path="$ICON_DOWNLOAD_DIR/$appid.png"

    # Use AppID to find the icon, if it doesn't already exists
    if [[ ! -f "$icon_path" ]]; then
        local icon_url="https://cdn.cloudflare.steamstatic.com/steam/apps/$appid/header.jpg"
        echo "Download icon for: $appid"
        curl -s -o "$icon_path" "$icon_url"

        # Check if the download is a success
        if [[ ! -s "$icon_path" ]]; then
            echo "Failed to download: $appid, used default icon instead."
            rm "$icon_path" 
            icon_path="$STEAM_ICON_PATH"
        fi
    fi

    # Return the icon path
    echo "$icon_path"
}

# Browse through .acf file in order to finde every installed  games 
for manifest in "$STEAM_LIBRARY_PATH"/appmanifest_*.acf; do
    APPID=$(grep -oP '"appid"\s+"\K[0-9]+' "$manifest")
    GAME_NAME=$(grep -oP '"name"\s+"\K[^"]+' "$manifest")

    # Filter proton versions 
    if should_exclude "$GAME_NAME"; then
        echo "Exclu: $GAME_NAME (Proton ou Runtime)"
        continue
    fi

    ICON_PATH=$(download_steam_icon "$APPID")

    # Create .desktop file
    DESKTOP_FILE="$DESKTOP_FILE_DIR/$GAME_NAME.desktop"
    cat <<EOF > "$DESKTOP_FILE"
[Desktop Entry]
Name=$GAME_NAME
Comment=Play $GAME_NAME via Steam
Exec=steam steam://rungameid/$APPID
Icon=$ICON_PATH
Terminal=false
Type=Application
Categories=Game;
EOF

    echo "Shortcut created $GAME_NAME with icon $ICON_PATH."
done

# Update application database
update-desktop-database "$DESKTOP_FILE_DIR"

echo "Database updated"
