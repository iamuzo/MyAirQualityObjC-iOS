//
//  DVMCityAirQualityController.m
//  MyAirQualityObjC
//
//  Created by Uzo on 1/29/20.
//  Copyright © 2020 Uzo. All rights reserved.
//

#import "DVMCityAirQualityController.h"

@implementation DVMCityAirQualityController

// MARK: - Properties
static NSString *const baseURLAsString = @"https://api.airvisual.com/";
static NSString *const versionComponent = @"v2";
static NSString *const countryComponent = @"countries";
static NSString *const stateComponent = @"states";
static NSString *const cityComponent = @"cities";
static NSString *const cityDetailsComponent = @"city";

+ (NSString *)retrieveAPIKey
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"AuthKeys" ofType:@"plist"];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSString *apikey = [[NSString alloc] init];
    apikey = dict[@"airvisual"];
    return apikey;
}

+ (void)fetchSupportedCountries:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL * url = [NSURL URLWithString:baseURLAsString];
    NSURL * versionURL = [url URLByAppendingPathComponent:versionComponent];
    NSURL *countryURL = [versionURL URLByAppendingPathComponent:countryComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value: [self retrieveAPIKey]];
    
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:countryURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    NSLog(@"this is the url for fetching countries: %@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (data)
        {
            // data sent back when we request the list of supported countries
            // is dictionary that contains 2 keys status and data looks like:
            //["status" : "success", "data" : {}]
            NSDictionary *dataReturnedAsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            // want the value of the key data so grab it
            NSDictionary *dataDict = dataReturnedAsDictionary[@"data"];
        
            // create holder array for countries
            NSMutableArray *countries = [NSMutableArray new];
        
            //we are going to loop through the dataDict
            //and when we are inside the loop/function
            //we are going to temporarily assign each item
            //in dataDictionary to a countryDict pointer
            for (NSDictionary *countryDict in dataDict)
            {
                // allocate memory for a string whose pointer will be named country
                NSString *country = [[NSString alloc]init];
            
                // set that country pointer equal to the result of
                // value of the key "country" in countryDict
                country = countryDict[@"country"];
            
                //the above two lines in 1 step
                //NSString *country = [[NSString alloc] initWithString:countryDict[@"country"]];
            
                [countries addObject:country];
            }
            completion(countries);
        }
    }] resume];
}

+ (void)fetchSupportedStatesInCountry:(NSString *)country
                           completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL * url = [NSURL URLWithString:baseURLAsString];
    NSURL * versionURL = [url URLByAppendingPathComponent:versionComponent];
    NSURL * stateURL = [versionURL URLByAppendingPathComponent:stateComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem * countryKeyQuery = [[NSURLQueryItem alloc]
                                        initWithName:@"country" value:country];
    [queryItems addObject:countryKeyQuery];
    
    NSURLQueryItem * apiKeyQuery = [[NSURLQueryItem alloc]
                                    initWithName:@"key" value: [self retrieveAPIKey]];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc]
                                      initWithURL:stateURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    NSLog(@"this is the url for fetching countries: %@", finalURL);
    
    [[[NSURLSession sharedSession]
      dataTaskWithURL:finalURL
      completionHandler:^(NSData * _Nullable data,
                          NSURLResponse * _Nullable response,
                          NSError * _Nullable error){
        if (error) {
            NSLog(@"There was an error in %s: %@, %@",
                  __PRETTY_FUNCTION__,
                  error, [error localizedDescription]);
            completion(nil);
            return;
        }
        
        if (response) {
            NSLog(@"%@", response);
        }
        
        if (data) {
            // data sent back when we request the list
            // of supported states in a country is a
            // dictionary that contains 2 keys called
            // status and data, and it looks like:
            // ["status" : "success", "data" : {}]
            NSDictionary *dataReturnedAsDictionary = [NSJSONSerialization
                                                      JSONObjectWithData:data
                                                      options:0 error:&error];
            
            // want the value of the key data so grab it
            NSDictionary *dataDict = dataReturnedAsDictionary[@"data"];
            
            // create holder array for states
            NSMutableArray *states = [NSMutableArray new];
            
            
                //we are going to loop through the dataDict
                //and when we are inside the loop/function
                //we are going to temporarily assign each item
                //in dataDictionary to a stateDict pointer
            for (NSDictionary *stateDict in dataDict)
            {
                // allocate memory for a string whose pointer will be named state
                NSString *state = [[NSString alloc]init];
            
                // set state pointer equal to the result of
                // value of the key "state" in countryDict
                state = stateDict[@"state"];
            
                //the above two lines in 1 step
                //NSString *state = [[NSString alloc] initWithString:stateDict[@"state"]];
            
                [states addObject:state];
            }
            completion(states);
        }
    }] resume];
}

