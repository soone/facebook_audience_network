
#import <Flutter/Flutter.h>

@interface FacebookBannerAdFactory : NSObject<FlutterPlatformViewFactory>
-(instancetype)initWithMessenger:(NSObject<FlutterBinaryMessenger>*)messenger;
@end
