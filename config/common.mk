PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false

PRODUCT_PROPERTY_OVERRIDES += \
    ro.build.selinux=1

# Disable excessive dalvik debug messages
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.debug.alloc=0

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/tipsy/prebuilt/common/bin/backuptool.sh:install/bin/backuptool.sh \
    vendor/tipsy/prebuilt/common/bin/backuptool.functions:install/bin/backuptool.functions \
    vendor/tipsy/prebuilt/common/bin/50-slim.sh:system/addon.d/50-slim.sh \
    vendor/tipsy/prebuilt/common/bin/99-backup.sh:system/addon.d/99-backup.sh \
    vendor/tipsy/prebuilt/common/etc/backup.conf:system/etc/backup.conf

# Signature compatibility validation
PRODUCT_COPY_FILES += \
    vendor/tipsy/prebuilt/common/bin/otasigcheck.sh:install/bin/otasigcheck.sh

# tipsy-specific init file
PRODUCT_COPY_FILES += \
    vendor/tipsy/prebuilt/common/etc/init.local.rc:root/init.slim.rc

# Copy latinime for gesture typing
PRODUCT_COPY_FILES += \
    vendor/tipsy/prebuilt/common/lib/libjni_latinimegoogle.so:system/lib/libjni_latinimegoogle.so

# SELinux filesystem labels
PRODUCT_COPY_FILES += \
    vendor/tipsy/prebuilt/common/etc/init.d/50selinuxrelabel:system/etc/init.d/50selinuxrelabel

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Don't export PS1 in /system/etc/mkshrc.
PRODUCT_COPY_FILES += \
    vendor/tipsy/prebuilt/common/etc/mkshrc:system/etc/mkshrc \
    vendor/tipsy/prebuilt/common/etc/sysctl.conf:system/etc/sysctl.conf

PRODUCT_COPY_FILES += \
    vendor/tipsy/prebuilt/common/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/tipsy/prebuilt/common/etc/init.d/90userinit:system/etc/init.d/90userinit \
    vendor/tipsy/prebuilt/common/bin/sysinit:system/bin/sysinit

# Embed SuperUser
SUPERUSER_EMBEDDED := true

# Required packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Development \
    SpareParts \
    Superuser \
    su

# Optional packages
PRODUCT_PACKAGES += \
    Basic \
    LiveWallpapersPicker \
    PhaseBeam

# AudioFX
PRODUCT_PACKAGES += \
    AudioFX \
    Eleven

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    org.cyanogenmod.hardware \
    org.cyanogenmod.hardware.xml

# Extra Optional packages
PRODUCT_PACKAGES += \
    SlimOTA \
    LatinIME \
    BluetoothExt \
    LockClock \
    DashClock \
    CMFileManager \
    WallpaperPicker

#    SlimFileManager removed until updated
# Extra tools

# Chromium prebuilt
ifeq ($(PRODUCT_PREBUILT_WEBVIEWCHROMIUM),yes)
-include prebuilts/chromium/$(TARGET_DEVICE)/chromium_prebuilt.mk
endif

# CM Hardware Abstraction Framework
PRODUCT_PACKAGES += \
    openvpn \
    libsepol \
    e2fsck \
    mke2fs \
    tune2fs \
    mount.exfat \
    fsck.exfat \
    mkfs.exfat \
    ntfsfix \
    ntfs-3g

# Stagefright FFMPEG plugin
PRODUCT_PACKAGES += \
    libffmpeg_extractor \
    libffmpeg_omx \
    media_codecs_ffmpeg.xml

PRODUCT_PROPERTY_OVERRIDES += \
    media.sf.omx-plugin=libffmpeg_omx.so \
    media.sf.extractor-plugin=libffmpeg_extractor.so

# easy way to extend to add more packages
-include vendor/extra/product.mk

PRODUCT_PACKAGE_OVERLAYS += vendor/tipsy/overlay/common

# Bootanimation support
PRODUCT_COPY_FILES += \
	$(LOCAL_PATH)/media/bootanimation.zip:system/media/bootanimation.zip

# SuperSU
PRODUCT_COPY_FILES += \
	vendor/tipsy/prebuilt/common/UPDATE-SuperSU.zip:system/addon.d/UPDATE-SuperSU.zip \
	vendor/tipsy/prebuilt/common/etc/init.d/99SuperSUDaemon:system/etc/init.d/99SuperSUDaemon

# NovaLauncher
PRODUCT_COPY_FILES += \
vendor/tipsy/prebuilt/common/app/Nova33.apk:system/app/Nova33.apk

# Adaway
PRODUCT_COPY_FILES += \
vendor/tipsy/prebuilt/common/app/adaway.apk:system/app/adaway.apk

# Kerneladiutor
PRODUCT_COPY_FILES += \
vendor/tipsy/prebuilt/common/app/kerneladiutor.apk:system/app/kerneladiutor.apk

# Layers Manager
PRODUCT_COPY_FILES += \
vendor/tipsy/prebuilt/common/app/layersmanager.apk:system/app/layersmanager.apk

# Layers_backup_restore
PRODUCT_COPY_FILES += \
vendor/tipsy/prebuilt/common/app/Layers_backup_restore.apk:system/app/Layers_backup_restore.apk

# Versioning System
# tipsyLP first version.
PRODUCT_VERSION_MAJOR = 5.1.1
PRODUCT_VERSION_MINOR = Final_hangover
PRODUCT_VERSION_MAINTENANCE = v2.3
ifdef TIPSY_BUILD_EXTRA
    TIPSY_POSTFIX := -$(TIPSY_BUILD_EXTRA)
endif
ifndef TIPSY_BUILD_TYPE
    TIPSY_BUILD_TYPE := Release
    TIPSY_POSTFIX := -$(shell date +"%Y%m%d-%H%M")
endif

# Set all versions
TIPSY_VERSION := tipsy-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(TIPSY_POSTFIX)
TIPSY_MOD_VERSION := tipsy-$(TIPSY_BUILD)-$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE)-$(TIPSY_POSTFIX)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    tipsy.ota.version=$(PRODUCT_VERSION_MAJOR).$(PRODUCT_VERSION_MINOR).$(PRODUCT_VERSION_MAINTENANCE) \
    ro.tipsy.version=$(TIPSY_VERSION) \
    ro.modversion=$(TIPSY_MOD_VERSION) \
    ro.tipsy.buildtype=$(TIPSY_BUILD_TYPE)

EXTENDED_POST_PROCESS_PROPS := vendor/tipsy/tools/tipsy_process_props.py

