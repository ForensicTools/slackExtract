#!/bin/bash

#display the usage.
function displayUsage(){

echo "slackExtract Usage: slackExtract -i <input> -o <outputfile>

-i <input>
The -i option is for the drive or image that you want to extract the filesystem slack of. This option will need the file path to the image or drive.
	ex.) -i /dev/sdb

-o <output file> 	
The -o option is where you want the image file file that contains the content of slack space to be written to. 
	ex.) -o slackspace.img"

}


#for loop to grab all the arguments.
for i in "$@"
do
case $1 in

	#User uses -i to specify input.
	-i)
	input="$2"
	
	shift
	shift
	;;

	#user uses -ip to specify IP addresses.
	-o)
	output="$2"

	#shift
	#shift
	;;

	#if any other cases
	*)

	#display usage and exit
	displayUsage
	exit 1
	;;
esac
done

#get the information about the partition/image. 
SectorSize=$(fdisk -l ${input} | grep  "sectors of" | cut -f8 -d" ")
PartitionSize=$(fdisk -l ${input} | grep "Disk ${input}" | cut -f7 -d" ")
FileSystemSize=$(fdisk -l ${input} | grep -A1 "Device" | grep -v "Device" | cut -f9 -d" ")
SlackSize=$(expr $PartitionSize - $FileSystemSize)
echo "Sector Size = ${SectorSize}"
echo "Partition Size = ${PartitionSize}"
echo "FileSystem Size = ${FileSystemSize}"
echo "File System Slack Size = ${SlackSize}"

#If there is filesystem slack found on the drive
if((${SlackSize} > 0))
then
echo "Filesystem Slack Found"
dd if=${input} bs=${SectorSize} skip=${FileSystemSize} count=${SlackSize} of=slackimage.img &> /dev/null

#Get the hexdump of the filesystem slack
HEXDUMP=$(hd slackimage.img)
echo
echo "${HEXDUMP}"
echo "${HEXDUMP}" >> ${output}

fi

exit 1
