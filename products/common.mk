PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.com.android.dataroaming=false \
    ro.setupwizard.network_required=false \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.adb.secure=1 \
    ro.krexus.version=krexus_mm-$(shell date +"%y%m%d")-$(TARGET_DEVICE)

# Bootanimation (add if it exists)
ifneq ($(wildcard $(call my-dir)/../prebuilt/bootanimation/$(TARGET_DEVICE).zip),)
PRODUCT_COPY_FILES += \
        $(call my-dir)/../prebuilt/bootanimation/$(TARGET_DEVICE).zip:system/media/bootanimation.zip
endif

# Extra Packages
PRODUCT_PACKAGES += \
    CellBroadcastReceiver \
    Launcher3 \
    LiveWallpapersPicker \
    Stk \
    WallpaperPicker

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Latin IME lib
ifneq ($(filter arm,$(TARGET_ARCH)),)
PRODUCT_COPY_FILES += \
    $(call my-dir)/..prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so
else
PRODUCT_COPY_FILES += \
    $(call my-dir)/..prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so
endif
