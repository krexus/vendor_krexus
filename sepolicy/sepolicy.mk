#
# This policy configuration will be used by all products that
#

BOARD_SEPOLICY_DIRS += \
    vendor/krexus/sepolicy

BOARD_SEPOLICY_UNION += \
    file_contexts \
    shell.te
