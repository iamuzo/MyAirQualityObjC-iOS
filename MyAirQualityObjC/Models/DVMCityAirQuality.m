//
//  DVMCityAirQuality.m
//  MyAirQualityObjC
//
//  Created by Uzo on 1/29/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

#import "DVMCityAirQuality.h"
#import "DVMWeather.h"
#import "DVMPollution.h"

@implementation DVMCityAirQuality

- (instancetype)initWithCity:(NSString *)city state:(NSString *)state country:(NSString *)country weather:(DVMWeather *)weather pollution:(DVMPollution *)pollution
{
    self = [super init];
    
    if (self) {
        _city = city;
        _state = state;
        _country = country;
        _weather = weather;
        _pollution = pollution;
    }
    
    return self;
}
@end

@implementation DVMCityAirQuality (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *city = dictionary[@"city"];
    NSString *state = dictionary[@"state"];
    NSString *country = dictionary[@"country"];
    
    // within the passed in dictionary, there exists a dictionary
    // whose key is `current`. This dictionary holds the information
    // we to initialize DVMWeather and DVMPollution
    NSDictionary *currentDictionary = dictionary[@"current"];
    
    //grab the weather dictionary that exists within currentDictionary
    //and use initWithDictionary initializer for DVMWeather object to
    //create a DVMWeather Object
    DVMWeather *weather = [[DVMWeather alloc] initWithDictionary:currentDictionary[@"weather"]];
    
    
    //grab the pollution dictionary that exists within currentDictionay
    //and use initWithDictionary initializer for DVMPollution object to
    //create a DVMPollution Object
    DVMPollution *pollution = [[DVMPollution alloc] initWithDictionary:currentDictionary[@"pollution"]];
    
    // Return an instance of the class by calling the
    // designated initializer and passing in the values
    // pulled out from the dictionary
    return [self initWithCity:city state:state country:country weather:weather pollution:pollution];
    
}

@end
