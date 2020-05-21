//
//  Conekta.m
//  Conekta
//
//  Created by Julian Ceballos on 10/16/15.
//
//

#import "Conekta.h"


@implementation Conekta

- (id) init
{
    [self setBaseURI:@"https://api.conekta.io"];
    return self;
}

- (NSString *) deviceFingerprint
{
    NSString *uuid = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    return [uuid stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

- (void) collectDevice {
    NSString *html = [NSString stringWithFormat:@"<html style=\"background: blue;\"><head></head><body><script type=\"text/javascript\" src=\"https://conektaapi.s3.amazonaws.com/v0.5.0/js/conekta.js\" data-conekta-public-key=\"%@\" data-conekta-session-id=\"%@\"></script></body></html>", [self publicKey], [self deviceFingerprint]];
    WKWebViewConfiguration *theConfiguration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) configuration:theConfiguration];
    NSURL *nsurl=[NSURL URLWithString:html];
    NSURLRequest *nsrequest=[NSURLRequest requestWithURL:nsurl];
    [webView loadRequest:nsrequest];
    [self.delegate.view addSubview:webView];
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

