
#import "FacebookBannerAdFactory.h"
#import "FacebookBannerViewController.h"

@interface FacebookBannerAdFactory()
@property(nonatomic, retain) NSObject<FlutterBinaryMessenger> *_messenger;
@end

@implementation FacebookBannerAdFactory

-(instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger {
    self._messenger = messenger;
    return self;
}

-(NSObject<FlutterMessageCodec>*)createArgsCodec {
    return [FlutterStandardMessageCodec sharedInstance];
}

-(nonnull NSObject<FlutterPlatformView>*)createWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args {
    
    FacebookBannerViewController* viewController = [[FacebookBannerViewController alloc] initWithFrame:frame viewIdentifier:viewId arguments:args binaryMessenger:self._messenger];
    
    return viewController;
}

@end
