//
//  CUIRenditionKey.h
//  Asset Catalog Viewer
//
//  Created by Joey on 12/6/2021.
//

#import <Foundation/NSObject.h>
#import "CUIStructures.h"

NS_ASSUME_NONNULL_BEGIN

@interface CUIRenditionKey : NSObject <NSCopying, NSCoding>

@property(nonatomic) long long themeGlyphWeight;
@property(nonatomic) long long themeGlyphSize;
@property(nonatomic) long long themeDeploymentTarget;
@property(nonatomic) long long themeDisplayGamut;
@property(nonatomic) long long themeLocalization;
@property(nonatomic) long long themeAppearance;
@property(nonatomic) long long themeIdentifier;
@property(nonatomic) long long themeGraphicsClass;
@property(nonatomic) long long themeMemoryClass;
@property(nonatomic) long long themeSizeClassVertical;
@property(nonatomic) long long themeSizeClassHorizontal;
@property(nonatomic) long long themeSubtype;
@property(nonatomic) long long themeIdiom;
@property(nonatomic) long long themeScale;
@property(nonatomic) long long themeLayer;
@property(nonatomic) long long themePresentationState;
@property(nonatomic) long long themePreviousState;
@property(nonatomic) long long themeState;
@property(nonatomic) long long themeDimension2;
@property(nonatomic) long long themeDimension1;
@property(nonatomic) long long themePreviousValue;
@property(nonatomic) long long themeValue;
@property(nonatomic) long long themeDirection;
@property(nonatomic) long long themeSize;
@property(nonatomic) long long themePart;
@property(nonatomic) long long themeElement;
- (const struct renditionkeytoken *)keyList;
- (instancetype)initWithKeyList:(const struct renditionkeytoken *)keyList NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
