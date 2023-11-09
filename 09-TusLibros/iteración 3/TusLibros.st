!classDefinition: #CartTest category: 'TusLibros-Test'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Test'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 04:01:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart addItem: testObjectsFactory itemNotSoldByTheStore inAmount: 1]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'Sof D 11/8/2023 01:31:57'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart addItem: testObjectsFactory itemSoldByTheStore inAmount: 1.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'Sof D 11/8/2023 01:32:48'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart addItem: testObjectsFactory itemSoldByTheStore inAmount: 0]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 04:01:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart addItem: testObjectsFactory itemNotSoldByTheStore inAmount: 2 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'Sof D 11/8/2023 01:33:30'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart addItem: testObjectsFactory itemSoldByTheStore inAmount: 1.
	self assert: (cart includes: testObjectsFactory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'Sof D 11/8/2023 00:25:24'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSoldByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'Sof D 11/8/2023 01:33:39'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart addItem: testObjectsFactory itemSoldByTheStore inAmount: 2.
	self assert: (cart occurrencesOf: testObjectsFactory itemSoldByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros-Test'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Test'!

!CashierTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 04:08:34'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook forClient: 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 04:08:34'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart addItem: testObjectsFactory itemSoldByTheStore inAmount: 2.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new forClient: 1.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 04:08:34'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart addItem: testObjectsFactory itemSoldByTheStore inAmount: 1.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook forClient: 1 ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 04:08:34'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart addItem: testObjectsFactory itemSoldByTheStore inAmount: 1.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook forClient: 1.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 04:08:34'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart addItem: testObjectsFactory itemSoldByTheStore inAmount: 1.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook forClient: 1.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 04:08:34'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart addItem: testObjectsFactory itemSoldByTheStore inAmount: 1.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook forClient: 1.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #ClientInterfaceTest category: 'TusLibros-Test'!
TestCase subclass: #ClientInterfaceTest
	instanceVariableNames: 'testObjectsFactory passwordAuthenticator watchSimulator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Test'!

!ClientInterfaceTest methodsFor: 'setup' stamp: 'eaam 11/9/2023 16:09:21'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	passwordAuthenticator := [:clientId :password | ].
	
	watchSimulator := WatchSimulator for: testObjectsFactory today.! !


!ClientInterfaceTest methodsFor: 'password protocol' stamp: 'Sof D 11/6/2023 20:34:09'!
validateClientId: aClientIdToValidate withPassword: aPasswordToValidate
	passwordAuthenticator value: aClientIdToValidate value: aPasswordToValidate.! !


!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 15:49:41'!
test01ClientInterfaceCantCreateACartForANotRegisteredClient
	| clientInterface cartDatabase|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: watchSimulator .
	
	passwordAuthenticator := [:clientId :password | 
		clientInterface error: ClientInterface clientIsNotRegisteredErrorDescription.
		].
	
	self should: [clientInterface createCartForClient: 'Lord Valdomero' withPassword: testObjectsFactory invalidPassword ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText equals: ClientInterface clientIsNotRegisteredErrorDescription.
		]! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 15:49:37'!
test02ClientInterfaceCanCreateACartForARegisteredClient
		| clientInterface cartDatabase cartId|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface 
		forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: watchSimulator .
	
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	self assert: (clientInterface listCartWithID: cartId) equals: Bag new .
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 15:49:34'!
test03ClientInterfaceCantAddToANonexistentCart
	| clientInterface cartDatabase |
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface 
		forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: watchSimulator .
	

	self should: [clientInterface addToCartWithID: testObjectsFactory invalidCartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: testObjectsFactory itemSellByTheStorePrice]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText equals: ClientInterface cartDoesntExistErrorDescription.	self deny: (cartDatabase includesKey: testObjectsFactory invalidCartId).
		].
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 15:49:30'!
test04ClientInterfaceCanAddBookToACart
	| clientInterface cartDatabase cartId |
	
	cartDatabase := Dictionary new.
	
	clientInterface := ClientInterface 
		forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: watchSimulator .
	
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: 1.
	self assert: (clientInterface listCartWithID: cartId) equals: (Bag with: testObjectsFactory itemSoldByTheStore )! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 15:49:24'!
test05ClientInterfaceCanAddManyOfABookToACart
	| clientInterface cartDatabase cartId |
	
	cartDatabase := Dictionary new.
	
	clientInterface := ClientInterface 
		forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: watchSimulator .
	
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: 2.
	self assert: (clientInterface listCartWithID: cartId) equals: (Bag with: testObjectsFactory itemSoldByTheStore with: testObjectsFactory itemSoldByTheStore )! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 15:49:20'!
test06ClientInterfaceCannotAddNonexistentBook
	| clientInterface cartDatabase cartId |
	
	cartDatabase := Dictionary new.
	
	clientInterface := ClientInterface 
		forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: watchSimulator .
	
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	self should: [	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemNotSoldByTheStore inQuantity: 1. ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText equals: ClientInterface invalidItemErrorDescription .
		self assert: (clientInterface listCartWithID: cartId) equals: (Bag new)
		]! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 15:49:15'!
test07ClientInterfaceCannotAddNegativeAmountOfBooks
	| clientInterface cartDatabase cartId |
	
	cartDatabase := Dictionary new.
	
	clientInterface := ClientInterface 
		forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: watchSimulator .
	
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	self should: [	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: -1. ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText equals: ClientInterface invalidItemAmountErrorDescription .
		self assert: (clientInterface listCartWithID: cartId) equals: (Bag new)

		]! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 15:49:10'!
test08CannotListCartWithInvalidID

	
	| clientInterface cartDatabase|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self 
		currentDate: watchSimulator .
	
	self should: [clientInterface listCartWithID: testObjectsFactory invalidCartId ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText equals: ClientInterface cartDoesntExistErrorDescription .
		]! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 15:49:01'!
test09ListCartReturnsCorrectResultForNewCart

	
	| clientInterface cartDatabase cartId|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: watchSimulator .
		
		
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	

	
	self assert: (clientInterface listCartWithID: cartId) equals: Bag new. 
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 15:48:55'!
test10ListCartReturnsCorrectResultForCartWithItems

	
	| clientInterface cartDatabase cartId|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self 
		currentDate: watchSimulator .
		
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: 2.
	

	
	self assert: (clientInterface listCartWithID: cartId) equals: (Bag with: testObjectsFactory itemSoldByTheStore with: testObjectsFactory itemSoldByTheStore) . 
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 16:43:19'!
test11CanCheckoutCartWithItems

	
	| clientInterface cartDatabase cartId expectedPurchaseList|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self 
		currentDate: watchSimulator .
		
	cartId := clientInterface createCartForClient:  1 withPassword: testObjectsFactory validPassword.
	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: 1.
	clientInterface checkoutCartWithID: cartId withCreditCardNumbered: testObjectsFactory notExpiredCreditCard cardExpiryDate: '12/2026' cardOwner: 'Juan Perez'.
	
	expectedPurchaseList := Bag with: testObjectsFactory itemSoldByTheStore.
	
	self assert: (clientInterface listPurchasesOfClientWithID:  1  withPassword: testObjectsFactory validPassword) equals: expectedPurchaseList 
	
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 16:44:04'!
test12CantCheckoutEmptyCart

	
	| clientInterface cartDatabase cartId expectedPurchaseList |
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self 
		currentDate: watchSimulator .
	
	cartId := clientInterface createCartForClient: 1 withPassword: testObjectsFactory validPassword .
	expectedPurchaseList := Bag new.
	
	
		
	
self should: [clientInterface checkoutCartWithID: cartId withCreditCardNumbered: '1111111111111111' cardExpiryDate: '12/2026' cardOwner: 'Juan Perez']
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText equals: ClientInterface cannotCheckoutEmptyCartErrorDescription .
		self assert: (clientInterface listPurchasesOfClientWithID:  1  withPassword: testObjectsFactory validPassword) equals: expectedPurchaseList 
		]
	 
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 16:44:31'!
test13CantCheckoutNonexistentCart

	
	| clientInterface cartDatabase |
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
		
		
	
