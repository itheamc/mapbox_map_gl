#import "MapboxMapGlPlugin.h"
#if __has_include(<mapbox_map_gl/mapbox_map_gl-Swift.h>)
#import <mapbox_map_gl/mapbox_map_gl-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "mapbox_map_gl-Swift.h"
#endif

@implementation MapboxMapGlPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftMapboxMapGlPlugin registerWithRegistrar:registrar];
}
@end
