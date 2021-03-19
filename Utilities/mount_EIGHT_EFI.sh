#! /bin/zsh

DEFAULT_VOLUME_NAME='EIGHT_EFI'
ADMIN_PWD='atom'

volumeName=`[ $1 ] && echo $1 || echo $DEFAULT_VOLUME_NAME`;
echo "volumeName=$volumeName"

mountPoint=`diskutil list | awk '{if($3~/'"$volumeName"'/) print $NF}'`
echo "mountPoint=$mountPoint"
if [[ -z $mountPoint ]]; then
	echo "Can not found a valid mountPoint with this volumeName:$volumeName !!!" && exit;
fi

echo $ADMIN_PWD | sudo -S diskutil mount "$mountPoint" \
	&& open "/Volumes/$volumeName/EFI/OC/" \
	|| open "/Volumes/$volumeName/EFI/Clover/" \
	|| open "/Volumes/$volumeName/EFI/" \
	|| open "/Volumes/$volumeName/" \
	&& open /Volumes/EIGHT_EFI/EFI/OC/config.plist

sleep 2