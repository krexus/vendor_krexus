# Inherit AOSP device configuration for hammerhead.
$(call inherit-product, device/lge/hammerhead/aosp_hammerhead.mk)

# Inherit common product files.
$(call inherit-product, vendor/krexus/products/common.mk)

# Inherit vendor specific product files.
$(call inherit-product, vendor/krexus/products/vendorless.mk)

# Inherit maintainer information (if exists).
$(call inherit-product-if-exists, device/lge/hammerhead/krexus_maintainer.mk)

# Setup device specific product configuration.
PRODUCT_NAME := krexus_hammerhead
PRODUCT_BRAND := google
PRODUCT_DEVICE := hammerhead
PRODUCT_MODEL := Nexus 5
PRODUCT_MANUFACTURER := LGE

# Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=hammerhead \
    BUILD_FINGERPRINT=google/hammerhead/hammerhead:7.0/NRD90S/3142244:user/release-keys \
    PRIVATE_BUILD_DESC="hammerhead-user 7.0 NRD90S 3142244 release-keys"
