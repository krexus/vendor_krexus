# Inherit AOSP device configuration for mako.
$(call inherit-product, device/lge/mako/full_mako.mk)

# Inherit common product files.
$(call inherit-product, vendor/krexus/products/common.mk)

# Inherit vendor specific product files.
$(call inherit-product, vendor/krexus/products/vendorless.mk)

# Inherit maintainer information (if exists).
$(call inherit-product-if-exists, device/lge/mako/krexus_maintainer.mk)

# Setup device specific product configuration.
PRODUCT_NAME := krexus_mako
PRODUCT_BRAND := google
PRODUCT_DEVICE := mako
PRODUCT_MODEL := Nexus 4
PRODUCT_MANUFACTURER := LGE

# Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=occam \
    BUILD_FINGERPRINT=google/occam/mako:6.0.1/MOB30M/2862625:user/release-keys \
    PRIVATE_BUILD_DESC="occam-user 6.0.1 MOB30M 2862625 release-keys"
