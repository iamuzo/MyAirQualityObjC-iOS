//
//  DVMPollution.h
//  MyAirQualityObjC
//
//  Created by Uzo on 1/29/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//MARK: - Class Declaration
@interface DVMPollution : NSObject

//properties
@property (nonatomic, readonly) NSInteger airQualityIndex;

//designated initializer
-(instancetype)initWith:(NSInteger)aqi;

@end

//MARK: - Convenience Initializer added in JSONConvertable extension
@interface DVMPollution (JSONConvertable)

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
