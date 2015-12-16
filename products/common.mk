# Generic product
PRODUCT_NAME := krexus
PRODUCT_BRAND := krexus
PRODUCT_DEVICE := generic

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.config.alarm_alert=Oxygen.ogg \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false \
    ro.setupwizard.network_required=false \
    ro.setupwizard.gservices_delay=-1 \
    ro.adb.secure=1

# Common overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/krexus/overlay/common

# Bootanimation (add if it exists)
ifneq ($(wildcard vendor/krexus/prebuilt/bootanimation/$(TARGET_DEVICE).zip),)
PRODUCT_COPY_FILES += \
        vendor/krexus/prebuilt/bootanimation/$(TARGET_DEVICE).zip:system/media/bootanimation.zip
endif

# Extra Packages
PRODUCT_PACKAGES += \
    Busybox \
    Launcher3 \
    LiveWallpapersPicker \
    Stk \
    WallpaperPicker

# Latin IME lib (automatically copies the correct target arch lib)
PRODUCT_COPY_FILES += \
    vendor/krexus/prebuilt/$(TARGET_ARCH)/system/lib/libjni_latinime.so:system/lib${TARGET_ARCH:3}/libjni_latinime.so

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Backuptool Support
PRODUCT_COPY_FILES += \
    vendor/krexus/prebuilt/common/addon.d/50-krexus.sh:system/addon.d/50-krexus.sh \
    vendor/krexus/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/krexus/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions
    
# Blobs necessary for media effects for devices without a vendor partition
ifneq ($(filter krexus_flo krexus_grouper krexus_hammerhead krexus_mako krexus_shamu,$(TARGET_PRODUCT)),)
PRODUCT_COPY_FILES +=  \
    vendor/krexus/prebuilt/common/vendor/media/LMspeed_508.emd:system/vendor/media/LMspeed_508.emd \
    vendor/krexus/prebuilt/common/vendor/media/PFFprec_600.emd:system/vendor/media/PFFprec_600.emd
endif
