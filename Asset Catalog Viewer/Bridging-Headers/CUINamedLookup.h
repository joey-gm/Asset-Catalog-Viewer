//
//  CUINamedLookup.h
//  Asset Catalog Viewer
//
//  Created by Joey on 12/6/2021.
//

#import <Foundation/NSObject.h>
#import "CoreGraphics/CoreGraphics.h"

@class CUIRenditionKey;

NS_ASSUME_NONNULL_BEGIN

@interface CUINamedLookup : NSObject

- (instancetype)initWithName:(nullable NSString *)assetName usingRenditionKey:(CUIRenditionKey *)key fromTheme:(unsigned long long)themeIndex NS_DESIGNATED_INITIALIZER;

@end


@interface CUINamedVectorGlyph : CUINamedLookup

- (CGImageRef)rasterizeImageUsingScaleFactor:(double)scale forTargetSize:(struct CGSize)size;

@end

NS_ASSUME_NONNULL_END
