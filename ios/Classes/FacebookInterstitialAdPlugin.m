
#import "FacebookInterstitialAdPlugin.h"
@import FBAudienceNetwork;

@interface FacebookInterstitialAdPlugin()
@property(nonatomic, retain) FBInterstitialAd *interstitialAd;
@property(nonatomic, retain) NSString *placementID;
@property(nonatomic, retain) FlutterMethodChannel *channel;
@end

@implementation FacebookInterstitialAdPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FacebookInterstitialAdPlugin* instance = [[FacebookInterstitialAdPlugin alloc] init];
    instance.channel = [FlutterMethodChannel methodChannelWithName:@"fb.audience.network.io/interstitialAd"
                                                                binaryMessenger:[registrar messenger]];
    [registrar addMethodCallDelegate:instance channel:instance.channel];
    
}

+ (UIViewController *)rootViewController {
    return [UIApplication sharedApplication].delegate.window.rootViewController;
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    if ([call.method isEqualToString:@"loadInterstitialAd"]) {
        
        self.placementID = (NSString *)call.arguments[@"id"];
        self.interstitialAd = [[FBInterstitialAd alloc] initWithPlacementID:self.placementID];
        self.interstitialAd.delegate = self;
        [self.interstitialAd loadAd];
        result([NSNumber numberWithBool:YES]);
        
    } else if ([call.method isEqualToString:@"showInterstitialAd"]) {
        
        if (self.interstitialAd && self.interstitialAd.isAdValid) {
            result([NSNumber numberWithBool:[self.interstitialAd showAdFromRootViewController:[FacebookInterstitialAdPlugin rootViewController]]]);
        } else {
            NSString *message = [NSString stringWithFormat:@"show failed, the specified ad was not loaded id=%@",
                                 self.placementID];
            result([FlutterError errorWithCode:@"ad_not_loaded" message:message details:nil]);
        }
        
    } else if ([call.method isEqualToString:@"destroyInterstitialAd"]) {
        self.interstitialAd = nil;
        result([NSNumber numberWithBool:YES]);
    }else{
        result(FlutterMethodNotImplemented);
    }
}

- (void)interstitialAdDidClose:(FBInterstitialAd *)interstitialAd {
    NSNumber* isValid = [NSNumber numberWithBool:[self.interstitialAd isAdValid]];
    NSDictionary* args = [[NSDictionary alloc] initWithObjectsAndKeys:self.placementID, @"placement_id", isValid, @"invalidated", nil];
    [self.channel invokeMethod:@"dismissed" arguments:args];
}

- (void)interstitialAd:(FBInterstitialAd *)interstitialAd didFailWithError:(NSError *)error {
    NSLog(@"FBInterstitialAd didFailWithError:%@", error.description);
    NSNumber* isValid = [NSNumber numberWithBool:[self.interstitialAd isAdValid]];
    NSDictionary* args = [[NSDictionary alloc] initWithObjectsAndKeys:self.placementID, @"placement_id", isValid, @"invalidated", [NSString stringWithFormat:@"%ld", (long)error.code], @"error_code", error.userInfo[@"NSLocalizedDescription"], @"error_message", nil];
    [self.channel invokeMethod:@"error" arguments:args];
}

- (void)interstitialAdDidLoad:(FBInterstitialAd *)interstitialAd {
    NSNumber* isValid = [NSNumber numberWithBool:[self.interstitialAd isAdValid]];
    NSDictionary* args = [[NSDictionary alloc] initWithObjectsAndKeys:self.placementID, @"placement_id", isValid, @"invalidated", nil];
    [self.channel invokeMethod:@"loaded" arguments:args];
}

- (void)interstitialAdDidClick:(FBInterstitialAd *)interstitialAd {
    NSNumber* isValid = [NSNumber numberWithBool:[self.interstitialAd isAdValid]];
    NSDictionary* args = [[NSDictionary alloc] initWithObjectsAndKeys:self.placementID, @"placement_id", isValid, @"invalidated", nil];
    [self.channel invokeMethod:@"clicked" arguments:args];
}

- (void)interstitialAdWillLogImpression:(FBInterstitialAd *)interstitialAd{
    NSNumber* isValid = [NSNumber numberWithBool:[self.interstitialAd isAdValid]];
    NSDictionary* args = [[NSDictionary alloc] initWithObjectsAndKeys:self.placementID, @"placement_id", isValid, @"invalidated", nil];
    [self.channel invokeMethod:@"logging_impression" arguments:args];
}

@end
