#import "FacebookAudienceNetworkPlugin.h"
#import "FacebookInitializePlugin.h"
#import "FacebookInterstitialAdPlugin.h"
#import "FacebookBannerAdPlugin.h"

//@interface FacebookAudienceNetworkPlugin ()
//@property(nonatomic, retain) FlutterMethodChannel *channel;
//@end

@implementation FacebookAudienceNetworkPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    [FacebookInitializePlugin registerWithRegistrar: registrar];
    [FacebookInterstitialAdPlugin registerWithRegistrar: registrar];
    [FacebookBannerAdPlugin registerWithRegistrar: registrar];
}

//+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
//    FacebookAudienceNetworkPlugin* instance = [[FacebookAudienceNetworkPlugin alloc] init];
//    instance.channel =
//        [FlutterMethodChannel methodChannelWithName:@"fb.audience.network.io"
//                                    binaryMessenger:[registrar messenger]];
//    [registrar addMethodCallDelegate:instance channel:instance.channel];
  
//    instance.interstitialChannel = [FlutterMethodChannel methodChannelWithName:@"fb.audience.network.io/interstitialAd" binaryMessenger:[registrar messenger]];
//    [registrar addMethodCallDelegate:instance channel:instance.interstitialChannel];
//}

//- (instancetype)init {
//    self = [super init];
//    return self;
//}
//
//- (void)dealloc {
//    [self.channel setMethodCallHandler:nil];
//    self.channel = nil;
//}

//- (void)callInitialize:(FlutterMethodCall *)call result:(FlutterResult)result {
//    return;
//}

//- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
//    if ([call.method isEqualToString:@"init"]) {
//        result([NSNumber numberWithBool:YES]);
//    }else{
//        result(FlutterMethodNotImplemented);
//    }
//}

@end
