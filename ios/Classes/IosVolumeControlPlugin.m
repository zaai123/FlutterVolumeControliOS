#import "IosVolumeControlPlugin.h"
#import <ios_volume_control/ios_volume_control-Swift.h>

@implementation IosVolumeControlPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftIosVolumeControlPlugin registerWithRegistrar:registrar];
}
@end
