!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

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


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

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


!classDefinition: #ClientInterfaceTest category: 'TusLibros'!
TestCase subclass: #ClientInterfaceTest
	instanceVariableNames: 'testObjectsFactory passwordAuthenticator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClientInterfaceTest methodsFor: 'setup' stamp: 'eaam 11/7/2023 01:07:10'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	passwordAuthenticator := [:clientId :password | ].! !


!ClientInterfaceTest methodsFor: 'password protocol' stamp: 'Sof D 11/6/2023 20:34:09'!
validateClientId: aClientIdToValidate withPassword: aPasswordToValidate
	passwordAuthenticator value: aClientIdToValidate value: aPasswordToValidate.! !


!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/8/2023 02:58:17'!
test01ClientInterfaceCantCreateACartForANotRegisteredClient
	| clientInterface cartDatabase|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
	
	passwordAuthenticator := [:clientId :password | 
		clientInterface error: ClientInterface clientIsNotRegisteredErrorDescription.
		].
	
	self should: [clientInterface createCartForClient: 'Lord Valdomero' withPassword: testObjectsFactory invalidPassword ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText equals: ClientInterface clientIsNotRegisteredErrorDescription.
		]! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/8/2023 02:58:12'!
test02ClientInterfaceCanCreateACartForARegisteredClient
		| clientInterface cartDatabase cartId|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface 
		forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
	
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	self assert: (clientInterface listCartWithID: cartId) equals: Bag new .
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/8/2023 02:58:08'!
test03ClientInterfaceCantAddToANonexistentCart
	| clientInterface cartDatabase |
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface 
		forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
	

	self should: [clientInterface addToCartWithID: testObjectsFactory invalidCartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: testObjectsFactory itemSellByTheStorePrice]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText equals: ClientInterface cartDoesntExistErrorDescription.	self deny: (cartDatabase includesKey: testObjectsFactory invalidCartId).
		].
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 01:54:06'!
test04ClientInterfaceCanAddBookToACart
	| clientInterface cartDatabase cartId |
	
	cartDatabase := Dictionary new.
	
	clientInterface := ClientInterface 
		forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
	
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: 1.
	self assert: (clientInterface listCartWithID: cartId) equals: (Bag with: testObjectsFactory itemSoldByTheStore )! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 01:56:57'!
test05ClientInterfaceCanAddManyOfABookToACart
	| clientInterface cartDatabase cartId |
	
	cartDatabase := Dictionary new.
	
	clientInterface := ClientInterface 
		forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
	
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: 2.
	self assert: (clientInterface listCartWithID: cartId) equals: (Bag with: testObjectsFactory itemSoldByTheStore with: testObjectsFactory itemSoldByTheStore )! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 01:57:32'!
test06ClientInterfaceCannotAddNonexistentBook
	| clientInterface cartDatabase cartId |
	
	cartDatabase := Dictionary new.
	
	clientInterface := ClientInterface 
		forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
	
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	self should: [	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemNotSoldByTheStore inQuantity: 1. ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText equals: ClientInterface invalidItemErrorDescription .
		self assert: (clientInterface listCartWithID: cartId) equals: (Bag new)
		]! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 01:57:46'!
test07ClientInterfaceCannotAddNegativeAmountOfBooks
	| clientInterface cartDatabase cartId |
	
	cartDatabase := Dictionary new.
	
	clientInterface := ClientInterface 
		forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
	
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	self should: [	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: -1. ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText equals: ClientInterface invalidItemAmountErrorDescription .
		self assert: (clientInterface listCartWithID: cartId) equals: (Bag new)

		]! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 02:41:54'!
test08CannotListCartWithInvalidID

	
	| clientInterface cartDatabase|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self 
		currentDate: (Month month: 1 year: 2025).	
	self should: [clientInterface listCartWithID: testObjectsFactory invalidCartId ]
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText equals: ClientInterface cartDoesntExistErrorDescription .
		]! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 04:11:00'!
