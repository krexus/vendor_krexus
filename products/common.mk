# Generic product
PRODUCT_NAME := icarus
PRODUCT_BRAND := icarus
PRODUCT_DEVICE := generic

PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html \
    ro.com.google.clientidbase=android-google \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    ro.com.android.dateformat=MM-dd-yyyy \
    ro.com.android.dataroaming=false
    
#Icarus build.prop overrides
PRODUCT_PROPERTY_OVERRIDES += \
    ro.setupwizard.network_required=false \
    ro.setupwizard.gservices_delay=-1

# Launcher3 supported devices
ifneq ($(filter icarus_hammerhead icarus_mako,$(TARGET_PRODUCT)),)
PRODUCT_PACKAGES += \
    Launcher3
endif

# Common overlay
PRODUCT_PACKAGE_OVERLAYS += vendor/icarus/overlay/common

# Enable SIP+VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# STK: overlay common to all devices with telephony
ifneq ($(filter icarus_hammerhead icarus_mako icarus_shamu,$(TARGET_PRODUCT)),)
# Build SimToolKit
PRODUCT_PACKAGES += \
    Stk
endif

# Latin IME lib
PRODUCT_COPY_FILES += \
    vendor/icarus/proprietary/common/system/lib/libjni_latinime.so:system/lib/libjni_latinime.so
    
# Chromium Prebuilt
ifeq ($(PRODUCT_PREBUILT_WEBVIEWCHROMIUM),yes)
-include prebuilts/chromium/$(TARGET_DEVICE)/chromium_prebuilt.mk
endif
