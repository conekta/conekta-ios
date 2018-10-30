![alt tag](https://raw.github.com/conekta/conekta-ios/master/readme_files/cover.png)

# Conekta iOS v 1.0.0

Stand allone wrapper to connect with https://api.conekta.io.

Conekta iOS SDK allow you create token with card details on iOS apps, by preventing sensitive card data from hitting your server (More information, read PCI compliance).

# Installing
In order to create a brand new *Swift* implementation I have created this library using the Protocol Oriented Programming tecnique.

For installation you need to copy the classes on the ```Conekta``` and ```Network``` folders to your project.

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
}
```
