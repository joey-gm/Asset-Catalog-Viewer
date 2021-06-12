//
//  CUIThemeRendition.h
//  Asset Catalog Viewer
//
//  Created by Joey on 12/6/2021.
//

#import <Foundation/Foundation.h>
#import "CoreGraphics/CoreGraphics.h"
#import "CUIStructures.h"

NS_ASSUME_NONNULL_BEGIN

@interface CUIThemeRendition : NSObject

@property(readonly, nonatomic) NSData *srcData;
@property(nonatomic) long long type;
- (const struct renditionkeytoken *)key;
- (int)pixelFormat;
- (NSString *)name;
- (struct CGSize)unslicedSize;
- (CGImageRef)unslicedImage;
- (CGImageRef)createImageFromPDFRenditionWithScale:(double)scale;

- (CGColorRef)cgColor;
- (bool)substituteWithSystemColor;
- (NSString *)systemColorName;

- (NSData *)data;
- (NSData *)rawData;
- (NSString *)utiType;

@end

NS_ASSUME_NONNULL_END
