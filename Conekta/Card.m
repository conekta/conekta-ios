#import "Card.h"
#import <Security/Security.h>

@implementation Card

// Clave pública en formato PEM
NSString *const kPublicKeyPEM = @"-----BEGIN PUBLIC KEY-----\nMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjet2Jm4iPJTqDlW64tEG\nI9/dJTJAcn3OQdHrEwNXCz0/Rewqcv/Hm+V0klsUiS9h2W5CLC42q6wGhtl9Buu5\nvefuLVyxc8klEEjrSz/5AgfZ4HvzatbVX0KQhHI1j+caOjatDHM/ih13Rj7HIJFn\nAcutRB9vyFiCVluqRhlB9/64sqGtVmxJAir7WJp4TmpPvSEqeGKQIb80Tq+FYY7f\ntpMxQpsBT8B6y4Kn95ZfDH72H3yJezs/mExVB3M/OCBg+xt/c3dXp65JsbS482c4\nKhkxxHChNn1Y/nZ8kFYzakRGhh0BMqkvkqtAwcQJK1xPx2jRELS1vj7OFfMR+3ms\nSQIDAQAB\n-----END PUBLIC KEY-----";

- (id)init {
    [self setResourceURI:@"/cards"];
    return self;
}

- (id)initWithNumber:(NSString *)number name:(NSString *)name cvc:(NSString *)cvc expMonth:(NSString *)expMonth expYear:(NSString *)expYear {
    self = [super init];
    if (!self) return nil;
    
    [self setNumber:number name:name cvc:cvc expMonth:expMonth expYear:expYear];
    
    return self;
}

- (void)setNumber:(NSString *)number name:(NSString *)name cvc:(NSString *)cvc expMonth:(NSString *)expMonth expYear:(NSString *)expYear {
    NSString *encryptedNumber = [self encryptWithPublicKey:number];
    NSString *encryptedCvc = [self encryptWithPublicKey:cvc];
    NSString *encryptedExpMonth = [self encryptWithPublicKey:expMonth];
    NSString *encryptedExpYear = [self encryptWithPublicKey:expYear];
    NSString *encryptedName = [self encryptWithPublicKey:name];
    
    [self setNumber:encryptedNumber];
    [self setName:encryptedName];
    [self setCvc:encryptedCvc];
    [self setExpMonth:encryptedExpMonth];
    [self setExpYear:encryptedExpYear];
}

- (NSString *)encryptWithPublicKey:(NSString *)plainText {
    NSData *plainData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    SecKeyRef publicKey = [self getPublicKeyFromPEM:kPublicKeyPEM];
    
    if (!publicKey) {
        NSLog(@"Error obtaining public key");
        return nil;
    }
    
    size_t cipherBufferSize = SecKeyGetBlockSize(publicKey);
    uint8_t *cipherBuffer = malloc(cipherBufferSize);
    
    OSStatus status = SecKeyEncrypt(publicKey,
                                    kSecPaddingPKCS1,
                                    plainData.bytes,
                                    plainData.length,
                                    cipherBuffer,
                                    &cipherBufferSize);
    
    NSData *cipherData;
    if (status == errSecSuccess) {
        cipherData = [NSData dataWithBytes:cipherBuffer length:cipherBufferSize];
    } else {
        NSLog(@"Encryption failed with status: %d", (int)status);
        cipherData = nil;
    }
    
    free(cipherBuffer);
    CFRelease(publicKey);
    
    return [cipherData base64EncodedStringWithOptions:0];
}

// Método para convertir la clave pública en formato PEM a SecKeyRef
- (SecKeyRef)getPublicKeyFromPEM:(NSString *)pemKey {
    // Filtra la cabecera y pie del PEM
    NSString *strippedKey = [pemKey stringByReplacingOccurrencesOfString:@"-----BEGIN PUBLIC KEY-----" withString:@""];
    strippedKey = [strippedKey stringByReplacingOccurrencesOfString:@"-----END PUBLIC KEY-----" withString:@""];
    strippedKey = [strippedKey stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    // Decodifica la cadena Base64 a NSData
    NSData *keyData = [[NSData alloc] initWithBase64EncodedString:strippedKey options:0];
    if (!keyData) {
        NSLog(@"Error decoding PEM key to data");
        return nil;
    }
    
    NSDictionary *options = @{
        (__bridge id)kSecAttrKeyType: (__bridge id)kSecAttrKeyTypeRSA,
        (__bridge id)kSecAttrKeyClass: (__bridge id)kSecAttrKeyClassPublic,
        (__bridge id)kSecAttrKeySizeInBits: @(2048)
    };
    
    CFErrorRef error = NULL;
    SecKeyRef publicKey = SecKeyCreateWithData((__bridge CFDataRef)keyData, (__bridge CFDictionaryRef)options, &error);
    
    if (error) {
        CFRelease(error);
        return nil;
    }
    
    return publicKey;
}

- (NSData *)asJSONData {
    NSString *_json = [NSString stringWithFormat:@"{\"card\":{\"name\": \"%@\", \"number\": \"%@\", \"cvc\": \"%@\", \"exp_month\": \"%@\", \"exp_year\": \"%@\", \"device_fingerprint\": \"%@\" } }", self.name, self.number, self.cvc, self.expMonth, self.expYear, self.deviceFingerprint];
    return [_json dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
}

@end
