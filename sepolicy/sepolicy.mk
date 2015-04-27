#
# This policy configuration will be used by all products that
#

BOARD_SEPOLICY_DIRS += \
    vendor/icarus/sepolicy

BOARD_SEPOLICY_UNION += \
    file_contexts \
    shell.te
