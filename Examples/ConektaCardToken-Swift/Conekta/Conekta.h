//
//  Conekta.h
//  Conekta
//
//  Created by Julian Ceballos on 10/16/15.
//
//

#ifndef Conekta_h
#define Conekta_h

#import "Token.h"
#import "Card.h"

@interface Conekta : NSObject

@property (nonatomic, retain) NSString *baseURI;
@property (nonatomic, retain) NSString *publicKey;

- (NSString *) deviceFingerprint; 

/* Resources */
- (Card *) Card;
- (Token *) Token;

@end

#endif /* Conekta_h */
