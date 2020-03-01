
#import <Flutter/Flutter.h>
@import FBAudienceNetwork;

@interface FacebookBannerViewController : UIViewController<FlutterPlatformView, FBAdViewDelegate>
-(instancetype _Nullable)initWithFrame:(CGRect)frame viewIdentifier:(int64_t)viewId arguments:(id _Nullable)args binaryMessenger:(NSObject<FlutterBinaryMessenger>*_Nonnull)messenger;
@end
