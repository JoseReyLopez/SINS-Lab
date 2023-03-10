#!/bin/sh


# Script for downloading the final topographical plots
#
# The script downloads the files from google drive using wget, also the links to google drive
# are provided in case this way does not work in the future
# The wget onliner was taken from:
# https://stackoverflow.com/questions/60608901/how-to-download-a-big-file-from-google-drive-via-curl-in-bash


# Links:
# 
# https://drive.google.com/file/d/1nSk00cFb6gp61DrcKpG2qLi6ol32ADWt/view?usp=share_link

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1nSk00cFb6gp61DrcKpG2qLi6ol32ADWt' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1nSk00cFb6gp61DrcKpG2qLi6ol32ADWt" -O Final_topographical_TF_plot.zip && rm -rf /tmp/cookies.txt

unzip -d Final_topographical_TF_plot Final_topographical_TF_plot.zip
rm Final_topographical_TF_plot.zip
mv Final_topographical_TF_plot ../Discrimination_397550/Final_topographical_TF_plot