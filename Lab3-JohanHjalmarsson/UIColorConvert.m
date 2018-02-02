//
//  UIColorConvert.m
//  Lab3-JohanHjalmarsson
//
//  Created by Johan Hjalmarsson on 2018-02-02.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

#import "UIColorConvert.h"

@implementation UIColor (UIColorConvert)

-(instancetype)initWithRgbRed:(float)red green:(float)green blue:(float)blue {
    self = [super init];
    if(self) {
        float redFloat = red/255.0f;
        float greenFloat = green/255.0f;
        float blueFloat = blue/255.0f;
        self = [UIColor colorWithRed:redFloat green:greenFloat blue:blueFloat alpha:1];
    }
    return self;
}

-(UIColor*)colorFromRgbRed:(int)red green:(int)green blue:(int)blue {
    return nil;
}

@end
