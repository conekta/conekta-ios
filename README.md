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

* Add files into **conekta** group.

For objective-C projects you should add the next header
```objectivec
#import "YourProjectName-Swift.h"
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
### Swift

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apikey = "key_KJysdbf6PotS2ut2"
        let card = Card(number: "4242424242424242", name: "Javier Castañeda", cvc: "123", exp_month: "10", exp_year: "2020")
        let conekta = Conekta(apikey: apikey)
        conekta.requestTokenFor(card) { (token, error) in
            if let e = error{
                print(e.localizedDescription)
				//manage Error
            }else{
                dump(token)
				//Do something with the token
            }
        }
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
