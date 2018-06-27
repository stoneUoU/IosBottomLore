//
//  WeakProxy.h
//  GCDTest
//
//  Created by Stone on 2018/6/25.
//  Copyright © 2018年 com.youlu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STWeakProxy : NSProxy

@property (nullable, nonatomic, weak, readonly) id target;
/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
- (instancetype)initWithTarget:(id)target;

/**
 Creates a new weak proxy for target.
 
 @param target Target object.
 
 @return A new proxy object.
 */
+ (instancetype)proxyWithTarget:(id)target;

@end
@end