+ (void)fetchSupportedCitiesInState:(NSString *)state
                            country:(NSString *)country
                         completion:(void (^)(NSArray<NSString *> * _Nullable))completion
{
    NSURL *url = [NSURL URLWithString:baseURLAsString];
    NSURL *versionURL = [url URLByAppendingPathComponent:versionComponent];
    NSURL *citiesURL = [versionURL URLByAppendingPathComponent:cityComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *stateKeyQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    [queryItems addObject:stateKeyQuery];
    
    NSURLQueryItem *countryKeyQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    [queryItems addObject:countryKeyQuery];
    
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value: [self retrieveAPIKey]];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:citiesURL resolvingAgainstBaseURL:true];

    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    NSLog(@"this is the url for fetching supported cities in state: %@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        
        if (response) {
            NSLog(@"%@", response);
        }
        
        if (data) {
            // data sent back when we request the
            // list of supported cities in a state
            // is dictionary that contains 2 keys:
            // status and data and looks like:
            //["status" : "success", "data" : {}]
            NSDictionary *dataReturnedAsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            // want the value of the key data so grab it
            NSDictionary *dataDict = dataReturnedAsDictionary[@"data"];
            
            // create holder array for cites
            NSMutableArray *cities = [NSMutableArray new];
            
            
                //we are going to loop through the dataDict
                //and when we are inside the loop/function
                //we are going to temporarily assign each item
                //in dataDictionary to a stateDict pointer
            for (NSDictionary *stateDict in dataDict)
            {
                // allocate memory for a string whose pointer will be named state
                NSString *city = [[NSString alloc]init];
            
                // set state pointer equal to the result of
                // value of the key "city" in stateDict
                city = stateDict[@"city"];
            
                //the above two lines in 1 step
                //NSString *city = [[NSString alloc] initWithString:stateDict[@"city"]];
            
                [cities addObject:city];
            }
            completion(cities);
        }
    }] resume];
}

+ (void)fetchDataForCity:(NSString *)city
                   state:(NSString *)state
                 country:(NSString *)country
              completion:(void (^)(DVMCityAirQuality * _Nullable))completion
{
    NSURL *url = [NSURL URLWithString:baseURLAsString];
    NSURL *versionURL = [url URLByAppendingPathComponent:versionComponent];
    NSURL *cityDetailsURL = [versionURL URLByAppendingPathComponent:cityDetailsComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];

    NSURLQueryItem *cityKeyQuery = [[NSURLQueryItem alloc] initWithName:@"city" value:state];
    [queryItems addObject:cityKeyQuery];
    
    NSURLQueryItem *stateKeyQuery = [[NSURLQueryItem alloc] initWithName:@"state" value:state];
    [queryItems addObject:stateKeyQuery];
    
    NSURLQueryItem *countryKeyQuery = [[NSURLQueryItem alloc] initWithName:@"country" value:country];
    [queryItems addObject:countryKeyQuery];
    
    NSURLQueryItem *apiKeyQuery = [[NSURLQueryItem alloc] initWithName:@"key" value: [self retrieveAPIKey]];
    [queryItems addObject:apiKeyQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithURL:cityDetailsURL resolvingAgainstBaseURL:true];

    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    NSLog(@"this is the url for fetching specific city data: %@", finalURL);
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"There was an error in %s: %@, %@", __PRETTY_FUNCTION__, error, [error localizedDescription]);
            completion(nil);
            return;
        }
        
        if (response) {
             NSLog(@"%@", response);
        }
        
        if (data) {
            NSDictionary *dataReturnedAsDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            
            // want the value of the key data so grab it
            NSDictionary *dataDict = dataReturnedAsDictionary[@"data"];
            
            //dataDict contains all the information we need so init
            DVMCityAirQuality *cityAirQualityInformation = [[DVMCityAirQuality alloc] initWithDictionary:dataDict];
            completion(cityAirQualityInformation);
        }
    }] resume];
}

@end
