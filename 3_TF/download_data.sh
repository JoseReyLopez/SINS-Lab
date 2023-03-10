#!/bin/sh


# Script for downloading the voltage files necessary to perform time frequency analysis
#
# The script downloads the files from google drive using wget, also the links to google drive
# are provided in case this way does not work in the future
# The wget onliner was taken from:
# https://stackoverflow.com/questions/60608901/how-to-download-a-big-file-from-google-drive-via-curl-in-bash


# Links:
#
# Folder: 
#
# https://drive.google.com/drive/folders/1sjv-D5AYPiMg34uEaOTdAon0nmgWILfd?usp=share_link
#
# Individual files:
#
# https://drive.google.com/file/d/1lclvc16ePeXtgto_lujuhGYd743mpv-W/view?usp=share_link
# https://drive.google.com/file/d/1hpxGtCDfzEwvzHmUQmvx0Iz6GDGuMKmv/view?usp=share_link
# https://drive.google.com/file/d/1ayldtSq2knArn4eo7-aahpm-zrQPtkPF/view?usp=share_link
# https://drive.google.com/file/d/1pOHq7-v5mJfcGVkJmK3ZTjfyOU9wEXd6/view?usp=share_link
# https://drive.google.com/file/d/1VepsMxhVZKAJrDXA3YLWhXXPbR1XLkhR/view?usp=share_link
# https://drive.google.com/file/d/194St1GSKVv2almcHMupgKZBxnz7uFVRF/view?usp=share_link
# https://drive.google.com/file/d/1QqFSQqHz8VWGL9bZrPOzhcmc00HSpoDs/view?usp=share_link
# https://drive.google.com/file/d/19zdC3HitxVMCXv3oCNn3HpdTA98ZZ6SV/view?usp=share_link
# https://drive.google.com/file/d/1bCrELHgt5OiqeMdfitcieC0Pqdp6HdwV/view?usp=share_link
# https://drive.google.com/file/d/1Fbq71BO1iwY4xLgMu2J9QrHtdZi-ym_d/view?usp=share_link
# https://drive.google.com/file/d/1f7Etp83zP4MYciOCm56J3FLXwStVF2io/view?usp=share_link

mkdir Discrimination_397550
cd Discrimination_397550


# 1
# 2021_07_09_notchfilt100Hz.mat
# https://drive.google.com/file/d/1lclvc16ePeXtgto_lujuhGYd743mpv-W/view?usp=share_link

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1lclvc16ePeXtgto_lujuhGYd743mpv-W' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1lclvc16ePeXtgto_lujuhGYd743mpv-W" -O 2021_07_09_notchfilt100Hz.mat && rm -rf /tmp/cookies.txt




# 2
# 2021_07_12_notchfilt100Hz.mat
# https://drive.google.com/file/d/1hpxGtCDfzEwvzHmUQmvx0Iz6GDGuMKmv/view?usp=share_link

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1hpxGtCDfzEwvzHmUQmvx0Iz6GDGuMKmv' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1hpxGtCDfzEwvzHmUQmvx0Iz6GDGuMKmv" -O 2021_07_12_notchfilt100Hz.mat && rm -rf /tmp/cookies.txt



# 3
# 2021_07_16_notchfilt100Hz.mat
# https://drive.google.com/file/d/1ayldtSq2knArn4eo7-aahpm-zrQPtkPF/view?usp=share_link

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1ayldtSq2knArn4eo7-aahpm-zrQPtkPF' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1ayldtSq2knArn4eo7-aahpm-zrQPtkPF" -O 2021_07_16_notchfilt100Hz.mat && rm -rf /tmp/cookies.txt




# 4
# 2021_07_20_notchfilt100Hz.mat
# https://drive.google.com/file/d/1pOHq7-v5mJfcGVkJmK3ZTjfyOU9wEXd6/view?usp=share_link

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1pOHq7-v5mJfcGVkJmK3ZTjfyOU9wEXd6' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1pOHq7-v5mJfcGVkJmK3ZTjfyOU9wEXd6" -O 2021_07_20_notchfilt100Hz.mat && rm -rf /tmp/cookies.txt




# 5
# 2021_07_22_notchfilt100Hz.mat
# https://drive.google.com/file/d/1VepsMxhVZKAJrDXA3YLWhXXPbR1XLkhR/view?usp=share_link

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1VepsMxhVZKAJrDXA3YLWhXXPbR1XLkhR' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1VepsMxhVZKAJrDXA3YLWhXXPbR1XLkhR" -O 2021_07_22_notchfilt100Hz.mat && rm -rf /tmp/cookies.txt




# 6
# 2021_07_26_notchfilt100Hz.mat
# https://drive.google.com/file/d/194St1GSKVv2almcHMupgKZBxnz7uFVRF/view?usp=share_link

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=194St1GSKVv2almcHMupgKZBxnz7uFVRF' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=194St1GSKVv2almcHMupgKZBxnz7uFVRF" -O 2021_07_26_notchfilt100Hz.mat && rm -rf /tmp/cookies.txt




# 7
# 2021_07_27_notchfilt100Hz.mat
# https://drive.google.com/file/d/1QqFSQqHz8VWGL9bZrPOzhcmc00HSpoDs/view?usp=share_link

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1QqFSQqHz8VWGL9bZrPOzhcmc00HSpoDs' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1QqFSQqHz8VWGL9bZrPOzhcmc00HSpoDs" -O 2021_07_27_notchfilt100Hz.mat && rm -rf /tmp/cookies.txt




# 8
# 2021_07_28_notchfilt100Hz.mat
# https://drive.google.com/file/d/19zdC3HitxVMCXv3oCNn3HpdTA98ZZ6SV/view?usp=share_link

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=19zdC3HitxVMCXv3oCNn3HpdTA98ZZ6SV' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=19zdC3HitxVMCXv3oCNn3HpdTA98ZZ6SV" -O 2021_07_28_notchfilt100Hz.mat && rm -rf /tmp/cookies.txt



# 9
# 2021_07_29_notchfilt100Hz.mat
# https://drive.google.com/file/d/1bCrELHgt5OiqeMdfitcieC0Pqdp6HdwV/view?usp=share_link

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1bCrELHgt5OiqeMdfitcieC0Pqdp6HdwV' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1bCrELHgt5OiqeMdfitcieC0Pqdp6HdwV" -O 2021_07_29_notchfilt100Hz.mat && rm -rf /tmp/cookies.txt




# 10
# 2021_07_30_notchfilt100Hz.mat
# https://drive.google.com/file/d/1Fbq71BO1iwY4xLgMu2J9QrHtdZi-ym_d/view?usp=share_link

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1Fbq71BO1iwY4xLgMu2J9QrHtdZi-ym_d' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1Fbq71BO1iwY4xLgMu2J9QrHtdZi-ym_d" -O 2021_07_30_notchfilt100Hz.mat && rm -rf /tmp/cookies.txt




# 11
# 2021_08_02_notchfilt100Hz.mat
# https://drive.google.com/file/d/1f7Etp83zP4MYciOCm56J3FLXwStVF2io/view?usp=share_link

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1f7Etp83zP4MYciOCm56J3FLXwStVF2io' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1f7Etp83zP4MYciOCm56J3FLXwStVF2io" -O 2021_08_02_notchfilt100Hz.mat && rm -rf /tmp/cookies.txt

mv Discrimination_397550 ../Discrimination_397550