#!/bin/bash
#title           :installation.sh
#description     :This script will help you with steps related to linux installation
#author          :ShirishRam
#date            :2017-09-27
#version         :0.1
#usage           :NA
#notes           :The contents in this file is only for your guide. You cannot execute this script directly.
#bash_version    :NA
#==============================================================================

#Format a USB flash drive
function format_usb()
{
	#Wipe out drive
	sudo dd bs=4M if=/dev/zero of=/dev/sdX && sync
	#X is the letter and N is the number of the drive where your USB is mounted
	
	#Create new partition table
	sudo fdisk /dev/sdX
	#Enter o to create new empty DOS partition table
	#Enter n to add a new partition table, enter the size of it
	#Enter w to write it to the disk

	#Format new partition
	sudo mkfs.vfat /dev/sdXN
	sudo eject /dev/sdX
}

#Create a bootable USB flash drive
function create_bootable_usb()
{
	sudo umount /dev/sdXN
	#X is the letter and N is the number of the drive where your USB is mounted
	sudo dd bs=4M if=input_iso_file.sh of=/dev/sdX && sync
}

#How to rescue from Grub rescue
function sos_grub_rescue()
{
	#In the grub rescue command prompt, check all the drives in your HDD, you need to know which is the drive where your linux was installed
	ls (hd0, msdos1) #Let's assume this is your linux partition
	set root=(hd0, msdos1)
	set prefix=(hd0, msdos1)/boot/grub #Location where grub is installed
	insmod normal
	normal

	#Fingers crossed...
	#If your rescue mission was successful, then try the below permanent fix after you login
	sudo update-grub
	sudo grub-install /dev/sdX #/dev/sdX is the boot drive
}
