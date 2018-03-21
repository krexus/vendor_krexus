# Inherit common stuff
$(call inherit-product, vendor/krexus/config/common.mk)
$(call inherit-product, vendor/krexus/config/common_apn.mk)

# Telephony
PRODUCT_PACKAGES += \
    Stk
