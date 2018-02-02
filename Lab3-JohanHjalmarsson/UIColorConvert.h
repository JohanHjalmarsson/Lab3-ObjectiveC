//
//  UIColorConvert.h
//  Lab3-JohanHjalmarsson
//
//  Created by Johan Hjalmarsson on 2018-02-02.
//  Copyright © 2018 Johan Hjalmarsson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (UIColorConvert)

-(UIColor*)colorFromRgbRed:(int)red green:(int)green blue:(int)blue;
-(instancetype)initWithRgbRed:(float)red green:(float)green blue:(float)blue;


@end
