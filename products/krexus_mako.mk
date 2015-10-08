# Inherit AOSP device configuration for mako.
$(call inherit-product, device/lge/mako/full_mako.mk)

# Inherit common product files.
$(call inherit-product, vendor/krexus/products/common.mk)

# Setup device specific product configuration.
PRODUCT_NAME := krexus_mako
PRODUCT_BRAND := google
PRODUCT_DEVICE := mako
PRODUCT_MODEL := Nexus 4
PRODUCT_MANUFACTURER := LGE

# Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=occam \
    BUILD_FINGERPRINT=google/occam/mako:5.1.1/LMY48P/2167285:user/release-keys \
    PRIVATE_BUILD_DESC="occam-user 5.1.1 LMY48P 2167285 release-keys"
