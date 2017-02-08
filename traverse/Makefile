GO_EASY_ON_ME = 1
ARCHS = armv7 arm64
SDKVERSION = 9.2

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = traverse
traverse_FILES = $(wildcard *.mm)
traverse_INSTALL_PATH = /Library/PreferenceBundles
traverse_FRAMEWORKS = UIKit
traverse_PRIVATE_FRAMEWORKS = Preferences
traverse_CFLAGS = -fobjc-arc
traverse_LIBRARIES = Traverse

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/traverse.plist$(ECHO_END)
