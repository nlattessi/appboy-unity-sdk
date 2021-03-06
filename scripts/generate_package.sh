#!/bin/bash

APPBOY_IOS_SDK="AppboyKit"
APPBOY_IOS_UI="AppboyUI"
SD_WEB_IMAGE="SDWebImage.framework"
FL_ANIMATED_IMAGE="FLAnimatedImage.framework"
PROJECT_ROOT=$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd )
LIBRARIES_PATH=$PROJECT_ROOT/Libraries
IOS_PLUGINS_PATH=$PROJECT_ROOT/Assets/Plugins/iOS

UNITY_PATH="/Applications/Unity/Unity.app/Contents/MacOS/Unity"
# 64 bit Windows - "C:\Program Files\Unity\Editor\Unity.exe"
# 32 bit Windows - "C:\Program Files (x86)\Unity\Editor\Unity.exe"

EXCLUDE_DEPENDENCIES=false # Include dependencies from the Appboy iOS SDK in Unity package
if [[ $1 = "--nodeps" ]]; then
  EXCLUDE_DEPENDENCIES=true
fi

echo "Deleting iOS libraries from Assets/Plugins/iOS/"
[ -e $IOS_PLUGINS_PATH/$APPBOY_IOS_SDK ] && rm -rf $IOS_PLUGINS_PATH/$APPBOY_IOS_SDK*
[ -e $IOS_PLUGINS_PATH/$APPBOY_IOS_UI ] && rm -rf $IOS_PLUGINS_PATH/$APPBOY_IOS_UI*
[ -e $IOS_PLUGINS_PATH/$SD_WEB_IMAGE ] && rm -rf $IOS_PLUGINS_PATH/$SD_WEB_IMAGE*
[ -e $IOS_PLUGINS_PATH/$FL_ANIMATED_IMAGE ] && rm -rf $IOS_PLUGINS_PATH/$FL_ANIMATED_IMAGE*


echo "Copying iOS libraries from Libraries/ to Assets/Plugins/iOS/"
cp -R $LIBRARIES_PATH/$APPBOY_IOS_SDK/ $IOS_PLUGINS_PATH/$APPBOY_IOS_SDK/ &
cp -R $LIBRARIES_PATH/$APPBOY_IOS_UI/ $IOS_PLUGINS_PATH/$APPBOY_IOS_UI/ &
if [ "$EXCLUDE_DEPENDENCIES" = false ]; then
  cp -R $LIBRARIES_PATH/$SD_WEB_IMAGE $IOS_PLUGINS_PATH/$SD_WEB_IMAGE
  cp -R $LIBRARIES_PATH/$FL_ANIMATED_IMAGE $IOS_PLUGINS_PATH/$FL_ANIMATED_IMAGE
fi &
wait

echo "Generating Unity package..."
if [ "$EXCLUDE_DEPENDENCIES" = false ]; then
	$UNITY_PATH -batchmode -nographics -projectPath $PROJECT_ROOT -executeMethod Appboy.Editor.Build.ExportPackage -quit && echo "Unity Package exported to $PROJECT_ROOT/unity-package/Appboy.unity-package" || echo "Failed to export package"
else
	$UNITY_PATH -batchmode -nographics -projectPath $PROJECT_ROOT -executeMethod Appboy.Editor.Build.ExportPackageWithoutDependencies -quit && echo "Unity Package exported to $PROJECT_ROOT/unity-package/Appboy-nodeps.unity-package" || echo "Failed to export package"
fi
