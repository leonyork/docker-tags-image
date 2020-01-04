#!/usr/bin/env sh
#######################################################################
# Get the tags for a repo from Dockerhub
# First argument is the repository and image name (e.g. library/alpine)
#######################################################################

if [ -z "$1" ]
then
    echo "You must specify a the repository and image name (e.g. library/alpine or curlimages/curl)"
    exit 1
fi

# File to write the tags to
output=tags.txt

# Takes the response from the API, gets the name of the tag from the results
getTags() {
    echo $1 | jq -r '.results | .[] | .name'
}

# Takes the response from the API, gets the next page (there may not be one)
getNext() {
    echo $1 | jq -r '.next'
}

# Make the first call, store the tags in $output and get the next page
response=`curl https://hub.docker.com/v2/repositories/$1/tags 2>/dev/null`
getTags $response > $output
next=`getNext $response`

# Keep adding more tags to the $output until there's no next page
while [ ! -z "$next" ]
do 
    response=`curl $next 2>/dev/null`
    getTags $response >> $output
    next=`getNext $response`
done

# Sort the file (outputs it to the commmand line)
sort -V $output

# Cleanup
rm $output
