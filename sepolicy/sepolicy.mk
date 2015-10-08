# This policy configuration will be used by all products
# Requires commit on platform/build

BOARD_SEPOLICY_DIRS += \
    vendor/krexus/sepolicy

BOARD_SEPOLICY_UNION += \
    file_contexts \
    shell.te
