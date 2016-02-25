# For older nexus devices without a vendor partition

# Blobs necessary for media effects
PRODUCT_COPY_FILES +=  \
    vendor/krexus/prebuilt/common/vendor/media/LMspeed_508.emd:system/vendor/media/LMspeed_508.emd \
    vendor/krexus/prebuilt/common/vendor/media/PFFprec_600.emd:system/vendor/media/PFFprec_600.emd

# Layers Backup
PRODUCT_COPY_FILES += \
    vendor/krexus/prebuilt/common/addon.d/71-layers.sh:system/addon.d/71-layers.sh