test09ListCartReturnsCorrectResultForNewCart

	
	| clientInterface cartDatabase cartId|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
		
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	

	
	self assert: (clientInterface listCartWithID: cartId) equals: Bag new. 
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 04:11:06'!
test10ListCartReturnsCorrectResultForCartWithItems

	
	| clientInterface cartDatabase cartId|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
		
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: 2.
	

	
	self assert: (clientInterface listCartWithID: cartId) equals: (Bag with: testObjectsFactory itemSoldByTheStore with: testObjectsFactory itemSoldByTheStore) . 
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 04:11:51'!
test11CanCheckoutCartWithItems

	
	| clientInterface cartDatabase cartId|
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
		
	cartId := clientInterface createCartForClient:  'Lord Valdomero' withPassword: testObjectsFactory validPassword.
	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: 1.
	

	
	self assert: (clientInterface checkoutCartWithID: cartId  withCreditCardNumbered: '1111111111111111' cardExpiryDate: '12/2026' cardOwner: 'Juan Perez') equals: true. 
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 04:13:26'!
test12CantCheckoutEmptyCart

	
	| clientInterface cartDatabase cartId |
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
	cartId := clientInterface createCartForClient: 'Nicolas Rinaldi' withPassword: testObjectsFactory validPassword .
		
	
self should: [clientInterface checkoutCartWithID: cartId withCreditCardNumbered: '1111111111111111' cardExpiryDate: '12/2026' cardOwner: 'Juan Perez']
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText equals: ClientInterface cannotCheckoutEmptyCartErrorDescription .
		]
	 
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 04:12:08'!
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

!ClientInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/9/2023 04:24:10'!
test14CantCheckoutCartUsingExpiredCreditCart

	
	| clientInterface cartDatabase cartId |
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
	cartId := clientInterface createCartForClient: 'Nicolas Rinaldi' withPassword: testObjectsFactory validPassword .
	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: 1.

		
	
self should: [clientInterface checkoutCartWithID: cartId  withCreditCardNumbered: '1111111111111111' cardExpiryDate: '12/2023' cardOwner: 'Juan Perez']
	raise: Error - MessageNotUnderstood
	withExceptionDo: [:anError |
		self assert: anError messageText equals: ClientInterface expiredCreditCardErrorDescription .
		]
	 
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 04:31:22'!
test15ListPurcharcesIsEmptyForANewUserId
	
	| clientInterface cartDatabase cartId |
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
		
	cartId := clientInterface createCartForClient: 1 withPassword: testObjectsFactory validPassword .
	
	self assert: (clientInterface listPurchasesOfClientWithID: 1 withPassword: testObjectsFactory validPassword) equals: Bag new.
	
	

	
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 04:31:15'!
test16ListPurchacesShowsPurchasesOfAValidClientWithPurchases

	
	| clientInterface cartDatabase cartId expectedPurchaseList |
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
		
	cartId := clientInterface createCartForClient: 1 withPassword: testObjectsFactory validPassword .
	
	clientInterface addToCartWithID: cartId theBook: testObjectsFactory itemSoldByTheStore inQuantity: 2.
	clientInterface checkoutCartWithID: cartId  withCreditCardNumbered: '1111111111111111' cardExpiryDate: '12/2026' cardOwner: 'Juan Perez'.
	
	expectedPurchaseList := Bag with: testObjectsFactory itemSoldByTheStore with: testObjectsFactory itemSoldByTheStore .
	
	self assert: (clientInterface listPurchasesOfClientWithID: 1 withPassword: testObjectsFactory validPassword) equals: expectedPurchaseList.
	
	

	
	! !

!ClientInterfaceTest methodsFor: 'tests' stamp: 'eaam 11/9/2023 04:30:58'!
test17CantListPurchacesOfAInalidClient
	
	| clientInterface cartDatabase |
	cartDatabase := Dictionary new.
	clientInterface := ClientInterface forCartDatabase: cartDatabase 
		merchantProcessor: self 
		catalog: testObjectsFactory defaultCatalog 
		passwordAuthenticator: self currentDate: (Month month: 1 year: 2025).
		
	passwordAuthenticator := [:clientId :password | 
		clientInterface error: ClientInterface clientIsNotRegisteredErrorDescription.
		].
	
	self should: [clientInterface listPurchasesOfClientWithID: 1 withPassword: testObjectsFactory invalidPassword]
	raise: Error
	withExceptionDo: [:anError | 
		self assert: anError messageText equals: ClientInterface clientIsNotRegisteredErrorDescription.
		]
	

	
	! !


