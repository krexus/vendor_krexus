# Inherit AOSP device configuration for sailfish
$(call inherit-product, device/google/marlin/aosp_sailfish.mk)

# Inherit common product files.
$(call inherit-product, vendor/krexus/products/common.mk)

# Setup device specific product configuration.
PRODUCT_NAME := krexus_sailfish
PRODUCT_BRAND := google
PRODUCT_DEVICE := sailfish
PRODUCT_MODEL := Pixel
PRODUCT_MANUFACTURER := Google

# Fingerprint
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRODUCT_NAME=sailfish \
    BUILD_FINGERPRINT=google/sailfish/sailfish:8.1.0/OPM4.171019.021.P1/4820305:user/release-keys \
    PRIVATE_BUILD_DESC="sailfish-user 8.1.0 OPM4.171019.021.P1 4820305 release-keys"