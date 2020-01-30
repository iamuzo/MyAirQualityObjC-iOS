//
//  DVMPollution.m
//  MyAirQualityObjC
//
//  Created by Uzo on 1/29/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

#import "DVMPollution.h"

@implementation DVMPollution

- (instancetype)initWith:(NSInteger)aqi
{
    self = [super init];
    
    if (self){
        _airQualityIndex = aqi;
    }
    
    return self;
}

@end

@implementation DVMPollution (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSInteger aqi = [dictionary[@"aquis"] intValue];
    return [self initWith:aqi];
}

@end