!ClientInterfaceTest methodsFor: 'as yet unclassified' stamp: 'Sof D 11/8/2023 02:55:40'!
debit: anAmount from: aCreditCard 

	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

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


!Cart methodsFor: 'as yet unclassified' stamp: 'Sof D 11/8/2023 01:36:39'!
listCart
	^items copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total client'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

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

!classDefinition: 'Cashier class' category: 'TusLibros'!
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


!classDefinition: #ClientInterface category: 'TusLibros'!
Object subclass: #ClientInterface
	instanceVariableNames: 'passwordAuthenticator cartsIds cartDatabase catalog merchantProcessor currentDate salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ClientInterface methodsFor: 'initialization' stamp: 'eaam 11/9/2023 03:53:42'!
initializeWithCartDatabase: aDatabaseOfCarts merchantProcessor: aMerchantProcessor catalog: aCatalog passwordAuthenticator: aPasswordAuthenticator currentDate: theCurrentDate 
	passwordAuthenticator := aPasswordAuthenticator.
	cartsIds := OrderedCollection new.
	cartDatabase := aDatabaseOfCarts.
	catalog := aCatalog .
	
	currentDate :=  theCurrentDate .
	
	merchantProcessor := aMerchantProcessor .
	
	salesBook := OrderedCollection new.! !


!ClientInterface methodsFor: 'asseting' stamp: 'Sof D 11/8/2023 02:02:55'!
assertInDatabaseTheCartId: aCartId

	^ (cartDatabase includesKey: aCartId) ifFalse: [self error: self class cartDoesntExistErrorDescription]! !

!ClientInterface methodsFor: 'asseting' stamp: 'eaam 11/9/2023 02:46:35'!
assertIsInCatalogTheBook: aBookToAdd AndIsGreaterThanTwo: aQuantityToAdd

	(catalog includesKey: aBookToAdd) ifFalse: [ self error: self class invalidItemErrorDescription ].
	(aQuantityToAdd > 0) ifFalse: [ self error: self class invalidItemAmountErrorDescription ]! !


!ClientInterface methodsFor: 'as yet unclassified' stamp: 'eaam 11/9/2023 02:46:35'!
addToCartWithID: aCartId theBook: aBookToAdd inQuantity: aQuantityToAdd
	self assertInDatabaseTheCartId: aCartId.
	
	self assertIsInCatalogTheBook: aBookToAdd AndIsGreaterThanTwo: aQuantityToAdd.
	(cartDatabase at: aCartId) addItem: aBookToAdd  inAmount: aQuantityToAdd.! !

!ClientInterface methodsFor: 'as yet unclassified' stamp: 'eaam 11/9/2023 04:36:31'!
allPurchasesOfClientId: aClientIdToGetAllThePurchases

	^ ((self salesForClientId: aClientIdToGetAllThePurchases) inject: OrderedCollection new into: [:listOfPurchases :aSale | listOfPurchases addAll: aSale ItemsBought]) asBag! !

!ClientInterface methodsFor: 'as yet unclassified' stamp: 'eaam 11/9/2023 04:08:34'!
checkoutCartWithID: aCartId withCreditCardNumbered: theNumberOfTheCreditCardToCharge cardExpiryDate: theExpiryDateOfTheCard cardOwner: theNameOfTheCardOwner
	| cashier cart card |
	self assertInDatabaseTheCartId: aCartId .

	cart :=  cartDatabase at: aCartId.
	
	((self listCartWithID: aCartId ) isEmpty) ifTrue: [ self error: self class cannotCheckoutEmptyCartErrorDescription ].
	
	card := CreditCard expiringOn: (Month month: ((theExpiryDateOfTheCard copyFrom: 1 to: 2) asNumber )year: ((theExpiryDateOfTheCard copyFrom: 4 to: 7) asNumber)).
	
	(card isExpiredOn: currentDate) ifTrue: [ self error: self class expiredCreditCardErrorDescription ].
	
	cashier := Cashier toCheckout: cart  charging: card throught: merchantProcessor on: currentDate registeringOn: salesBook forClient: 1.
	cashier checkOut .
	
	
	
	^true
	! !

