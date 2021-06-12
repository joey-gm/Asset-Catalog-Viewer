//
//  CUICatalog.h
//  Asset Catalog Viewer
//
//  Created by Joey on 12/6/2021.
//

#import <Foundation/NSObject.h>

@class CUIStructuredThemeStore;

NS_ASSUME_NONNULL_BEGIN

@interface CUICatalog : NSObject

@property(nonatomic) unsigned long long storageRef;
- (CUIStructuredThemeStore *)_themeStore;
- (nullable instancetype)initWithURL:(NSURL *)url error:(NSError **)error NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
