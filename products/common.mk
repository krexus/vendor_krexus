PRODUCT_BRAND ?= krexus

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.com.android.dataroaming=false \
    ro.opa.eligible_device=true \
    ro.setupwizard.network_required=false \
    ro.setupwizard.enterprise_mode=1 \
    ro.setupwizard.rotation_locked=true \
    ro.error.receiver.system.apps=com.google.android.gms \
    ro.atrace.core.services=com.google.android.gms,com.google.android.gms.ui,com.google.android.gms.persistent \
    ro.krexus.version=krexus_n-$(shell date +"%y%m%d")-$(TARGET_DEVICE)

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
    CellBroadcastReceiver \
    Masquerade \
    Launcher3 \
    LiveWallpapersPicker \
    Stk \
    SystemUpdates \
    WallpaperPicker

# Include librsjni explicitly to workaround GMS issue
PRODUCT_PACKAGES += \
    librsjni

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Latin IME lib
ifneq ($(filter arm,$(TARGET_ARCH)),)
PRODUCT_COPY_FILES += \
    vendor/krexus/prebuilt/common/lib/libjni_latinime.so:system/lib/libjni_latinime.so
else
PRODUCT_COPY_FILES += \
    vendor/krexus/prebuilt/common/lib64/libjni_latinime.so:system/lib64/libjni_latinime.so
endif

# Backuptool Support
PRODUCT_COPY_FILES += \
    vendor/krexus/prebuilt/common/addon.d/50-krexus.sh:system/addon.d/50-krexus.sh \
    vendor/krexus/prebuilt/common/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/krexus/prebuilt/common/bin/backuptool.functions:system/bin/backuptool.functions