!ClientInterface methodsFor: 'as yet unclassified' stamp: 'Sof D 11/9/2023 01:45:22'!
createCartForClient:  aClientToCheck withPassword: aPasswordToCheck
	| cartId |
	passwordAuthenticator validateClientId: aClientToCheck withPassword: aPasswordToCheck.
	cartId := self nextCartId.
	cartDatabase at: cartId put: (Cart acceptingItemsOf: catalog).
	
	^cartId! !

!ClientInterface methodsFor: 'as yet unclassified' stamp: 'Sof D 11/8/2023 02:40:34'!
listCartWithID: aCartId	self assertInDatabaseTheCartId: aCartId.

	^(cartDatabase at: aCartId) listCart! !

!ClientInterface methodsFor: 'as yet unclassified' stamp: 'eaam 11/9/2023 04:34:29'!
listPurchasesOfClientWithID: theIdOfTheClientToListThePurchasesOf withPassword: aPassword  

	passwordAuthenticator validateClientId: theIdOfTheClientToListThePurchasesOf withPassword: aPassword.
	

	^ self allPurchasesOfClientId: theIdOfTheClientToListThePurchasesOf.! !

!ClientInterface methodsFor: 'as yet unclassified' stamp: 'Sof D 11/6/2023 21:46:44'!
nextCartId
	^0! !

!ClientInterface methodsFor: 'as yet unclassified' stamp: 'eaam 11/9/2023 03:53:42'!
registerNewClientInSalesList: theIdOfTheNewClient
	(salesBook includesKey: theIdOfTheNewClient) ifFalse: [ salesBook at: theIdOfTheNewClient put: Bag new ]! !

!ClientInterface methodsFor: 'as yet unclassified' stamp: 'eaam 11/9/2023 04:33:01'!
salesForClientId: theIdOfTheClientToListThePurchasesOf

	^ salesBook select: [:aSale | aSale isFromClient: theIdOfTheClientToListThePurchasesOf]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClientInterface class' category: 'TusLibros'!
ClientInterface class
	instanceVariableNames: ''!

!ClientInterface class methodsFor: 'as yet unclassified' stamp: 'Sof D 11/9/2023 04:13:51'!
cannotCheckoutEmptyCartErrorDescription
	^'Cannot checkout empty cart'! !

!ClientInterface class methodsFor: 'as yet unclassified' stamp: 'Sof D 11/8/2023 01:42:43'!
cartDoesntExistErrorDescription
	^'Cart id is not registered'! !

!ClientInterface class methodsFor: 'as yet unclassified' stamp: 'Sof D 11/8/2023 01:41:22'!
clientIsNotRegisteredErrorDescription
	^'ups!! You are not registered!! bakita el más grande papa'! !

!ClientInterface class methodsFor: 'as yet unclassified' stamp: 'Sof D 11/9/2023 04:21:55'!
expiredCreditCardErrorDescription
	^'Cant use expired credit card for payment'! !

!ClientInterface class methodsFor: 'as yet unclassified' stamp: 'Sof D 11/8/2023 02:54:26'!
forCartDatabase: aDatabaseOfCarts merchantProcessor: aMerchantProcessor catalog: aCatalog passwordAuthenticator: aPasswordAuthenticator currentDate: theCurrentDate 
	^self new initializeWithCartDatabase: aDatabaseOfCarts merchantProcessor: aMerchantProcessor catalog: aCatalog passwordAuthenticator: aPasswordAuthenticator currentDate: theCurrentDate ! !

!ClientInterface class methodsFor: 'as yet unclassified' stamp: 'Sof D 11/9/2023 04:07:56'!
invalidItemAmountErrorDescription
	^'Item amount must be positive'! !

!ClientInterface class methodsFor: 'as yet unclassified' stamp: 'Sof D 11/9/2023 04:01:54'!
invalidItemErrorDescription
	^'Selected item isnt sold by catalog'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration clientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'eaam 11/9/2023 04:01:06'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth. 
	clientId := 1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total clientId ItemsBought'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

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

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'eaam 11/9/2023 04:17:42'!
of: aTotal forClient: aClientId withItems: aBagOfItemsBoughtByTheClient 

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal forClient: aClientId withItems: aBagOfItemsBoughtByTheClient ! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

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
