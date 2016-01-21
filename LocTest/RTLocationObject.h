//
//  RTLocationObject.h
//  RiverCondition
//
//  Created by Rita on 15/11/30.
//  Copyright © 2015年 rita. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTLocationObject : NSObject

@property(nonatomic,retain) NSString *xLoc;
@property(nonatomic,retain) NSString *yLoc;
@property(nonatomic,retain) NSError *error;

@end
