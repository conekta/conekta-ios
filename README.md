## Intro

Conekta iOS SDK with swift is a files necesary to tokenize Credit/Debit Cards using Conekta REST API in your iOS projects
and make Payments with tokens, create Customers and save the tokens to Customers for
future charges.

## Table of Contents

- Intro
- Requeriments
- Configuration and Setup
- Contributing & Attribution
- License

## Requirements
- Clone the repo to your Mac``git clone git@github.com:conekta/conekta-ios.git``
- To create Tokens and make Payments directly to REST API:
  - Xcode 6 or superior.

## Configuration and Setup

### Initial Configuration in XCode

1. You need to move next files in Xcode Workspace: 
  - Conekta.swift
  - Connection.swift 
  - Card.swift
  - Token.swift
  - DeviceCollectorSDK.h
  - libDeviceCollector.a
  - Bridging-Header.h

  NOTE: If you are working with another objective c libraries, you can copy the content on Bridging-Header.h and paste it into your bridge file, instead copy the file Bridging-Header.h

2. When you add the files into your directory, add to the group/target. 

3. You should update your xcodeproject file with bridging header for swift code.

3.1 First go to you folder where you have the Bridging header file.

3.2 Now, on your xcodeproject file, search the section: Build Settings > Swift Compile - Code Generation > Objective-C Bridging Header. Double click on value and drop the file Bridging-Header.h or your custom bridging header into the modal.

4. Now, you can create an object of Conekta in your ViewController or wherever you need to add the logic. 

  ``var conekta = Conekta(publicKey: String) ``

5. You can use a ``conekta.createToken`` bet before create an object card. 

  ````swift
  var card = Card(last4: "4242424242424242", name: "Test Name", cvc: "123", exp_month: "12", exp_year: "2020")
  
  conekta.createToken(card, withSuccess: { () -> Void in
              print("tokenized")
              }, withFailure: { () -> Void in
              print("fail")
          })
  ````
6. With those lines you can tokenize a card. 

## Contributing & Attribution

Thanks to [Santiago Zavala](https://github.com/dfectuoso) for helping us to create Conekta iOS SDK.

License
-------
Developed by [Conekta](https://www.conekta.io). Available with [MIT License](LICENSE).

We are hiring
-------------

If you are a comfortable working with a range of backend languages (Java, Python, Ruby, PHP, etc) and frameworks, you have solid foundation in data structures, algorithms and software design with strong analytical and debugging skills. 
Send your CV, github to quieroser@conekta.io
