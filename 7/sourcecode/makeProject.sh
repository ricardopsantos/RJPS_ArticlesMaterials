#!/bin/bash

clear

#xcodegen -s ./XcodeGen/project.yml -p ./ 
#open GoodToGo.xcodeproj
#cd XcodeGen
#xcodegen dump --type graphviz --file ../Documents/Graph.viz
#xcodegen dump --type json --file ../Documents/Graph.json
#exit 

displayCompilerInfo() {
	printf "\n"
	printf "\n"
	echo -n "### Current Compiler"
	printf "\n"
	eval xcrun swift -version
	eval xcode-select --print-path
}

carthageClean() {
	echo 'Carthage clean'
	rm -rf Carthage/Build
	rm -rf Carthage/Checkouts
}

carthageBuild() {

	printf "\n"
	printf "\n"
	echo 'Carthage Xcode 11 build'
	
	carthageClean

    carthage update --platform iOS
}

#
# https://github.com/Carthage/Carthage/issues/3019
#

carthageBuildXcode12() {

	printf "\n"
	printf "\n"

	echo 'Carthage Xcode 12 build'
	
	carthageClean
	
    set -euo pipefail

    xcconfig=$(mktemp /tmp/static.xcconfig.XXXXXX)
    trap 'rm -f "$xcconfig"' INT TERM HUP EXIT

    # For Xcode 12 make sure EXCLUDED_ARCHS is set to arm architectures otherwise
    # the build will fail on lipo due to duplicate architectures.
    # Go to "Build Settings" -> "Architectures" -> "Excluded Architectures" and add "arm64"

    CURRENT_XCODE_VERSION=$(xcodebuild -version | grep "Build version" | cut -d' ' -f3)
    echo "EXCLUDED_ARCHS__EFFECTIVE_PLATFORM_SUFFIX_simulator__NATIVE_ARCH_64_BIT_x86_64__XCODE_1200__BUILD_$CURRENT_XCODE_VERSION = arm64 arm64e armv7 armv7s armv6 armv8" >> $xcconfig

    echo 'EXCLUDED_ARCHS__EFFECTIVE_PLATFORM_SUFFIX_simulator__NATIVE_ARCH_64_BIT_x86_64__XCODE_1200 = $(EXCLUDED_ARCHS__EFFECTIVE_PLATFORM_SUFFIX_simulator__NATIVE_ARCH_64_BIT_x86_64__XCODE_1200__BUILD_$(XCODE_PRODUCT_BUILD_VERSION))' >> $xcconfig
    echo 'EXCLUDED_ARCHS = $(inherited) $(EXCLUDED_ARCHS__EFFECTIVE_PLATFORM_SUFFIX_$(EFFECTIVE_PLATFORM_SUFFIX)__NATIVE_ARCH_64_BIT_$(NATIVE_ARCH_64_BIT)__XCODE_$(XCODE_VERSION_MAJOR))' >> $xcconfig

    export XCODE_XCCONFIG_FILE="$xcconfig"

    echo $xcconfig

	# Will do code Checkout inside Carthage/Checking folder and build code  
	# intro Carthage/Build folder
    #carthage update "$@" --platform iOS # --verbose
    carthage update --platform iOS #"$@" --platform iOS --verbose

    #carthage build "$@" --platform iOS # --verbose # Firebase


    # carthage update --platform iOS --no-use-binaries
    # carthage build --platform iOS --cache-builds --no-use-binaries --verbose

}

################################################################################

echo "### Brew"
echo " [1] : Install"
echo " [2] : Update"
echo " [3] : Skip"
echo -n "Option? "
read option
case $option in
    [1] ) /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" ;;
    [2] ) eval brew update ;;
   *) echo "Ignored...."
;;
esac

################################################################################

printf "\n"

echo "### Carthage"
echo " [1] : Install"
echo " [2] : Upgrade"
echo " [3] : No/Skip"
echo -n "Option? "
read option
case $option in
    [1] ) brew install carthage ;;
    [2] ) brew upgrade carthage ;;
   *) echo "Ignored...."
;;
esac

################################################################################

printf "\n"

echo "### Xcodegen"
echo " [1] : Install"
echo " [2] : Upgrade"
echo " [3] : No/Skip"
echo -n "Option? "
read option
case $option in
    [1] ) brew install xcodegen ;;
    [2] ) brew upgrade xcodegen ;;
   *) echo "Ignored...."
;;
esac

################################################################################

displayCompilerInfo

################################################################################

printf "\n"
printf "\n"

echo "### Change Compiler?"
echo " [1] : Xcode current"
echo " [2] : Xcode Version 12.0.1"
echo " [3] : Xcode Version 11.4"
echo " [4] : Xcode Version 10.3"
echo " [5] : No/Skip"
printf "\n"
echo -n "Option? "
read option
case $option in
    [1] ) sudo xcode-select --switch "/Applications/Xcode.app/Contents/Developer" ;;
    [2] ) sudo xcode-select --switch "/Applications/Xcode_12.0.1.app/Contents/Developer" ;;
    [3] ) sudo xcode-select --switch "/Applications/Xcode_11.4.app/Contents/Developer" ;;
    [4] ) sudo xcode-select --switch "/Applications/Xcode_10.3.app/Contents/Developer" ;;
   *) echo "Ignored...."
;;
esac

################################################################################

displayCompilerInfo

################################################################################

printf "\n"
printf "\n"

echo "### Perform carthage build?"
echo " [1] : Build for <= Xcode 11"
echo " [2] : Build for >= Xcode 12"
echo " [3] : No/Skip"
printf "\n"
echo -n "Option: "
read option
case $option in
    [1] ) carthageBuild ;;
    [2] ) carthageBuildXcode12 ;;
   *) echo "Ignored...."
;;
esac

################################################################################

printf "\n"
printf "\n"

echo "### Perform Xcodegen?"
echo " [1] : Yes"
echo " [2] : No/Skip"
echo -n "Option? "
read option
case $option in
    [1] ) xcodegen -s ./XcodeGen/project.yml -p ./ ;;
   *) echo "Ignored...."
;;
esac

open GoodToGo.xcodeproj
cd XcodeGen
xcodegen dump --type graphviz --file ../Documents/Graph.viz
xcodegen dump --type json --file ../Documents/Graph.json

echo " ╔═══════════════════════╗"
echo " ║ Done! You're all set! ║"
echo " ╚═══════════════════════╝"
