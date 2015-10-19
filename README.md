Conekta iOS v 1.0.0
======================

Wrapper to connect with https://api.conekta.io.

Conekta iOS SDK allow you tokenize card details on iOS apps, in order to prevent hit your server.

## Install

Via git:

```sh
$ git clone git@github.com:conekta/conekta-ios.git
```

Via Cocoapods:

```sh
pods 
```

## Configuration and Setup

### General setup

1. Move folder Conekta into your project folder.

2. Create a new group called **Conekta** via xcode.

3. Add files into **conekta** group.

3.1 For swift projects, when you add objective c files, it will ask you to create a Bridging file, include on this file the next content:

```objectivec
#import "DeviceCollectorSDK.h"
#import "Card.h"
#import "Token.h"
#import "Connection.h"
#import "Conekta.h"
```

4. Add into your .xcodeproj file at **Build Settings > Search Paths > Library Search Paths**, the options below:

* $(inherited)
* $(PROJECT_DIR)
* "$(SRCROOT)/Conekta"

### Swift projects setup

1. Into your .xcodeproj file at **Build Settings > Swift Compiler - Code Generation > Objective-C Bridging Header**, drop the Conekta-Bridging-Header.h file located at Conekta folder

### App Transport Security

If you are compiling with iOS 9, please add on your application plist the lines below:

```xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSExceptionDomains</key>
  <dict>
    <key>conekta.io</key>
    <dict>
      <key>NSIncludesSubdomains</key>
      <true/>                
      <key>NSThirdPartyExceptionRequiresForwardSecrecy</key>
      <false/>
    </dict>
  </dict>
</dict>
```

## Usage

### Objective C

```objectivec
#import "ViewController.h"
#import "Conekta.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
Conekta *conekta = [[Conekta alloc] init];

[conekta setPublicKey:@"key_KJysdbf6PotS2ut2"];

Card *card = [conekta.Card initWithNumber: @"4242424242424242" name: @"Julian Ceballos" cvc: @"123" expMonth: @"10" expYear: @"2018"];

Token *token = [conekta.Token initWithCard:card];

[token createWithSuccess: ^(NSDictionary *data) {
NSLog(@"%@", data);
} andError: ^(NSError *error) {
NSLog(@"%@", error);
}];


[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
[super didReceiveMemoryWarning];
}

@end

```

### Swift

```swift
import UIKit

class ViewController: UIViewController {

override func viewDidLoad() {
let conekta = Conekta()

conekta.publicKey = "key_KJysdbf6PotS2ut2"

let card = conekta.Card()

card.setNumber("4242424242424242", name: "Julian Ceballos", cvc: "123", expMonth: "10", expYear: "2018")

let token = conekta.Token()

token.card = card

token.createWithSuccess({ (data) -> Void in
print(data)
}, andError: { (error) -> Void in
print(error)
})

super.viewDidLoad()
}

override func didReceiveMemoryWarning() {
super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
}


}
```

## Contributing & Attribution

Thanks to [Santiago Zavala](https://github.com/dfectuoso) for helping us to create Conekta iOS SDK Swift first version.

License
-------
Developed by [Conekta](https://www.conekta.io). Available with [MIT License](LICENSE).

We are hiring
-------------

If you are a comfortable working with a range of backend languages (Java, Python, Ruby, PHP, etc) and frameworks, you have solid foundation in data structures, algorithms and software design with strong analytical and debugging skills. 
Send your CV, github to quieroser@conekta.io
