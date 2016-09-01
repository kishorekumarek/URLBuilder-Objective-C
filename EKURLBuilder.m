//
//  RIURLBuilder.m
//  RIStackExchange
//
//  Created by Kishore Kumar Elanchezhiyan on 13/08/16.
//  Copyright © 2016 Madras App Factory. All rights reserved.
//

#import "EKURLBuilder.h"

@interface EKURLBuilder()
@property (nonatomic, strong) NSString *base;
@property (nonatomic, strong) NSMutableDictionary *queryParams;

@end
@implementation EKURLBuilder

+ (EKURLBuilder *)builderWithBase:(NSString *)base
{
    EKURLBuilder * builder = [EKURLBuilder new];
    builder.base = base;
    builder.components = [[NSURLComponents alloc] init];
    builder.queryParams = [NSMutableDictionary dictionary];
    return builder;
}


- (void)setValue:(id)value forParam:(NSString *)param
{
    self[param] = value;
}
- (void)setInteger:(NSInteger)value forParam:(NSString *)param
{
    self[param] = [NSString stringWithFormat:@"%ld", (long)value];
}

- (id)objectForKeyedSubscript:(NSString *)key {
    if(_queryParams[key])
        return _queryParams[key];
    return nil;
}

-(void)setObject:(id)obj forKeyedSubscript:(NSString *)key {
    if(key && obj)
        [ _queryParams setObject:obj forKeyedSubscript:key];
}
+ (NSString *)stringForQueryStringParams:(NSDictionary *)queryStringParams
{
    NSMutableString * queryString = [NSMutableString string];
    
    NSArray * keys = [queryStringParams allKeys];
    for(int i = 0; i < [keys count]; i++)
    {
        if(i > 0)
        {
            [queryString appendString:@"&"];
        }
        NSString * key = [keys objectAtIndex:i];
        NSObject * value = [queryStringParams objectForKey:key];
        if([value isKindOfClass:[NSString class]])
        {
            NSString * valueString = (NSString *)value;
            valueString = [valueString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            [queryString appendFormat:@"%@=%@", key, valueString];
        }
        else if([value isKindOfClass:[NSNumber class]])
        {
            NSNumber * valueNumber = (NSNumber *)value;
            NSString * valueString = [valueNumber stringValue];
            [queryString appendFormat:@"%@=%@", key, valueString];
        }
        else
        {
            NSLog(@"Problem Log 1");
        }
    }
    return queryString;
}
- (NSString *)urlStringWithBase
{
    if(self.base == nil)
    {
        return nil;
    }
    NSString * queryString = [EKURLBuilder stringForQueryStringParams:_queryParams];
    NSMutableString * urlString = [NSMutableString stringWithFormat:@"%@?%@", self.base, queryString];
    return urlString;
}
- (NSURL *)urlWithComponets {
    if (!self.components.URL) {
        return nil;
    }
    NSString * queryString = [EKURLBuilder stringForQueryStringParams:_queryParams];
    self.components.query = queryString;
    return [self.components URL];
}
- (NSURL *) url {
    NSURL * url = nil;
    if(!self.components.URL){
        url = [self urlWithComponets];
    }
    else {
        NSString * urlString = [self urlStringWithBase];
        urlString =  [urlString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if (urlString)
            url = [NSURL URLWithString:urlString];
    }
    return url;
}



@end

