#!/bin/bash 

# Get the GitHub Token and Giphy API key from GitHub Actions inputs 
GITHUB_TOKEN=$1
GIPHY_API_KEY=$2

# Get the pull request number from the GitHub event payload

pull_request_number=$(jq --raw-output .pull_request.number "$GITHUB_EVENT_PATH")
echo "Pull request number: $pull_request_number"

# Use the Giphy API to fetch a random Thanks You GIF

giphy_response=$(curl -s "https://api.giphy.com/v1/gifs/random?api_key=$GIPHY_API_KEY&tag=thank%20you&rating=g")
echo "Giphy response: $giphy_response"

# Extract the GIF URL from the Giphy API response
gif_url=$(echo "$giphy_response" | jq --raw-output '.data.images.original.url')
echo "GIF URL: $gif_url"

# Create a comment on the pull request with the GIF URL
comment_body=$(curl -sX POST \
    -H "Authorization: token $GITHUB_TOKEN" \
    -H "Accept: application/vnd.github.v3+json" \
    -d "{\"body\"}": \"### PR - #$pull_request_number. \n ## Thanks you for contribution \n ![GIF]($gif_url) \" \
    "https://api.github.com/repos/$GITHUB_REPOSITORY/issues/$pull_request_numeber/comments")

# Extract and print the comment URL from the comment reponse 
comment_url=$(echo "$comment_body" | jq --raw-output .html_url )