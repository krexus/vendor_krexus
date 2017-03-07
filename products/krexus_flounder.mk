# Inherit AOSP device configuration for flounder.
$(call inherit-product, device/htc/flounder/aosp_flounder.mk)

# Inherit common product files.
$(call inherit-product, vendor/krexus/products/common.mk)

# Setup device specific product configuration.
PRODUCT_NAME := krexus_flounder
PRODUCT_BRAND := google
PRODUCT_DEVICE := flounder
PRODUCT_MODEL := Nexus 9
PRODUCT_MANUFACTURER := HTC

# Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=volantis \
    BUILD_FINGERPRINT="google/volantis/flounder:7.1.1/N4F26T/3687331:user/release-keys" \
    PRIVATE_BUILD_DESC="volantis-user 7.1.1 N4F26T 3687331 release-keys"
