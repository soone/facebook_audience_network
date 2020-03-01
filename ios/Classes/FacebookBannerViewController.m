
#import "FacebookBannerViewController.h"
@import FBAudienceNetwork;

@interface FacebookBannerViewController()
@property(nonatomic, retain)FlutterMethodChannel *channel;
@property(nonatomic, retain)NSObject<FlutterBinaryMessenger> *messenger;
@property CGRect frame;
@property int64_t viewId;
@property(nonatomic, retain)NSDictionary *args;
@property(nonatomic, strong)FBAdView *adView;
@property(nonatomic, retain)NSString *placementID;
@end

@implementation FacebookBannerViewController

-(instancetype _Nullable)initWithFrame:(CGRect)frame
      viewIdentifier:(int64_t)viewId
           arguments:(id _Nullable)args
     binaryMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    self.frame = frame;
    self.viewId = viewId;
    self.args = args;
    self.messenger = messenger;
    self.channel = [FlutterMethodChannel methodChannelWithName:[NSString stringWithFormat:@"fb.audience.network.io/bannerAd_%lld", self.viewId] binaryMessenger:self.messenger];
    
    self.placementID = [NSString stringWithString:self.args[@"id"]];
    self.adView = [[FBAdView alloc] initWithPlacementID:self.placementID adSize:[self getBannerSize] rootViewController:self];
    self.adView.delegate = self;
    [self.adView loadAd];
    
    return self;
}

-(void)adViewDidLoad:(FBAdView *)adView {
    NSNumber* isValid = [NSNumber numberWithBool:[self.adView isAdValid]];
    NSDictionary* args = [[NSDictionary alloc] initWithObjectsAndKeys:self.placementID, @"placement_id", isValid, @"invalidated", nil];
    [self.channel invokeMethod:@"loaded" arguments:args];
}

-(void)adViewDidClick:(FBAdView *)adView {
    NSNumber* isValid = [NSNumber numberWithBool:[self.adView isAdValid]];
    NSDictionary* args = [[NSDictionary alloc] initWithObjectsAndKeys:self.placementID, @"placement_id", isValid, @"invalidated", nil];
    [self.channel invokeMethod:@"clicked" arguments:args];
}

-(void)adViewWillLogImpression:(FBAdView *)adView {
    NSNumber* isValid = [NSNumber numberWithBool:[self.adView isAdValid]];
    NSDictionary* args = [[NSDictionary alloc] initWithObjectsAndKeys:self.placementID, @"placement_id", isValid, @"invalidated", nil];
    [self.channel invokeMethod:@"logging_impression" arguments:args];
}

-(void)adViewDidFinishHandlingClick:(FBAdView *)adView {
    NSLog(@"FBAdView adViewDidFinishHandlingClick");
}

- (void)adView:(FBAdView *)adView didFailWithError:(NSError *)error {
    NSLog(@"FBAdView didFailWithError:%@", error.description);
    NSNumber* isValid = [NSNumber numberWithBool:[self.adView isAdValid]];
    NSDictionary* args = [[NSDictionary alloc] initWithObjectsAndKeys:self.placementID, @"placement_id", isValid, @"invalidated", [NSString stringWithFormat:@"%ld", (long)error.code], @"error_code", error.userInfo[@"NSLocalizedDescription"], @"error_message", nil];
    [self.channel invokeMethod:@"error" arguments:args];
}

-(FBAdSize)getBannerSize {
    int64_t height = (int64_t)self.args[@"height"];
    
    if (height >= 250) {
        return kFBAdSizeHeight250Rectangle;
    } else if (height >= 90) {
        return kFBAdSizeHeight90Banner;
    } else {
        return kFBAdSizeHeight50Banner;
    }
}

-(UIView *)view {
    return self.adView;
}

@end
