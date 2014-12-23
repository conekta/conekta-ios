## Intro

Conekta iOS SDK with swift is a files necesary to tokenize Credit/Debit Cards using Conekta REST API in your iOS projects
and make Payments with tokens, create Customers and save the tokens to Customers for
future charges.

## Table of Contents

- Intro
- Requeriments
- Installation
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

2. When you add the files into your directory, add to the group/target. 

3. Now, you can create an object of Conekta in your ViewController or wherever you need to add the logic. 

  ``var conekta = Conekta(publicKey: String) ``

4. You can use a ``conekta.createToken`` bet before create an object card. 

  ````swift
  var card = Card(last4: "4242424242424242", name: "Test Name", cvc: "123", exp_month: "12", exp_year: "2020")
  
  conekta.createToken(card, withSuccess: { () -> Void in
              print("tokenized")
              }, withFailure: { () -> Void in
              print("fail")
          })
  ````
5. With those lines you can tokenize a card. 

## Contributing & Attribution

Thanks to [Santiago Zavala](https://github.com/dfectuoso) for helping us to create Conekta iOS SDK.

License
-------
Developed by [Conekta](https://www.conekta.io). Available with [MIT License](LICENSE).
