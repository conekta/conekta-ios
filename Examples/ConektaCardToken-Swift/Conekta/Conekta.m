//
//  Conekta.m
//  Conekta
//
//  Created by Julian Ceballos on 10/16/15.
//
//

#import <Foundation/Foundation.h>
#import "Conekta.h"


@implementation Conekta

- (id) init
{
    [self setBaseURI:@"https://api.conekta.io"];
    return self;
}

- (NSString *) deviceFingerprint
{
    NSString *uuid = [[NSUUID UUID] UUIDString];
    return [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

- (id) populate: (id) class
{
    [class setBaseURI:[self baseURI]];
    [class setPublicKey:[self publicKey]];
    [class setDeviceFingerprint:[self deviceFingerprint]];
    return class;
}

- (Card *) Card
{
    Card *card = [[Card alloc] init];
    return [self populate:card];
}

- (Token *) Token
{
    Token *token = [[Token alloc] init];
    return [self populate:token];
}

@end

