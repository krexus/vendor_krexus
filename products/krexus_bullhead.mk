# Inherit AOSP device configuration for bullhead
$(call inherit-product, device/lge/bullhead/aosp_bullhead.mk)

# Inherit common product files.
$(call inherit-product, vendor/krexus/products/common.mk)

# Setup device specific product configuration.
PRODUCT_NAME := krexus_bullhead
PRODUCT_BRAND := google
TARGET_DEVICE := bullhead
PRODUCT_MODEL := Nexus 5X
PRODUCT_MANUFACTURER := LGE

# Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=bullhead \
    BUILD_FINGERPRINT="google/bullhead/bullhead:8.1.0/OPM6.171019.030.K1/4947289:user/release-keys" \
    PRIVATE_BUILD_DESC="bullhead-user 8.1.0 OPM6.171019.030.K1 4947289 release-keys"