self should: [clientInterface checkoutCartWithID: testObjectsFactory invalidCartId withCreditCardNumbered: '1111111111111111' cardExpiryDate: '12/2026' cardOwner: 'Juan Perez']
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText equals: ClientInterface cartDoesntExistErrorDescription .
		]
	 
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 16:44:57'!
test14CantCheckoutCartUsingExpiredCreditCart

	
	| clientInterface cartDatabase cartId expectedPurchaseList|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self 
		currentDate: watchSimulator.
	cartId := clientInterface createCartForClient: 'Nicolas Rinaldi' withPassword: testObjectsFactory validPassword .
	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: 1.
	expectedPurchaseList := Bag new.

		
	
self should: [clientInterface checkoutCartWithID: cartId  withCreditCardNumbered: '1111111111111111' cardExpiryDate: '12/2020' cardOwner: 'Juan Perez']
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText equals: ClientInterface expiredCreditCardErrorDescription .
				self assert: (clientInterface listPurchasesOfClientWithID:  1  withPassword: testObjectsFactory validPassword) equals: expectedPurchaseList 

		]
	 
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 15:42:33'!
test15ListPurcharcesIsEmptyForANewUserId
	
	| clientInterface cartDatabase cartId |
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self
		currentDate: watchSimulator.
		
	cartId := clientInterface createCartForClient: 1 withPassword: testObjectsFactory validPassword .
	
	self assert: (clientInterface listPurchasesOfClientWithID: 1 withPassword: testObjectsFactory validPassword) equals: Bag new.
	
	

	
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 15:42:26'!
test16ListPurchacesShowsPurchasesOfAValidClientWithPurchases

	
	| clientInterface cartDatabase cartId expectedPurchaseList |
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self
		currentDate: watchSimulator.
		
	cartId := clientInterface createCartForClient: 1 withPassword: testObjectsFactory validPassword .
	
	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: 2.
	clientInterface checkoutCartWithID: cartId  withCreditCardNumbered: '1111111111111111' cardExpiryDate: '12/2026' cardOwner: 'Juan Perez'.
	
	expectedPurchaseList := Bag with: testObjectsFactory itemSoldByTheStore with: testObjectsFactory itemSoldByTheStore .
	
	self assert: (clientInterface listPurchasesOfClientWithID: 1 withPassword: testObjectsFactory validPassword) equals: expectedPurchaseList.
	
	

	
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 15:42:13'!
test17CantListPurchacesOfAInalidClient
	
	| clientInterface cartDatabase |
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self 
		currentDate:watchSimulator.
		
	passwordAuthenticator := [:clientId :password | 
		clientInterface error: ClientInterface clientIsNotRegisteredErrorDescription.
		].
	
	self should: [clientInterface listPurchasesOfClientWithID: 1 withPassword: testObjectsFactory invalidPassword]
	raise: Error
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: ClientInterface clientIsNotRegisteredErrorDescription.
		]
	

	
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 16:22:03'!
test18CantAddToAExpiredCart
	
	| clientInterface cartDatabase cartId|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self 
		currentDate: watchSimulator .
		
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	
	watchSimulator advanceTime: 60 minutes.
	
	
	self should: [clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: testObjectsFactory itemSellByTheStorePrice]
	raise: Error
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: ClientInterface cartExpiredErrorDescription.
		watchSimulator backInTime: 60 minutes.
		self assert: (clientInterface listCartWithID: cartId) equals: Bag new.
		]
	

	
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 16:22:34'!
test19CantListCartOfAExpiredCart
	
	| clientInterface cartDatabase cartId|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self 
		currentDate: watchSimulator .
		
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	
	watchSimulator advanceTime: 60 minutes.
	
	
	self should: [clientInterface listCartWithID: cartId]
	raise: Error
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: ClientInterface cartExpiredErrorDescription.
		watchSimulator backInTime: 60 minutes.
		self assert: (clientInterface listCartWithID: cartId) equals: Bag new.
		]
	

	
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 16:27:49'!
test20CantCheckOutAExpiredCart
	
	| clientInterface cartDatabase cartId|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self 
		currentDate: watchSimulator .
		
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	
	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: 1.
	
	watchSimulator advanceTime: 60 minutes.
	
	
	self should: [clientInterface checkoutCartWithID: cartId  withCreditCardNumbered: '1111111111111111' cardExpiryDate: '12/2026' cardOwner: 'Juan Perez']
	raise: Error
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: ClientInterface cartExpiredErrorDescription.
		watchSimulator backInTime: 60 minutes.
		]
	

	
	! !


