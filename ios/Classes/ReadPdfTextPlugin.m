#import "ReadPdfTextPlugin.h"
#if __has_include(<read_pdf_text/read_pdf_text-Swift.h>)
#import <read_pdf_text/read_pdf_text-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "read_pdf_text-Swift.h"
#endif

@implementation ReadPdfTextPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftReadPdfTextPlugin registerWithRegistrar:registrar];
}
@end
