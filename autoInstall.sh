clear

echo " press 1 for ubuntu 14.04 server"
printf "Enter your choice ::: "
read choice

case $choice in
	1)
		echo "############# Choose Ubuntu 14.04 Server   ##############"
		echo "Enter the iso location"
		read loc
		if [ -f "$loc" ]
		then
			if [ $(echo "$loc" | grep ".iso" ) ]
			then
				echo "ya"
				cp $(echo $loc) ./ubuntu14.iso
				mkdir iso
				sudo mount -o loop ubuntu14.iso ./iso
				rsync -avr ./iso/ ./extract/
				sudo chmod 777 -R extract
				sudo umount ./iso
				sudo rm -R ./iso
				rm ./extract/isolinux/isolinux.cfg
				rm ./extract/isolinux/txt.cfg
				rm ./extract/isolinux/langlist
				rm ./extract/preseed/ubuntu-server.seed
				cp ./files/14ser/isolinux.cfg ./extract/isolinux/isolinux.cfg
				#cp ./files/14ser/txt.cfg ./extract/isolinux/txt.cfg
				#cp ./files/14/langlist ./extract/isolinux/langlist
				echo "########## Choose a language for installation purpose #########"
				echo "press 1 for arabic"
				echo "press 2 for belarusia"
				echo "press 3 for bosnian"
				echo "press 4 for chinese"
				echo "press 5 for czech"
				echo "press 6 for danish"
				echo "press 7 for english"
				echo "press 8 for english_us"
				echo "press 9 for french"
				echo "press 10 for german"
				echo "press 12 for hebrew"
				echo "press 13 for hindi"
				echo "press 14 for japanese"
				echo "press 15 for kannada"
				echo "press 16 for malayalam"
				echo "press 17 for portugese"
				echo "press 18 for russian"
				echo "press 19 for tamil"
				language="en_US.UTF-8"
				read lang
				case $lang in
					1 )
						language="af_ZA.UTF-8";;
					2 )
						language="be_BY.UTF-8";;
					3 )
						language="bs_BA.UTF-8";;
					4 )
						language="zh_CN.UTF-8";;
					5 )
						language="cs_CZ.UTF-8";;
					6 )
						language="da_DK.UTF-8";;
					7 )
						language="en_US.UTF-8";;
					8 )
						language="en.UTF-8";;
					9 )
						language="fr_FR.UTF-8";;
					10 )
						language="de_DE.UTF-8";;
					12 )
						language="he_IL.UTF-8";;
					13 )
						language="hi_IN.UTF-8"

						;;
					14 )
						language="ja_JP.UTF-8";;
					15 )
						language="kn_IN.UTF-8";;
					16 )
						language="ml_IN.UTF-8";;
					17 )
						language="pt_PT.UTF-8";;
					18 )
						language="ru_RU.UTF-8";;
					19 )
						language="ta_IN.UTF-8";;
					* )
						;;
				esac
				echo $language >> ./extract/isolinux/langlist
				txt="default install
\nlabel install
\n  menu label ^Install Ubuntu Server
\n  kernel /install/vmlinuz
\n  append locale=$language keyboard-configuration/layoutcode=us file=/cdrom/preseed/ubuntu-server.seed vga=788 initrd=/install/initrd.gz quiet --
"
				echo $txt > ./extract/isolinux/txt.cfg
				echo "#########################################################"
				echo "#########################################################"
				printf " Enter the user-fullname::: "
				read fullname
				printf "\n Enter the username:::::::: "
				read username
				printf "\n Enter the password:::::::: "
				read password1
				printf "\n Enter the password again:: "
				read password2
				printf "\n Enter the hostname::::::::"
				read hostname

echo "######################################################################
\n# General
\n####################################################################
## Options to set on the command line
\nd-i debian-installer/locale string $language
\nd-i console-setup/ask_detect boolean false
\nd-i console-setup/layout string us
\n
\nd-i netcfg/enable boolean false
\nd-i netcfg/get_hostname string $hostname
\nd-i netcfg/get_domain string unassigned-domain
\n
\nd-i time/zone string UTC
\nd-i clock-setup/utc-auto boolean true
\nd-i clock-setup/utc boolean true
\n
\nd-i kbd-chooser/method select American English
\n
\nd-i netcfg/wireless_wep string
\n
\nd-i base-installer/kernel/override-image string linux-server
\n
\nd-i debconf debconf/frontend select Noninteractive
\n
\nd-i pkgsel/install-language-support boolean false
\ntasksel tasksel/first multiselect standard, ubuntu-server
\n
\nd-i partman-auto/method string lvm
\n
\nd-i partman-lvm/confirm boolean true
\nd-i partman-lvm/device_remove_lvm boolean true
\nd-i partman-auto/choose_recipe select atomic
\n
\nd-i partman/confirm_write_new_label boolean true
\nd-i partman/confirm_nooverwrite boolean true
\nd-i partman/choose_partition select finish
\nd-i partman/confirm boolean true
\n
\n# Write the changes to disks and configure LVM?
\nd-i partman-lvm/confirm boolean true
\nd-i partman-lvm/confirm_nooverwrite boolean true
\nd-i partman-auto-lvm/guided_size string max
\n
\n### Keyboard selection ###
\nd-i keyboard-configuration/layoutcode string us
\nd-i keyboard-configuration/variantcode string
\n
\n### Locale ###
\nd-i debian-installer/locale string en_US
\n
\n
\n# Default user
\nd-i passwd/user-fullname string $fullname
\nd-i passwd/username string $username
\nd-i passwd/user-password password $password1
\nd-i passwd/user-password-again password $password2
\nd-i user-setup/encrypt-home boolean false
\nd-i user-setup/allow-password-weak boolean true
\n
\n# Minimum packages (see postinstall.sh)
\nd-i pkgsel/include string openssh-server ntp
\n
\n# Upgrade packages after debootstrap? (none, safe-upgrade, full-upgrade)
\n# (note: set to none for speed)
\nd-i pkgsel/upgrade select none
\n
\nd-i grub-installer/only_debian boolean true
\nd-i grub-installer/with_other_os boolean true
\nd-i finish-install/reboot_in_progress note
\n
\nd-i pkgsel/update-policy select none
\n
\nchoose-mirror-bin mirror/http/proxy string
\n"	>> ./extract/preseed/ubuntu-server.seed
				##########cp ./files/15/u_preseed ./extract/preseed/ubuntu.seed
				sudo mkisofs -r -V "output.iso" -cache-inodes -J -l -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -o output.iso ./extract
				sudo chmod 777 output.iso
				rm -R extract
				rm ubuntu14.iso

			else
				echo "not a valid iso file "
			fi

		else
			echo "not a file"
		fi
		;;
