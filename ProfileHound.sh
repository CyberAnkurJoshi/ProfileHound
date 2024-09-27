#!/bin/bash

# Tool information
TOOL_NAME="Profile Hound"
LINKEDIN_URL="https://www.linkedin.com/in/theankurjoshi"  # Replace with your LinkedIn URL

# Define colors
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Print tool information in large text
echo -e "${GREEN}=== $(figlet -f slant "$TOOL_NAME") ===${NC}"
echo -e "${YELLOW}Created by: $LINKEDIN_URL${NC}"
echo

# Usage: ./find_social_media.sh <company_name_or_domain>
# Example: ./find_social_media.sh "Example Company" or "example.com"

if [ -z "$1" ]; then
    echo "Usage: $0 <company_name_or_domain>"
    exit 1
fi

query="$1"

# List of common social media platforms
platforms=("facebook.com" "twitter.com" "instagram.com" "linkedin.com" "youtube.com" "tiktok.com")

# Array to hold found URLs
found_urls=()

# Function to search for social media accounts
search_social_media() {
    local platform=$1
    echo "Searching for $platform..."

    # Use DuckDuckGo search to find the company's social media account
    results=$(curl -s "https://duckduckgo.com/?q=${query}+site:${platform}" | grep -oP 'https?://[^&]+' | head -n 1)

    if [ -n "$results" ]; then
        echo "$platform: $results"
        found_urls+=("$results")  # Add the found URL to the array
    else
        echo "$platform: Not found"
    fi
}

# Main script execution
echo "Searching for social media accounts for: $query"
for platform in "${platforms[@]}"; do
    search_social_media "$platform"
done

echo "Search completed."

# Open found URLs in Firefox
if [ ${#found_urls[@]} -gt 0 ]; then
    echo "Opening found URLs in Firefox..."
    for url in "${found_urls[@]}"; do
        firefox --new-tab "$url" &
    done
else
    echo "No URLs found to open."
fi
