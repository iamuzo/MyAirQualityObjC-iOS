//
//  DVMCityAirQuality.h
//  MyAirQualityObjC
//
//  Created by Uzo on 1/29/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVMWeather.h"
#import "DVMPollution.h"

NS_ASSUME_NONNULL_BEGIN

//MARK: - Class Declaration
@interface DVMCityAirQuality : NSObject

//Properties
@property (nonatomic, copy, readonly) NSString * city;
@property (nonatomic, copy, readonly) NSString * state;
@property (nonatomic, copy, readonly) NSString * country;
@property (nonatomic, copy, readonly) DVMWeather * weather;
@property (nonatomic, copy, readonly) DVMPollution * pollution;

//Designated Initializer
-(instancetype)initWithCity:(NSString *)city
                       state:(NSString *)state
                     country:(NSString *)country
                    weather:(DVMWeather *)weather
                  pollution:(DVMPollution *)pollution;

@end

//MARK: - Convenience Initializer added in JSONConvertable extension
@interface DVMCityAirQuality (JSONConvertable)

///convenience initializer
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
