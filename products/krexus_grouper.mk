# Inherit AOSP device configuration for grouper.
$(call inherit-product, device/asus/grouper/aosp_grouper.mk)

# Inherit common product files.
$(call inherit-product, vendor/krexus/products/common.mk)

# Inherit vendor specific product files.
$(call inherit-product, vendor/krexus/products/vendorless.mk)

# Inherit maintainer information (if exists).
$(call inherit-product-if-exists, device/asus/grouper/krexus_maintainer.mk)

# Setup device specific product configuration.
PRODUCT_NAME := krexus_grouper
PRODUCT_BRAND := google
PRODUCT_DEVICE := grouper
PRODUCT_MODEL := Nexus 7
PRODUCT_MANUFACTURER := asus

# Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=grouper \
    BUILD_FINGERPRINT=google/nakasi/hammerhead:6.0.1/MOB30P/2960889:user/release-keys \
    PRIVATE_BUILD_DESC="nakasi-user 6.0.1 MOB30P 2960889 release-keys"
