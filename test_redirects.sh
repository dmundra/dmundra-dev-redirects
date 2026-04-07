#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo "Starting Comprehensive Redirect Tests (HTTP & HTTPS)..."
echo "---------------------------------------------------------"

# Array of tests in the format "Source_URL|Expected_Destination_URL"
tests=(
    # 1. Main domain www to non-www
    "http://www.dmundra.dev/|https://dmundra.dev/"
    "https://www.dmundra.dev/|https://dmundra.dev/"
    "http://www.dmundra.dev/about|https://dmundra.dev/about"
    "https://www.dmundra.dev/about|https://dmundra.dev/about"

    # 2 & 3. danielmundra.dev special paths
    "http://danielmundra.dev/wkly|https://dmundra.dev/?path=wkly"
    "https://danielmundra.dev/wkly|https://dmundra.dev/?path=wkly"
    "http://www.danielmundra.dev/movies|https://dmundra.dev/?path=movies"
    "https://www.danielmundra.dev/movies|https://dmundra.dev/?path=movies"

    # 4. danielmundra.dev catch-all
    "http://danielmundra.dev/|https://dmundra.dev/"
    "https://danielmundra.dev/|https://dmundra.dev/"
    "http://www.danielmundra.dev/portfolio|https://dmundra.dev/portfolio"
    "https://www.danielmundra.dev/portfolio|https://dmundra.dev/portfolio"

    # 5. eugtbp.org Metro redirect (All 4 variations)
    "http://eugtbp.org/movies|https://www.eugenetoolboxproject.org/?utm_source=ad&utm_medium=image&utm_campaign=broadwaymetro"
    "https://eugtbp.org/movies|https://www.eugenetoolboxproject.org/?utm_source=ad&utm_medium=image&utm_campaign=broadwaymetro"
    "http://www.eugtbp.org/movies|https://www.eugenetoolboxproject.org/?utm_source=ad&utm_medium=image&utm_campaign=broadwaymetro"
    "https://www.eugtbp.org/movies|https://www.eugenetoolboxproject.org/?utm_source=ad&utm_medium=image&utm_campaign=broadwaymetro"

    # 6. eugtbp.org Weekly redirect (All 4 variations)
    "http://eugtbp.org/wkly|https://www.eugenetoolboxproject.org/?utm_source=ad&utm_medium=newspaper&utm_campaign=eugeneweekly"
    "https://eugtbp.org/wkly|https://www.eugenetoolboxproject.org/?utm_source=ad&utm_medium=newspaper&utm_campaign=eugeneweekly"
    "http://www.eugtbp.org/wkly|https://www.eugenetoolboxproject.org/?utm_source=ad&utm_medium=newspaper&utm_campaign=eugeneweekly"
    "https://www.eugtbp.org/wkly|https://www.eugenetoolboxproject.org/?utm_source=ad&utm_medium=newspaper&utm_campaign=eugeneweekly"

    # 7. eugtbp.org catch-all
    "http://eugtbp.org/|https://www.eugenetoolboxproject.org/"
    "https://eugtbp.org/|https://www.eugenetoolboxproject.org/"
    "http://www.eugtbp.org/donate|https://www.eugenetoolboxproject.org/donate.html"
    "https://www.eugtbp.org/donate|https://www.eugenetoolboxproject.org/donate.html"
)

# Loop through each test case
for test in "${tests[@]}"; do
    # Split the string by the pipe character
    SOURCE=$(echo "$test" | cut -d'|' -f1)
    EXPECTED=$(echo "$test" | cut -d'|' -f2)

    # Use curl to get the FINAL effective URL 
    # -L: Follow redirects
    # -s: Silent mode
    # -o /dev/null: Hide the HTML body
    # -w "%{url_effective}": Extract only the final URL after all hops
    ACTUAL=$(curl -sL -o /dev/null -w "%{url_effective}" "$SOURCE")

    # Check if the actual final URL matches the expected one
    if [ "$ACTUAL" == "$EXPECTED" ]; then
        echo -e "${GREEN}[PASS]${NC} $SOURCE"
    else
        echo -e "${RED}[FAIL]${NC} $SOURCE"
        echo -e "       Expected: $EXPECTED"
        echo -e "       Actual:   $ACTUAL"
    fi
done

echo "---------------------------------------------------------"
echo "Testing Complete!"
