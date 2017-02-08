GO_EASY_ON_ME = 1
ARCHS = armv7 arm64
SDKVERSION = 9.2

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = CustomFT
CustomFT_FILES = Applications.xm ControlCenter.xm
CustomFT_FRAMEWORKS = UIKit CoreGraphics AudioToolbox
CustomFT_PRIVATE_FRAMEWORKS = SpringBoardServices Preferences
CustomFT_CFLAGS = -fobjc-arc
CustomFT_LIBRARIES = Traverse

BUNDLE_NAME = kCustomFT
kCustomFT_INSTALL_PATH = /Library/Application Support/CustomFT

include $(THEOS)/makefiles/bundle.mk
include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
SUBPROJECTS += traverse
include $(THEOS_MAKE_PATH)/aggregate.mk
