![alt tag](https://raw.github.com/conekta/conekta-ios/master/readme_files/cover.png)

# Conekta iOS v 1.0.0
======================

Stand allone wrapper to connect with https://api.conekta.io.

Conekta iOS SDK allow you create token with card details on iOS apps, by preventing sensitive card data from hitting your server (More information, read PCI compliance).

# Installing
In order to create a brand new *Swift* implementation I have created this library using the Protocol Oriented Programming tecnique.

For installation you need to copy the classes on the ```Conekta``` and ```Network``` folders to your project.

<<<<<<< HEAD
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


=======
# How to use 

First create a card object with

```swift
let ckCard = CkCard(number: "4242424242424242",
cardholder: "Javier Castañeda",
expMonth: "10", expYear: "2022", cvv: "123")
```

And then you should be able to tokenize it like this:

```swift 
let request = ConektaRequest.tokenize(card: ckCard, APIKey: "key_KJysdbf6PotS2ut2")
Network.request(request) { (result) in
	switch result {
	case .success(let token):
		//TODO: Use the token wherever is necessary
		print("Token card: \(token)" )
	case .failure(let error):
		//TODO: Present the error to the user 
		print(error.localizedDescription)
	}
>>>>>>> swift-implementation
}
```
