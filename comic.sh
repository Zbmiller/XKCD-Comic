#!/bin/sh

#
#Zachary Miller 10/9/2021
#
#Coding Challenge for HR Block Interview
#
#Application for downloading the latest XFCE comic from the home page
#

#
#First, request the location for images to be downloaded to.
#

echo "Please enter the desired file pathway to save images to."

read filepath

#
#Next, make call out to webpage 'https://xkcd.com/'
#Download the html for extracting today's comic image
#Write to defined directory
#
#wget
#-O for file output. In this case as defined from user input from read command
#

wget -O $filepath/comicpage https://xkcd.com/

#
#Define url variable by using grep to extract image url from source html. 
#grep -o used to find exact match of the pattern
#use of .* wild card to allow for title of image to be captured
#

url=$(grep -o 'https://imgs.xkcd.com/comics/.*.png' $filepath/comicpage)

#
#Log out result of grep for comfirmation of url. 
#

echo "This is the expected url '$url'"

#
#Let's use the filepath variable (as defined by the user) and the extracted url variable 
#
#wget
#
#-nd prevents the creation of a directory hierarchy (i.e. no directories).
#-r enables recursive retrieval. See Recursive Download for more information.
#-P sets the directory prefix where all files and directories are saved to.
#-A sets a whitelist for retrieving only certain file types. Strings and patterns are accepted, and both can be used in a comma separated list (as seen above). See Types of Files for #more information.
#

wget -nd -r -P $filepath -A png $url

#
#Now let's create the checksum for the image using md5sum
#
#use of wildcare *.png to use the titled image wget download
#

md5sum *.png > ComicCheckSum.txt

#
#Log out checksum file has been written
#

echo "Checksum has been written to file."

#
#Clean up html file from define directory
#

rm $filepath/comicpage

#
#Log out clean up and completion
#

echo "File clean up complete. Comic in selected directory"