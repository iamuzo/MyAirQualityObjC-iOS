//
//  DVMCityAirQualityController.h
//  MyAirQualityObjC
//
//  Created by Uzo on 1/29/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVMCityAirQuality.h"

NS_ASSUME_NONNULL_BEGIN

@interface DVMCityAirQualityController : NSObject

//accepts no parameters and returns a String
+(NSString *)retrieveAPIKey;

//accepts no parameters and completes with an array of strings
+(void)fetchSupportedCountries:(void (^) (NSArray<NSString *> *_Nullable))completion;

//accepts string parameter that is a country name
//and completes with an array of strings
+(void)fetchSupportedStatesInCountry:(NSString *)country
                          completion:(void (^) (NSArray<NSString *> *_Nullable))completion;

//accepts 2 string parameters; state and country
//and completes with an array of strings
+(void)fetchSupportedCitiesInState:(NSString *)state
                           country:(NSString *)country
                        completion:(void (^) (NSArray<NSString *> *_Nullable))completion;

//accepts 3 string paraments; city, state, and country
//and completes with a DVMCityAirQuality Object
+(void)fetchDataForCity:(NSString *)city
                  state:(NSString *)state
                country:(NSString *)country
             completion:(void (^) (DVMCityAirQuality *_Nullable))compleiton;

@end

NS_ASSUME_NONNULL_END
