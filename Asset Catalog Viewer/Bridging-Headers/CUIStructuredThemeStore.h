//
//  CUIStructuredThemeStore.h
//  Asset Catalog Viewer
//
//  Created by Joey on 12/6/2021.
//

#import <Foundation/NSObject.h>
#import "CUIStructures.h"

@class CUICommonAssetStorage, CUIThemeRendition;

NS_ASSUME_NONNULL_BEGIN

@interface CUIStructuredThemeStore : NSObject

- (CUICommonAssetStorage *)store;
- (NSDictionary<NSString *, NSNumber *> *)localizations;
- (NSDictionary<NSString *, NSNumber *> *)appearances;
- (nullable CUIThemeRendition *)renditionWithKey:(const struct renditionkeytoken *)arg1;
- (nullable NSString *)renditionNameForKeyList:(const struct renditionkeytoken *)arg1;
- (instancetype)initWithURL:(NSURL *)url;
- (instancetype)initWithPath:(NSString *)path NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
