# Inherit AOSP device configuration for flounder.
$(call inherit-product, device/htc/flounder/aosp_flounder.mk)

# Inherit common product files.
$(call inherit-product, vendor/krexus/products/common.mk)

# Inherit maintainer information (if exists).
$(call inherit-product-if-exists, device/htc/flounder/krexus_maintainer.mk)

# Setup device specific product configuration.
PRODUCT_NAME := krexus_flounder
PRODUCT_BRAND := google
PRODUCT_DEVICE := flounder
PRODUCT_MODEL := Nexus 9
PRODUCT_MANUFACTURER := HTC

# Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=volantis \
    BUILD_FINGERPRINT=google/volantis/flounder:6.0.1/MOB30G/2723637:user/release-keys \
    PRIVATE_BUILD_DESC="volantis-user 6.0.1 MOB30G 2723637 release-keys"