!ClientInterfaceTest methodsFor: 'merchant processor behavior' stamp: 'Sof D 11/8/2023 02:55:40'!
debit: anAmount from: aCreditCard 

	! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros-Test'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Test'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'Sof D 11/9/2023 04:01:10'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'Sof D 11/8/2023 00:25:23'!
itemSoldByTheStore
	
	^ 'validBook'! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'Sof D 11/8/2023 00:25:24'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSoldByTheStore put: self itemSellByTheStorePrice;
		yourself ! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'Sof D 11/6/2023 21:16:32'!
emptyCartList
	^Dictionary new.! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'eaam 11/7/2023 03:48:52'!
invalidCartId
	^'invalidId'! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'eaam 11/9/2023 15:46:50'!
expiredCreditCardDate
	
	^ (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'Sof D 11/6/2023 20:19:43'!
invalidPassword
	
	^'riBer'! !

!StoreTestObjectsFactory methodsFor: 'clients' stamp: 'Sof D 11/6/2023 20:19:50'!
validPassword
	
	^'BOCA'! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
!classDefinition: #Cart category: 'TusLibros-Ejercicio'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'Sof D 11/8/2023 01:29:06'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'Sof D 11/8/2023 01:32:20'!
addItem: anItemToAddToTheCart  inAmount: theAmountToAdd

	self assertIsValidQuantity: theAmountToAdd.
	self assertIsValidItem: anItemToAddToTheCart.

	1 to: theAmountToAdd do: [ :aNumber | items add: anItemToAddToTheCart ]! !


!Cart methodsFor: 'listCart' stamp: 'Sof D 11/8/2023 01:36:39'!
listCart
	^items copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Ejercicio'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartTimeoutManager category: 'TusLibros-Ejercicio'!
Object subclass: #CartTimeoutManager
	instanceVariableNames: 'cart clientInterface createdAtTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CartTimeoutManager methodsFor: 'cart management' stamp: 'eaam 11/9/2023 15:41:33'!
addItem: anItemToAddToTheCart  inAmount: theAmountToAdd
	self assertCartIsNotExpired.
	^cart addItem: anItemToAddToTheCart  inAmount: theAmountToAdd! !

!CartTimeoutManager methodsFor: 'cart management' stamp: 'eaam 11/9/2023 15:30:05'!
listCart
	self assertCartIsNotExpired.
	^cart listCart! !


!CartTimeoutManager methodsFor: 'initialization' stamp: 'Sof D 11/9/2023 16:46:26'!
initializeWithCart: aCart withClientInterface: aClientInterface
	cart := aCart .
	clientInterface := aClientInterface .
	createdAtTime := clientInterface currentTime.! !


!CartTimeoutManager methodsFor: 'assertions' stamp: 'Sof D 11/9/2023 16:46:26'!
assertCartIsNotExpired
	(self cartIsExpiredInTime: clientInterface currentTime) ifTrue: [ self error: ClientInterface cartExpiredErrorDescription ]! !

!CartTimeoutManager methodsFor: 'assertions' stamp: 'eaam 11/9/2023 16:17:47'!
cartIsExpiredInTime: aActualTime
	^ ((createdAtTime + (30 minutes)) < aActualTime)! !

!CartTimeoutManager methodsFor: 'assertions' stamp: 'eaam 11/9/2023 15:43:17'!
isEmpty
	^cart isEmpty! !


!CartTimeoutManager methodsFor: 'accessing' stamp: 'eaam 11/9/2023 15:41:03'!
cart
	self assertCartIsNotExpired.
	^cart! !

!CartTimeoutManager methodsFor: 'accessing' stamp: 'eaam 11/9/2023 15:43:24'!
total
	^cart total! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartTimeoutManager class' category: 'TusLibros-Ejercicio'!
CartTimeoutManager class
	instanceVariableNames: ''!

!CartTimeoutManager class methodsFor: 'as yet unclassified' stamp: 'eaam 11/9/2023 15:16:05'!
forCart: aCart forClientInterface: aClientInterface
	^self new initializeWithCart: aCart withClientInterface: aClientInterface! !


!classDefinition: #Cashier category: 'TusLibros-Ejercicio'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total client'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'eaam 11/9/2023 04:18:30'!
createSale

	^ Sale of: total forClient: client withItems: cart listCart
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'eaam 11/9/2023 04:10:20'!
withClient: aClientId initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
		client := aClientId.

	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros-Ejercicio'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'eaam 11/9/2023 04:09:50'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook forClient: aClientId 
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new withClient: aClientId initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #ClientInterface category: 'TusLibros-Ejercicio'!
Object subclass: #ClientInterface
	instanceVariableNames: 'passwordAuthenticator cartDatabase catalog merchantProcessor watch salesBook nextId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!ClientInterface methodsFor: 'initialization' stamp: 'eaam 11/9/2023 15:36:14'!
initializeWithCartDatabase: aDatabaseOfCarts merchantProcessor: aMerchantProcessor catalog: aCatalog passwordAuthenticator: aPasswordAuthenticator currentDate: theCurrentDate 
	passwordAuthenticator := aPasswordAuthenticator.
	nextId := 0.
	cartDatabase := aDatabaseOfCarts.
	catalog := aCatalog .
	
	watch :=  theCurrentDate .
	
	merchantProcessor := aMerchantProcessor .
	
	salesBook := OrderedCollection new.! !


!ClientInterface methodsFor: 'asserting' stamp: 'Sof D 11/9/2023 16:46:26'!
assertExpirationAndgenerateCardWithExpiryDate: theExpiryDateOfTheCard
	| card |
	card := CreditCard expiringOn: (Month month: ((theExpiryDateOfTheCard copyFrom: 1 to: 2) asNumber )year: ((theExpiryDateOfTheCard copyFrom: 4 to: 7) asNumber)).
	(card isExpiredOn: watch currentTime date) ifTrue: [ self error: self class expiredCreditCardErrorDescription ].
	^card! !

!ClientInterface methodsFor: 'asserting' stamp: 'Sof D 11/8/2023 02:02:55'!
assertInDatabaseTheCartId: aCartId

	^ (cartDatabase includesKey: aCartId) ifFalse: [self error: self class cartDoesntExistErrorDescription]! !

!ClientInterface methodsFor: 'asserting' stamp: 'eaam 11/9/2023 02:46:35'!
assertIsInCatalogTheBook: aBookToAdd AndIsGreaterThanTwo: aQuantityToAdd

	(catalog includesKey: aBookToAdd) ifFalse: [ self error: self class invalidItemErrorDescription ].
	(aQuantityToAdd > 0) ifFalse: [ self error: self class invalidItemAmountErrorDescription ]! !

!ClientInterface methodsFor: 'asserting' stamp: 'Sof D 11/9/2023 16:50:15'!
isCartEmpty: theManagerOfTheCart

	^ (theManagerOfTheCart isEmpty) ifTrue: [ self error: self class cannotCheckoutEmptyCartErrorDescription ]! !


!ClientInterface methodsFor: 'interface calls' stamp: 'eaam 11/9/2023 02:46:35'!
addToCartWithID: aCartId theBook: aBookToAdd inQuantity: aQuantityToAdd
	self assertInDatabaseTheCartId: aCartId.
	
	self assertIsInCatalogTheBook: aBookToAdd AndIsGreaterThanTwo: aQuantityToAdd.
	(cartDatabase at: aCartId) addItem: aBookToAdd  inAmount: aQuantityToAdd.! !

!ClientInterface methodsFor: 'interface calls' stamp: 'Sof D 11/9/2023 16:52:55'!
checkoutCartWithID: aCartId withCreditCardNumbered: theNumberOfTheCreditCardToCharge cardExpiryDate: theExpiryDateOfTheCard cardOwner: theNameOfTheCardOwner
	| cartManager card |
	self assertInDatabaseTheCartId: aCartId .

	cartManager :=  cartDatabase at: aCartId.
	
	self isCartEmpty: cartManager.
	
	card := self assertExpirationAndgenerateCardWithExpiryDate: theExpiryDateOfTheCard.
	
	self generateCashierAndCheckoutCart: cartManager usingCard: card. 
	
	
	! !

!ClientInterface methodsFor: 'interface calls' stamp: 'eaam 11/9/2023 15:19:20'!
createCartForClient:  aClientToCheck withPassword: aPasswordToCheck
	| cartId |
	passwordAuthenticator validateClientId: aClientToCheck withPassword: aPasswordToCheck.
	cartId := self nextCartId.
	cartDatabase at: cartId put: (self newCartAcceptingItemsOf: catalog).
	
	^cartId! !

!ClientInterface methodsFor: 'interface calls' stamp: 'Sof D 11/8/2023 02:40:34'!
listCartWithID: aCartId	self assertInDatabaseTheCartId: aCartId.

	^(cartDatabase at: aCartId) listCart! !

!ClientInterface methodsFor: 'interface calls' stamp: 'eaam 11/9/2023 04:34:29'!
listPurchasesOfClientWithID: theIdOfTheClientToListThePurchasesOf withPassword: aPassword  

	passwordAuthenticator validateClientId: theIdOfTheClientToListThePurchasesOf withPassword: aPassword.
	

	^ self allPurchasesOfClientId: theIdOfTheClientToListThePurchasesOf.! !


!ClientInterface methodsFor: 'time' stamp: 'Sof D 11/9/2023 16:46:27'!
currentTime 
	^watch currentTime! !


!ClientInterface methodsFor: 'auxiliaries' stamp: 'eaam 11/9/2023 04:36:31'!
allPurchasesOfClientId: aClientIdToGetAllThePurchases

	^ ((self salesForClientId: aClientIdToGetAllThePurchases) inject: OrderedCollection new into: [:listOfPurchases :aSale | listOfPurchases addAll: aSale ItemsBought]) asBag! !

!ClientInterface methodsFor: 'auxiliaries' stamp: 'Sof D 11/9/2023 16:52:28'!
generateCashierAndCheckoutCart: theManagerOfTheCartToCheckout usingCard: aCreditCardToCharge 

	| cashier |
	
	cashier := Cashier toCheckout: theManagerOfTheCartToCheckout cart charging: aCreditCardToCharge throught: merchantProcessor on: (watch currentTime date) registeringOn: salesBook forClient: 1.
	cashier checkOut .! !

!ClientInterface methodsFor: 'auxiliaries' stamp: 'eaam 11/9/2023 15:21:12'!
newCartAcceptingItemsOf: aCatalog
	^CartTimeoutManager forCart: (Cart acceptingItemsOf: aCatalog ) forClientInterface: self.! !

!ClientInterface methodsFor: 'auxiliaries' stamp: 'eaam 11/9/2023 14:02:38'!
nextCartId
	nextId := nextId + 1.
	^nextId! !

!ClientInterface methodsFor: 'auxiliaries' stamp: 'eaam 11/9/2023 03:53:42'!
registerNewClientInSalesList: theIdOfTheNewClient
	(salesBook includesKey: theIdOfTheNewClient) ifFalse: [ salesBook at: theIdOfTheNewClient put: Bag new ]! !

!ClientInterface methodsFor: 'auxiliaries' stamp: 'eaam 11/9/2023 04:33:01'!
salesForClientId: theIdOfTheClientToListThePurchasesOf

	^ salesBook select: [:aSale | aSale isFromClient: theIdOfTheClientToListThePurchasesOf]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClientInterface class' category: 'TusLibros-Ejercicio'!
ClientInterface class
	instanceVariableNames: ''!

!ClientInterface class methodsFor: 'error handling' stamp: 'Sof D 11/9/2023 04:13:51'!
cannotCheckoutEmptyCartErrorDescription
	^'Cannot checkout empty cart'! !

!ClientInterface class methodsFor: 'error handling' stamp: 'Sof D 11/8/2023 01:42:43'!
cartDoesntExistErrorDescription
	^'Cart id is not registered'! !

!ClientInterface class methodsFor: 'error handling' stamp: 'eaam 11/9/2023 16:18:29'!
cartExpiredErrorDescription
	^'The cart is expired'! !

!ClientInterface class methodsFor: 'error handling' stamp: 'Sof D 11/8/2023 01:41:22'!
clientIsNotRegisteredErrorDescription
	^'ups!! You are not registered!! bakita el más grande papa'! !

!ClientInterface class methodsFor: 'error handling' stamp: 'Sof D 11/9/2023 04:21:55'!
expiredCreditCardErrorDescription
	^'Cant use expired credit card for payment'! !

!ClientInterface class methodsFor: 'error handling' stamp: 'Sof D 11/9/2023 04:07:56'!
invalidItemAmountErrorDescription
	^'Item amount must be positive'! !

!ClientInterface class methodsFor: 'error handling' stamp: 'Sof D 11/9/2023 04:01:54'!
invalidItemErrorDescription
	^'Selected item isnt sold by catalog'! !


!ClientInterface class methodsFor: 'initialization' stamp: 'Sof D 11/8/2023 02:54:26'!
forCartDatabase: aDatabaseOfCarts merchantProcessor: aMerchantProcessor catalog: aCatalog passwordAuthenticator: aPasswordAuthenticator currentDate: theCurrentDate 
	^self new initializeWithCartDatabase: aDatabaseOfCarts merchantProcessor: aMerchantProcessor catalog: aCatalog passwordAuthenticator: aPasswordAuthenticator currentDate: theCurrentDate ! !


!classDefinition: #CreditCard category: 'TusLibros-Ejercicio'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration clientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'eaam 11/9/2023 04:01:06'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth. 
	clientId := 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-Ejercicio'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: 'TusLibros-Ejercicio'!
Object subclass: #Sale
	instanceVariableNames: 'total clientId ItemsBought'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!Sale methodsFor: 'total' stamp: 'eaam 11/9/2023 04:20:24'!
ItemsBought
	
	^ ItemsBought ! !

!Sale methodsFor: 'total' stamp: 'eaam 11/9/2023 04:01:38'!
isFromClient: aClientIdToCheck
	
	^clientId =  aClientIdToCheck ! !

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'eaam 11/9/2023 04:20:24'!
initializeTotal: aTotal forClient: aClientId withItems: itemsBoughtByTheClient  

	total := aTotal.
	clientId := aClientId.
	ItemsBought := itemsBoughtByTheClient! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros-Ejercicio'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'eaam 11/9/2023 04:17:42'!
of: aTotal forClient: aClientId withItems: aBagOfItemsBoughtByTheClient 

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal forClient: aClientId withItems: aBagOfItemsBoughtByTheClient ! !


!classDefinition: #WatchSimulator category: 'TusLibros-Ejercicio'!
Object subclass: #WatchSimulator
	instanceVariableNames: 'actualDateAndTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Ejercicio'!

!WatchSimulator methodsFor: 'modify time' stamp: 'eaam 11/9/2023 15:11:28'!
advanceTime: aTimeToAdvance
	actualDateAndTime := actualDateAndTime + aTimeToAdvance.! !

!WatchSimulator methodsFor: 'modify time' stamp: 'eaam 11/9/2023 15:58:32'!
backInTime: aTime
	actualDateAndTime := actualDateAndTime - aTime.! !


!WatchSimulator methodsFor: 'initialization' stamp: 'eaam 11/9/2023 15:10:35'!
initializeWith: aDateAndTime
	actualDateAndTime := aDateAndTime.! !


!WatchSimulator methodsFor: 'get time' stamp: 'Sof D 11/9/2023 16:46:26'!
currentTime
	^actualDateAndTime! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WatchSimulator class' category: 'TusLibros-Ejercicio'!
WatchSimulator class
	instanceVariableNames: ''!

!WatchSimulator class methodsFor: 'as yet unclassified' stamp: 'eaam 11/9/2023 15:10:14'!
for: aDateAndTime
	^self new initializeWith: aDateAndTime! !
