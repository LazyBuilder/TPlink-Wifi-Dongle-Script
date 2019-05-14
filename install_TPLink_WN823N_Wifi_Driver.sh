echo "Download and Install TP Link WIFI Driver"

if [ ! -d "Drivers" ]
then
	echo "Directory doesnot exist"
	mkdir "Drivers"
	echo "Directory created"
else
	echo "Directory exists"
fi

cd "Drivers"

echo "Moved to"

pwd

echo ""
echo "Getting driver"

git clone "https://github.com/ZeeRooo/RTL8192EU.git"

echo "Download complete"
echo ""
cd "RTL8192EU/"

make clean && make

echo "Make complete"

echo "Installing & loading driver"

sudo cp "8192eu.ko" "/lib/modules/$(uname -r)/kernel/drivers/net/wireless/" &&
sudo depmod -a &&
sudo modprobe -r rtl8xxxu &&
sudo modprobe 8192eu&&
sudo depmod -a &&

sudo sh -c 'echo " " >> /etc/modprobe.d/blacklist.conf' &&
sudo sh -c 'echo "#replaced by rtl8192" >> /etc/modprobe.d/blacklist.conf' &&
sudo sh -c 'echo "blacklist rtl8xxxu" >> /etc/modprobe.d/blacklist.conf' &&

sudo update-initramfs -u &&

echo "TP link driver installation completed"

#echo "Cleaning"

#cd "../"

#rm -rf "RTL8192EU"

echo "Installation complete"

sleep 4

clear
