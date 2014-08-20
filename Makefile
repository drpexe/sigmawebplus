# Project settings
SHELL := /bin/bash
WD := $(shell pwd)
PROJECT_DIR := $(WD)/src
VENV := $(WD)/venv
PY := $(VENV)/bin/python
PIP := $(VENV)/bin/pip

# Python for Android settings
PYTHON_FOR_ANDROID := $(WD)/python-for-android
PYTHON_FOR_ANDROID_PACKAGE := $(PYTHON_FOR_ANDROID)/dist/default
PY4A_MODULES := "pyjnius kivy"

# Android SDK setting


# Android settings
APK_PACKAGE := org.drpexe.sigmawebplus
APP_NAME := "SigmaWeb+"
APK_NAME := SigmaWeb+
APK_VERSION := "2.0.0"
APK_ORIENTATION := portrait
APK_ICON := $(PROJECT_DIR)/res/logo-transparent.png
APK_PRESPLASH := $(PROJECT_DIR)/res/logo.png
APK_DEBUG := $(PYTHON_FOR_ANDROID_PACKAGE)/bin/$(APK_NAME)-$(APK_VERSION)-debug.apk
APK_RELEASE := $(PYTHON_FOR_ANDROID_PACKAGE)/bin/$(APK_NAME)-$(APK_VERSION)-release-unsigned.apk
APK_FINAL := $(WD)/release/$(APK_NAME).apk
APK_KEYSTORE := ~/Dropbox/Pessoal/Backup/Android-Keys/org-drpexe-sigmawebplus-release-key.keystore
APK_ALIAS := sigmawebplus
APK_PERMISSIONS = --permission INTERNET


.PHONY: run
run:
	cd $(PROJECT_DIR); \
	$(PY) main.py

.PHONY: build
build:
	source android-sdk.sh; \
	cd $(PYTHON_FOR_ANDROID_PACKAGE); \
	$(PY) ./build.py --package $(APK_PACKAGE) --name $(APP_NAME) --version $(APK_VERSION) --orientation $(APK_ORIENTATION) --icon $(APK_ICON) --presplash $(APK_PRESPLASH) --dir $(PROJECT_DIR) $(APK_PERMISSIONS) --window debug installd

.PHONY: build-release
build-release:
	source android-sdk.sh; \
	cd $(PYTHON_FOR_ANDROID_PACKAGE); \
	$(PY) ./build.py --package $(APK_PACKAGE) --name $(APP_NAME) --version $(APK_VERSION) --orientation $(APK_ORIENTATION) --icon $(APK_ICON) --presplash $(APK_PRESPLASH) --dir $(PROJECT_DIR) $(APK_PERMISSIONS) --window release
	make release-sign

.PHONY: release-sign
release-sign:
	rm -f $(APK_FINAL)
	jarsigner -verbose -sigalg MD5withRSA -digestalg SHA1 -keystore $(APK_KEYSTORE) $(APK_RELEASE) $(APK_ALIAS)
	source android-sdk.sh; \
	zipalign -v 4 $(APK_RELEASE) $(APK_FINAL)

.PHONY: distclean
distclean:
	sudo rm $(VENV) -r -f
	sudo rm python-for-android -r -f

.PHONY: install-deps
install-deps: distclean install-venv install-pipmodules install-py4a
	sudo apt-get install ia32-libs libc6-dev-i386 -y

.PHONY: install-deps-x86
install-deps-x86: distclean install-venv install-pipmodules install-py4a

.PHONY: install
install: build-py4a

.PHONY: logcat
logcat:
	source android-sdk.sh; \
	adb logcat python:I *:S

.PHONY: logcat-all
logcat-all:
	source android-sdk.sh; \
	adb logcat *:I

# Setup Internal

.PHONY: install-venv
install-venv:
	sudo apt-get install python-pip -y
	sudo pip install virtualenv
	virtualenv -p python2.7 --system-site-packages $(VENV)

.PHONY: install-pipmodules
install-pipmodules:
	sudo apt-get install python-setuptools python-pygame python-opengl python-gst0.10 python-enchant gstreamer0.10-plugins-good libgl1-mesa-dev-lts-quantal libgles2-mesa-dev-lts-quantal -y
	sudo apt-get install build-essential patch git-core ccache ant python-pip python-dev -y
	$(PIP) install cython
	$(PIP) install kivy #This is only necessary to run on Desktop

.PHONY: install-py4a
install-py4a:
	git clone https://github.com/drpexe/sigmawebplus-py4a.git python-for-android
	sudo chmod +x android-sdk.sh

.PHONY: build-py4a
build-py4a:
	source android-sdk.sh; \
	source "$(VENV)/bin/activate"; \
	cd $(PYTHON_FOR_ANDROID); \
	./distribute.sh -m $(PY4A_MODULES)
