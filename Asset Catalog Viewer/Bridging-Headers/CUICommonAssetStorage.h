//
//  CUICommonAssetStorage.h
//  Asset Catalog Viewer
//
//  Created by Joey on 12/6/2021.
//

#import <Foundation/NSObject.h>

@class CUIRenditionKey;

NS_ASSUME_NONNULL_BEGIN

@interface CUICommonAssetStorage : NSObject

- (NSArray<CUIRenditionKey *> *)allAssetKeys;
- (const struct renditionkeyfmt*)keyFormat;
- (NSData *)keyFormatData;
- (long long)maximumRenditionKeyTokenCount;

@end

NS_ASSUME_NONNULL_END
