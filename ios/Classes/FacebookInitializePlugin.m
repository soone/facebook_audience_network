
#import "FacebookInitializePlugin.h"
#import <AdSupport/AdSupport.h>

@implementation FacebookInitializePlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {

    NSString *idfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSLog(@"Device AdvertisingIdentifier UUID:%@", idfa);
    
    FacebookInitializePlugin* instance = [[FacebookInitializePlugin alloc] init];
    FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName:@"fb.audience.network.io"
                                                                binaryMessenger:[registrar messenger]];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:@"init"]) {
        result([NSNumber numberWithBool:YES]);
    }else{
        result(FlutterMethodNotImplemented);
    }
}

@end
