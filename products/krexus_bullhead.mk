# Inherit AOSP device configuration for bullhead
$(call inherit-product, device/lge/bullhead/aosp_bullhead.mk)

# Inherit common product files.
$(call inherit-product, vendor/krexus/products/common.mk)

# Inherit maintainer information (if exists).
$(call inherit-product-if-exists, device/lge/bullhead/krexus_maintainer.mk)

# Setup device specific product configuration.
PRODUCT_NAME := krexus_bullhead
PRODUCT_BRAND := google
PRODUCT_DEVICE := bullhead
PRODUCT_MODEL := Nexus 5X
PRODUCT_MANUFACTURER := LGE

# Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=bullhead \
    BUILD_FINGERPRINT=google/bullhead/bullhead:7.0/NRD90S/3142244:user/release-keys \
    PRIVATE_BUILD_DESC="bullhead-user 7.0 NRD90S 3142244 release-keys"
