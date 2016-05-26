![alt tag](https://raw.github.com/conekta/conekta-ios/master/readme_files/cover.png)

Conekta iOS v 1.0.0
======================

Wrapper to connect with https://api.conekta.io.

Conekta iOS SDK allow you create token with card details on iOS apps, by preventing sensitive card data from hitting your server(More information, read PCI compliance).

## Install

Via git:

```sh
$ git clone git@github.com:conekta/conekta-ios.git
```

## Configuration and Setup

### General setup

* Move folder Conekta into your project folder.

* Create a new group called **Conekta** via xcode.

* On your xcodeproj, got to: Build Settings > Search Paths > Library Search Path, then double click and set the value to:
```
$(inherited)
$(PROJECT_DIR)/Conekta
```

* Add files into **conekta** group.

For swift projects, when you add objective c files, it will ask you to create a Bridging file, include on this file the next content:

```objectivec
#import "Conekta.h"
```

### App Transport Security

If you are compiling with iOS 9, please add on your application plist the lines below:

```xml
<key>NSAppTransportSecurity</key>
<dict>
  <key>NSAllowsArbitraryLoads</key><true/>
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

  [conekta setDelegate: self];

  [conekta setPublicKey:@"key_KJysdbf6PotS2ut2"];

  [conekta collectDevice];

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

    conekta.delegate = self

    conekta.publicKey = "key_KJysdbf6PotS2ut2"

    conekta.collectDevice()

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

## Contribute

### Clone repo

```sh
$ git clone https://github.com/conekta/conekta-ios
$ cd conekta-ios
```

### Send pull requests

We love pull requests, send them from your fork to branch **dev** into **conekta/conekta-ios**

### Attribution

Thanks to [Santiago Zavala](https://github.com/dfectuoso) for helping us to create Conekta iOS SDK Swift first version.

License
-------
Developed by [Conekta](https://www.conekta.io). Available with [MIT License](LICENSE).

We are hiring
-------------

If you are a comfortable working with a range of backend languages (Java, Python, Ruby, PHP, etc) and frameworks, you have solid foundation in data structures, algorithms and software design with strong analytical and debugging skills. 
Send your CV, github to quieroser@conekta.io
