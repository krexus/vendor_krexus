# For older nexus devices without a vendor partition

# Blobs necessary for media effects
PRODUCT_COPY_FILES +=  \
    $(call my-dir)/../prebuilt/common/vendor/media/LMspeed_508.emd:system/vendor/media/LMspeed_508.emd \
    $(call my-dir)/../prebuilt/common/vendor/media/PFFprec_600.emd:system/vendor/media/PFFprec_600.emd
