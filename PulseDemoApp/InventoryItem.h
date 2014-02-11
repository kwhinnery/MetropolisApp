//
//  InventoryItem.h
//  PulseDemoApp
//
//  Created by crnorman on 2/9/14.
//  Copyright (c) 2014 IBM MIL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InventoryItem : NSObject
@property (nonatomic)NSString *name;
@property (nonatomic)NSString *description;
@property (nonatomic)BOOL inStock;
@property (nonatomic)NSString *category;
@property (nonatomic)NSArray *sizes;
@property (nonatomic)NSString *img;
@end
