//
//  CUIStructures.h
//  Asset Catalog Viewer
//
//  Created by Joey on 12/6/2021.
//

struct renditionkeytoken {
    unsigned short identifier;
    unsigned short value;
};

struct renditionkeyfmt {
    unsigned int tag;
    unsigned int version;
    unsigned int maximumRenditionKeyTokenCount;
    unsigned int renditionKeyTokens[0];
};
