
#import "FacebookBannerAdPlugin.h"
#import "FacebookBannerAdFactory.h"

@implementation FacebookBannerAdPlugin

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
    FacebookBannerAdFactory* factory = [[FacebookBannerAdFactory alloc] initWithMessenger:registrar.messenger];
    [registrar registerViewFactory:factory withId:@"fb.audience.network.io/bannerAd"];
}

@end
