# Ubuntu Server automated installation
# by Scott Lowe (scott.lowe@scottlowe.org)

d-i debian-installer/locale string en_US
d-i console-setup/ask_detect boolean false
d-i keyboard-configuration/layoutcode string us
d-i netcfg/choose_interface select eth0
d-i netcfg/get_hostname string hostname
d-i netcfg/get_domain string domain.com
d-i netcfg/wireless_wep string
d-i mirror/country string manual
d-i mirror/http/hostname string pxehost.domain.com
d-i mirror/http/directory string /ubuntu/14.04.2
d-i mirror/http/proxy string
d-i live-installer/net-image string http://192.168.100.240/ubuntu/14.04.2/install/filesystem.squashfs
d-i clock-setup/utc boolean true
d-i time/zone string US/Mountain
d-i clock-setup/ntp boolean true
d-i clock-setup/ntp-server string 0.us.pool.ntp.org
d-i partman-auto/disk string /dev/sda
d-i partman-auto/method string lvm
d-i partman-lvm/device_remove_lvm boolean true
d-i partman-lvm/device_remove_lvm_span boolean true
d-i partman-auto/purge_lvm_from_device boolean true
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
d-i partman-auto-lvm/new_vg_name string hostname_vg
d-i partman-auto/expert_recipe string \
    standard ::                       \
      512 512 512 ext3                \
        $primary{ }                   \
        $bootable{ }                  \
        method{ format }              \
        format{ }                     \
        use_filesystem{ }             \
        filesystem{ ext3 }            \
        mountpoint{ /boot }           \
      .                               \
      24576 10000 -1 ext4             \
        $lvmok{ }                     \
        method{ format }              \
        format{ }                     \
        use_filesystem{ }             \
        filesystem{ ext4 }            \
        mountpoint{ / }               \
        lv_name{ root_lv }            \
      .                               \
      1024 512 3172 linux-swap        \
        $lvmok{ }                     \
        method{ swap }                \
        format{ }                     \
        lv_name{ swap_lv }            \
      .
d-i partman-auto/choose_recipe standard
d-i partman-auto-lvm/guided_size string max
d-i partman-partitioning/confirm_write_new_label boolean true
d-i partman/choose_partition select finish
d-i partman/confirm boolean true
d-i partman/confirm_nooverwrite boolean true
d-i partman-auto/confirm boolean true
#d-i passwd/root-login boolean false
#d-i passwd/make-user boolean false
#d-i passwd/root-password password r00tme
#d-i passwd/root-password-again password r00tme
d-i passwd/user-fullname string Administrator
d-i passwd/username string admin
d-i passwd/user-password password ChangeMe!
d-i passwd/user-password-again password ChangeMe!
d-i user-setup/allow-password-weak boolean true
d-i user-setup/encrypt-home boolean false
d-i pkgsel/include string openssh-server update-motd
tasksel tasksel/first multiselect server, openssh-server
d-i pkgsel/update-policy select none
d-i grub-installer/only_debian boolean true
d-i grub-installer/with_other_os boolean true
d-i preseed/late_command string \
wget http://192.168.100.240/conf/sources.list -O /target/etc/apt/sources.list; \
wget http://192.168.100.240/conf/apt.conf -O /target/etc/apt/apt.conf
d-i finish-install/reboot_in_progress note
