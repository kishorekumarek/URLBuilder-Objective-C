//
//  RIURLBuilder.h
//  RIStackExchange
//
//  Created by Kishore Kumar Elanchezhiyan on 13/08/16.
//  Copyright © 2016 Madras App Factory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EKURLBuilder : NSObject

@property (nonatomic, strong) NSURLComponents *components;

- (id)objectForKeyedSubscript:(NSString *)key;
- (void)setObject:(id)obj forKeyedSubscript:(NSString *)key;

- (void)setValue:(id)value forParam:(NSString *)param;
- (void)setInteger:(NSInteger)value forParam:(NSString *)param;

+ (EKURLBuilder *)builderWithBase:(NSString *)base;
- (NSURL *) url;
@end
