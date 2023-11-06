!classDefinition: #MerchantProcessorInterfaceTest category: 'TusLibrosDotCom-Tests'!
TestCase subclass: #MerchantProcessorInterfaceTest
	instanceVariableNames: 'invalidName validName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosDotCom-Tests'!

!MerchantProcessorInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/6/2023 14:36:24'!
test01MPCanProcessTransactionWithValidCard

	| MPinterface  validCreditCardList validCreditCard |
	validCreditCardList := Dictionary new. validCreditCardList at: '0000000000000111' put: 50.
	
	
	MPinterface := MerchantProcessorInterface for: validCreditCardList .
	MPinterface processTransactionWithCreditCardNumber: '0000000000000111' withName: validName withExpiryDate: (December of: 2023) withCurrentDate: (January of: 2023) withTransactionamount: '50.00'.
	
	self assert: MPinterface transactionSuccess equals: true.	
! !

!MerchantProcessorInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/6/2023 14:36:37'!
test02MPFailsOnCardWithNumberThatsTooShort

	| MPinterface validCreditCardList |
	validCreditCardList := Dictionary new. validCreditCardList at: '00000000' put: 50.	
	
	MPinterface := MerchantProcessorInterface for: validCreditCardList .
	
	self should: [ 	MPinterface processTransactionWithCreditCardNumber: '00000000' withName: validName withExpiryDate: (December of: 2023) withCurrentDate: (January of: 2023) withTransactionamount: '50.00'
]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = MerchantProcessorInterface invalidCreditCardNumberLengthErrorDescription.
		self assert: MPinterface transactionSuccess equals: false.	

		
		 ]
! !

!MerchantProcessorInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/6/2023 14:36:51'!
test03MPFailsOnCardNumberThatsTooLong

	| MPinterface validCreditCardList |
	validCreditCardList := Dictionary new. validCreditCardList at: '0000000000000000000' put: 50.	
	
	MPinterface := MerchantProcessorInterface for: validCreditCardList .
	
	self should: [ MPinterface processTransactionWithCreditCardNumber: '0000000000000000000' withName: validName withExpiryDate: (December of: 2023) withCurrentDate: (January of: 2023) withTransactionamount: '50.00' ]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = MerchantProcessorInterface invalidCreditCardNumberLengthErrorDescription.
		self assert: MPinterface transactionSuccess equals: false.	

		 ]
! !

!MerchantProcessorInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/6/2023 14:37:03'!
test04MPFailsOnExpiredCard

	| MPinterface validCreditCardList |
	validCreditCardList := Dictionary new. validCreditCardList at: '0000000000000000'  put: 50.	
	
	MPinterface := MerchantProcessorInterface for: validCreditCardList .
	
	self should: [ MPinterface processTransactionWithCreditCardNumber: '0000000000000000' withName: validName withExpiryDate: (December of: 2022) withCurrentDate: (January of: 2023) withTransactionamount: '50.00']
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = MerchantProcessorInterface expiredCreditCardErrorDescription.
		self assert: MPinterface transactionSuccess equals: false.	
		 ]
! !

!MerchantProcessorInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/6/2023 14:37:09'!
test05MPFailsOnCardWithEmptyName

	| MPinterface validCreditCardList |
	validCreditCardList := Dictionary new. validCreditCardList at: '0000000000000000'  put: 50.	
	
	MPinterface := MerchantProcessorInterface for: validCreditCardList .
	
	self should: [ MPinterface processTransactionWithCreditCardNumber: '0000000000000000' withName: '' withExpiryDate: (December of: 2024) withCurrentDate: (January of: 2023) withTransactionamount: '50.00' ]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = MerchantProcessorInterface invalidCreditCardNameErrorDescription.
		self assert: MPinterface transactionSuccess equals: false.	
		 ]
! !

!MerchantProcessorInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/6/2023 14:37:14'!
test06MPFailsOnCardWithNameThatsTooLong

	| MPinterface validCreditCardList |
	validCreditCardList := Dictionary new. validCreditCardList at: '0000000000000000'  put: 50.	
	
	MPinterface := MerchantProcessorInterface for: validCreditCardList .
	
	self should: [ MPinterface processTransactionWithCreditCardNumber: '0000000000000000' withName: invalidName withExpiryDate: (December of: 2024) withCurrentDate: (January of: 2023) withTransactionamount: '50.00' ]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = MerchantProcessorInterface invalidCreditCardNameErrorDescription.
		self assert: MPinterface transactionSuccess equals: false.	
		 ]
! !

!MerchantProcessorInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/6/2023 14:37:20'!
test07MPFailsOnTransactionAmountWithoutDecimal

	| MPinterface validCreditCardList |
	validCreditCardList := Dictionary new. validCreditCardList at: '0000000000000000'  put: 50.	
	
	MPinterface := MerchantProcessorInterface for: validCreditCardList .
	
	self should: [ MPinterface processTransactionWithCreditCardNumber: '0000000000000000' withName: validName withExpiryDate: (December of: 2024) withCurrentDate: (January of: 2023) withTransactionamount: '142']
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = MerchantProcessorInterface invalidTransactionAmountDecimalErrorDescription.
		self assert: MPinterface transactionSuccess equals: false.	
		 ]
! !

!MerchantProcessorInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/6/2023 14:37:27'!
test08MPFailsOnTransactionAmountWithDecimalOfOneDigit

	| MPinterface validCreditCardList |
	validCreditCardList := Dictionary new. validCreditCardList at: '0000000000000000'  put: 50.	
	
	MPinterface := MerchantProcessorInterface for: validCreditCardList .
	
	self should: [ MPinterface processTransactionWithCreditCardNumber: '0000000000000000' withName: validName withExpiryDate: (December of: 2024) withCurrentDate: (January of: 2023) withTransactionamount: '142.0']
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = MerchantProcessorInterface invalidTransactionAmountDecimalErrorDescription.
		self assert: MPinterface transactionSuccess equals: false.	
		 ]
! !

!MerchantProcessorInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/6/2023 14:37:33'!
test09MPFailsOnTransactionAmountWithoutIntegerPart

	| MPinterface validCreditCardList |
	validCreditCardList := Dictionary new. validCreditCardList at: '0000000000000000'  put: 50.	
	
	MPinterface := MerchantProcessorInterface for: validCreditCardList .
	
	self should: [ MPinterface processTransactionWithCreditCardNumber: '0000000000000000' withName: validName withExpiryDate: (December of: 2024) withCurrentDate: (January of: 2023) withTransactionamount: '.00']
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = MerchantProcessorInterface invalidTransactionAmountDecimalErrorDescription.
		self assert: MPinterface transactionSuccess equals: false.	
		 ]
! !

!MerchantProcessorInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/6/2023 14:37:38'!
test10MPFailsOnTransactionAmountWithIntegerPartLongerThan15Digits

	| MPinterface validCreditCardList |
	validCreditCardList := Dictionary new. validCreditCardList at: '0000000000000000'  put: 50.	
	
	MPinterface := MerchantProcessorInterface for: validCreditCardList .
	
	self should: [ MPinterface processTransactionWithCreditCardNumber: '0000000000000000' withName: validName withExpiryDate: (December of: 2024) withCurrentDate: (January of: 2023) withTransactionamount: '11111111111111111111111.00']
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = MerchantProcessorInterface invalidTransactionAmountIntegerErrorDescription.
		self assert: MPinterface transactionSuccess equals: false.	
		 ]
! !

!MerchantProcessorInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/6/2023 14:37:44'!
test11MPFailsOnTransactionAmountWithNonNumericElements

	| MPinterface validCreditCardList |
	validCreditCardList := Dictionary new. validCreditCardList at: '0000000000000000'  put: 50.	
	
	MPinterface := MerchantProcessorInterface for: validCreditCardList .
	
	self should: [ MPinterface processTransactionWithCreditCardNumber: '0000000000000000' withName: validName withExpiryDate: (December of: 2024) withCurrentDate: (January of: 2023) withTransactionamount: '-a11.00']
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = MerchantProcessorInterface invalidTransactionAmountIntegerErrorDescription.
		self assert: MPinterface transactionSuccess equals: false.	
		 ]
! !

!MerchantProcessorInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/6/2023 14:45:46'!
test12MPFailsOnCardWithInvalidNumber

	| MPinterface validCreditCardList |
	validCreditCardList := Dictionary new. validCreditCardList at: '0000000000000111' put: 50.	
	
	MPinterface := MerchantProcessorInterface for: validCreditCardList .
	
	self should: [ MPinterface processTransactionWithCreditCardNumber: '0000000000000000' withName: validName withExpiryDate: (December of: 2024) withCurrentDate: (January of: 2023) withTransactionamount: '49.00' ]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = MerchantProcessorInterface nonexistentCreditCardErrorDescription.
		self assert: MPinterface transactionSuccess equals: false.	
		 ]
! !

!MerchantProcessorInterfaceTest methodsFor: 'tests' stamp: 'Sof D 11/6/2023 14:41:39'!
test13MPFailsOnCardWithInsuficientCredit

	| MPinterface validCreditCardList |
	validCreditCardList := Dictionary new. validCreditCardList at: '0000000000000111' put: 50.	
	
	MPinterface := MerchantProcessorInterface for: validCreditCardList .
	
	self should: [ MPinterface processTransactionWithCreditCardNumber: '0000000000000111' withName: validName withExpiryDate: (December of: 2024) withCurrentDate: (January of: 2023) withTransactionamount: '51.00' ]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = MerchantProcessorInterface insuficientCreditErrorDescription.
		self assert: MPinterface transactionSuccess equals: false.	
		 ]
! !


!MerchantProcessorInterfaceTest methodsFor: 'setup' stamp: 'Sof D 11/6/2023 02:37:43'!
setUp
	invalidName := 'Jugemu Jugemu Go-Kou-no-Surikire Kaijari-suigyo no Suigyou-matsu Unrai-matsu Furai-matsu Kuu-Neru Tokoro ni Sumu Tokoro Yaburakoji no Burakouji Paipo Paipo Paipo no Shuringan Shuringan no Gurindai Gurindai no Ponpokopii no Ponpokonaa no Chokyumei no Chosuke'.
	validName := 'Juan Perez'! !


!classDefinition: #TusLibrosCartTests category: 'TusLibrosDotCom-Tests'!
TestCase subclass: #TusLibrosCartTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosDotCom-Tests'!

!TusLibrosCartTests methodsFor: 'tests' stamp: 'eaam 11/2/2023 21:45:39'!
test01CartStartsOutEmpty
	| cart |
	cart := TusLibrosCart withValidBooks: Dictionary new.
	
	self assert: cart isEmpty.! !

!TusLibrosCartTests methodsFor: 'tests' stamp: 'eaam 11/2/2023 21:49:18'!
test02CartCanAddBook
	| cart book catalog|
	book := '0321146530'.
	catalog := Dictionary new.
	cart := TusLibrosCart withValidBooks: (catalog at: book put: 42; yourself ).
	cart addBook: book quantity: 1.
	
	self assert: (cart hasBook: book). self deny: cart isEmpty ! !

!TusLibrosCartTests methodsFor: 'tests' stamp: 'eaam 11/2/2023 21:47:08'!
test03CartCanAddMultipleBooks
	| cart book anotherBook catalog|
	book := '0321146530'.
	anotherBook := '1933988274'.
	catalog := Dictionary new.
	cart := TusLibrosCart withValidBooks:  (catalog at: book put: 42; at: anotherBook put: 420; yourself).

	cart addBook: book quantity: 1. 	cart addBook: anotherBook quantity: 1.
	
	self assert: (cart hasBook: book). 	self assert: (cart hasBook: anotherBook ).! !

!TusLibrosCartTests methodsFor: 'tests' stamp: 'eaam 11/2/2023 21:50:10'!
test04CartCanAddMultipleOfTheSameBook
	| cart book catalog|
	book := '0321146530'.
	catalog := Dictionary new.
	cart := TusLibrosCart withValidBooks: (catalog at: book put: 42; yourself ).

	cart addBook: book quantity: 2. 
	
	self assert: (cart hasBook: book inQuantity: 2). 	! !

!TusLibrosCartTests methodsFor: 'tests' stamp: 'eaam 11/2/2023 21:51:05'!
test05CartCanAddMultipleCopiesOfMultipleBooks
	| cart book anotherBook catalog|
	book := '0321146530'.
	anotherBook := '9780330258647'.
	catalog := Dictionary new.
	cart := TusLibrosCart withValidBooks: (catalog at: book put: 42; at: anotherBook put: 420; yourself).

	cart addBook: book quantity: 2. 
	cart addBook: anotherBook quantity: 42.
	
	
	self assert: (cart hasBook: book inQuantity: 2). 	self assert: (cart hasBook: anotherBook inQuantity: 42).! !

!TusLibrosCartTests methodsFor: 'tests' stamp: 'eaam 11/2/2023 21:51:26'!
test06CartCanShowItsContents
	| cart book anotherBook expectedItems catalog|
	book := '0321146530'.
	anotherBook := '1933988274'.
	catalog := Dictionary new.
	cart := TusLibrosCart withValidBooks: (catalog at: book put: 42; at: anotherBook put: 420; yourself).

	cart addBook: book quantity: 1. 	cart addBook: anotherBook quantity: 2.

	expectedItems := Bag new.
	expectedItems add: book withOccurrences: 1; add: anotherBook withOccurrences: 2 .
	
	self assert: cart contents equals: expectedItems .! !

!TusLibrosCartTests methodsFor: 'tests' stamp: 'eaam 11/2/2023 21:52:06'!
test07CartCantAddBookWithinvalidISBN
	| cart book availableBooks |
	
	availableBooks := Dictionary new.
	availableBooks at: '9780330258647' put: 42.
	cart := TusLibrosCart withValidBooks: availableBooks .
	book := '0321146530'.
	
	self should: [ cart addBook: book quantity: 1 ]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = cart bookNotAvailableErrorDescription.
		self deny: (cart hasBook: book).
		 ]! !

!TusLibrosCartTests methodsFor: 'tests' stamp: 'eaam 11/2/2023 21:52:21'!
test08CartCantAddZeroOrNegativeAmountOfBooks
	| cart book availableBooks |
	
	availableBooks := Dictionary new.
	availableBooks at: '9780330258647' put: 42.
	cart := TusLibrosCart withValidBooks: availableBooks .
	book := '9780330258647'.
	
	self should: [ cart addBook: book quantity: -1 ]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = cart invalidBookQuantityErrorDescription.
		self deny: (cart hasBook: book).
		 ]! !

!TusLibrosCartTests methodsFor: 'tests' stamp: 'eaam 11/2/2023 21:52:28'!
test09CartCantAddNonIntegerAmountOfBooks
	| cart book availableBooks |
	
	availableBooks := Dictionary new.
	availableBooks at: '9780330258647' put: 42.
	cart := TusLibrosCart withValidBooks: availableBooks .
	book := '9780330258647'.
	
	self should: [ cart addBook: book quantity: 0.42 ]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = cart invalidBookQuantityErrorDescription.
		self deny: (cart hasBook: book).
		 ]! !


!classDefinition: #TusLibrosStoreCashierTest category: 'TusLibrosDotCom-Tests'!
TestCase subclass: #TusLibrosStoreCashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosDotCom-Tests'!

!TusLibrosStoreCashierTest methodsFor: 'as yet unclassified' stamp: 'eaam 11/2/2023 21:24:22'!
invalidCard
	^CreditCard withId: '1111111111111111' withMonthOfYear:  (December of: 2014) withName: 'Jorge Luis Borges'! !

!TusLibrosStoreCashierTest methodsFor: 'as yet unclassified' stamp: 'eaam 11/3/2023 01:02:28'!
test01ACashierCantCheckOutForAEmptyCart
	| emptyCart catalog cashier|
	catalog := OrderedCollection new.
	emptyCart := TusLibrosCart withValidBooks: catalog.
	cashier := TusLibrosStoreCashier withCheckOutCart: emptyCart withCard: self validCard withDate:  self testDate .
	
	self should: [ cashier checkOutCart]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = cashier emptyCartCheckOutErrorDescription.
		self assert: cashier hasNoPurchase.
		 ]! !

!TusLibrosStoreCashierTest methodsFor: 'as yet unclassified' stamp: 'eaam 11/2/2023 22:00:57'!
test02ACashierChecksOutACartWithOnlyOneBook
	| cart catalog cashier |
	
	catalog := Dictionary new.
	catalog at: 'Ficciones' put: 10000.
	cart := TusLibrosCart withValidBooks: catalog.
	cart addBook: 'Ficciones' quantity: 1.
	cashier := TusLibrosStoreCashier withCheckOutCart: cart withCard: self validCard withDate:  self testDate .
	self assert: (cashier checkOutCart) equals: 'Total: 10000'.! !

!TusLibrosStoreCashierTest methodsFor: 'as yet unclassified' stamp: 'eaam 11/3/2023 00:26:31'!
test03ACashierChecksOutACartWithMultipleBooks
	| cart catalog cashier |
	
	catalog := Dictionary new.
	catalog at: 'Ficciones' put: 10000; at: '9780330258647' put: 42; yourself .
	cart := TusLibrosCart withValidBooks: catalog.
	cart addBook: 'Ficciones' quantity: 1.
	cart addBook: '9780330258647' quantity: 1.
	cashier := TusLibrosStoreCashier withCheckOutCart: cart withCard: self validCard withDate:  self testDate .
	self assert: (cashier checkOutCart) equals: 'Total: 10042'.! !

!TusLibrosStoreCashierTest methodsFor: 'as yet unclassified' stamp: 'eaam 11/3/2023 00:52:18'!
test04ACashierCantChecksOutWithInvalidCard
	| cart catalog cashier |
	
	catalog := Dictionary new.
	catalog at: 'Ficciones' put: 10000.
	cart := TusLibrosCart withValidBooks: catalog.
	cart addBook: 'Ficciones' quantity: 1.
	
	self should: [cashier := TusLibrosStoreCashier withCheckOutCart: cart withCard: self invalidCard withDate: self testDate ]
	raise: Error
	withExceptionDo: [:anError |
		self assert: anError messageText equals: TusLibrosStoreCashier expiredCreditCardErrorDescription.
		self assert: cashier isNil.
		]! !

!TusLibrosStoreCashierTest methodsFor: 'as yet unclassified' stamp: 'eaam 11/2/2023 21:40:37'!
testDate
	^(December of: 2015)! !

!TusLibrosStoreCashierTest methodsFor: 'as yet unclassified' stamp: 'eaam 11/2/2023 21:24:12'!
validCard
	^CreditCard withId: '1111111111111111' withMonthOfYear:  (December of: 2022) withName: 'Jorge Luis Borges'! !
!classDefinition: #CreditCard category: 'TusLibrosDotCom-Ejercicio'!
Object subclass: #CreditCard
	instanceVariableNames: 'name expireDate id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosDotCom-Ejercicio'!

!CreditCard methodsFor: 'initialization' stamp: 'eaam 11/2/2023 21:08:53'!
initializeWithId: aId withMonthOfYear: aMonthOfYear withName: aName
	id := aId.
	expireDate := aMonthOfYear.
	name := aName.! !


!CreditCard methodsFor: 'validation' stamp: 'eaam 11/2/2023 21:16:07'!
isExpiredForDate: aDate
	^ expireDate < aDate! !

!CreditCard methodsFor: 'validation' stamp: 'eaam 11/2/2023 21:16:17'!
isExpiredForMonthOfYear: aDate
	^ expireDate < aDate! !


!CreditCard methodsFor: 'accessing' stamp: 'Sof D 11/6/2023 04:56:21'!
cardExpiryDate
	^expireDate ! !

!CreditCard methodsFor: 'accessing' stamp: 'Sof D 11/6/2023 04:56:13'!
cardName
	^name! !

!CreditCard methodsFor: 'accessing' stamp: 'Sof D 11/6/2023 04:56:08'!
cardNumber
	^id! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibrosDotCom-Ejercicio'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'eaam 11/2/2023 21:06:20'!
withId: aId withMonthOfYear: aMonthOfYear withName: aName
	^self new initializeWithId: aId withMonthOfYear: aMonthOfYear withName: aName.! !


!classDefinition: #MerchantProcessorInterface category: 'TusLibrosDotCom-Ejercicio'!
Object subclass: #MerchantProcessorInterface
	instanceVariableNames: 'cardsWithCredit transactionSuccess'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosDotCom-Ejercicio'!

!MerchantProcessorInterface methodsFor: 'transaction processing' stamp: 'Sof D 11/6/2023 14:46:19'!
processTransactionWithCreditCardNumber: theNumberOfTheCardToUse withName: theNameOnTheCardToUse withExpiryDate: theExpiryDateOnTheCard withCurrentDate: theCurrentMonthOfYear withTransactionamount: theAmountToCharge   
	self isNumberLengthValid: theNumberOfTheCardToUse .
	self isExpiryDate: theExpiryDateOnTheCard laterThan: theCurrentMonthOfYear.
	self isNameValid: theNameOnTheCardToUse.
	self isAmountValid: theAmountToCharge .
	self canChargeCard: theNumberOfTheCardToUse withAmount: theAmountToCharge asNumber.
	
	transactionSuccess := true.
	
	 ! !


!MerchantProcessorInterface methodsFor: 'input validation' stamp: 'Sof D 11/6/2023 14:48:08'!
canChargeCard: theNumberOfTheCardToUse withAmount: theAmountToCharge  .
	(cardsWithCredit includesKey: theNumberOfTheCardToUse) ifFalse: [ self error: self class nonexistentCreditCardErrorDescription ].
	((cardsWithCredit at: theNumberOfTheCardToUse) >= theAmountToCharge) ifFalse: [ self error: self class insuficientCreditErrorDescription ].! !

!MerchantProcessorInterface methodsFor: 'input validation' stamp: 'Sof D 11/6/2023 14:32:38'!
isAmountNumeric: theAmountToCharge
	| validCharacters zeroToNine |
	zeroToNine := '0123456789.'.
	validCharacters := Set new.
	zeroToNine do: [ : aNumberCharacter | validCharacters add: aNumberCharacter ].
	^theAmountToCharge inject: true into: [ : acc : aNumericElement | acc and: (validCharacters includes: aNumericElement) ]! !

!MerchantProcessorInterface methodsFor: 'input validation' stamp: 'Sof D 11/6/2023 14:14:53'!
isAmountValid: theAmountToCharge 
	((theAmountToCharge size) >= 4 and: (self transactionAmountHasDecimalDotAndTwoDecimalDigits: theAmountToCharge)) ifFalse: [ self error: self class invalidTransactionAmountDecimalErrorDescription ].
	((theAmountToCharge size <= 15) and: (self isAmountNumeric: theAmountToCharge)) ifFalse: [ self error: self class invalidTransactionAmountIntegerErrorDescription ]
! !

!MerchantProcessorInterface methodsFor: 'input validation' stamp: 'Sof D 11/6/2023 02:40:31'!
isExpiryDate: theExpiryDateOnTheCard laterThan: theCurrentMonthOfYear

	(theExpiryDateOnTheCard > theCurrentMonthOfYear) ifFalse: [ self error: self class expiredCreditCardErrorDescription ]! !

!MerchantProcessorInterface methodsFor: 'input validation' stamp: 'Sof D 11/6/2023 02:43:43'!
isNameValid: theNameOnTheCardToUse

	((theNameOnTheCardToUse isEmpty) or: (theNameOnTheCardToUse size > 30)) ifTrue: [ self error: self class invalidCreditCardNameErrorDescription ]! !

!MerchantProcessorInterface methodsFor: 'input validation' stamp: 'Sof D 11/6/2023 02:40:51'!
isNumberLengthValid: theNumberOfTheCardToUse

	^ (theNumberOfTheCardToUse size = 16) ifFalse: [ self error: self class invalidCreditCardNumberLengthErrorDescription ]! !

!MerchantProcessorInterface methodsFor: 'input validation' stamp: 'Sof D 11/6/2023 03:28:44'!
transactionAmountHasDecimalDotAndTwoDecimalDigits: theAmountToCharge
	^( (theAmountToCharge at: ((theAmountToCharge size) - 2)) isEqualTo: $. )! !


!MerchantProcessorInterface methodsFor: 'initialization' stamp: 'Sof D 11/6/2023 14:25:39'!
initializeWith: aListOfValidCreditCardsAndTheirCredit
	cardsWithCredit := aListOfValidCreditCardsAndTheirCredit . 
	transactionSuccess := false.
	! !


!MerchantProcessorInterface methodsFor: 'transaction results' stamp: 'Sof D 11/6/2023 04:45:41'!
transactionSuccess
	^transactionSuccess ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorInterface class' category: 'TusLibrosDotCom-Ejercicio'!
MerchantProcessorInterface class
	instanceVariableNames: ''!

!MerchantProcessorInterface class methodsFor: 'error handling' stamp: 'Sof D 11/6/2023 02:08:47'!
expiredCreditCardErrorDescription
	^'Credit card must not be expired'! !

!MerchantProcessorInterface class methodsFor: 'error handling' stamp: 'Sof D 11/6/2023 14:42:31'!
insuficientCreditErrorDescription
	^'The selected card does not have enough credit'! !

!MerchantProcessorInterface class methodsFor: 'error handling' stamp: 'Sof D 11/6/2023 02:37:02'!
invalidCreditCardNameErrorDescription
	^'Card name must not be empty or longer than 30 characters'! !

!MerchantProcessorInterface class methodsFor: 'error handling' stamp: 'Sof D 11/6/2023 01:59:44'!
invalidCreditCardNumberLengthErrorDescription
	^'Credit card number must be 16 digits'! !

!MerchantProcessorInterface class methodsFor: 'error handling' stamp: 'Sof D 11/6/2023 03:31:49'!
invalidTransactionAmountDecimalErrorDescription
	^'Transaction amount decimal must be two digits and separated by a dot'! !

!MerchantProcessorInterface class methodsFor: 'error handling' stamp: 'Sof D 11/6/2023 03:34:00'!
invalidTransactionAmountIntegerErrorDescription
	^'Transaction amount must be shorter than 19 digits and positive'! !

!MerchantProcessorInterface class methodsFor: 'error handling' stamp: 'Sof D 11/6/2023 14:38:38'!
nonexistentCreditCardErrorDescription
	^'Credit card with selected number does not exist'! !


!MerchantProcessorInterface class methodsFor: 'instance creation' stamp: 'Sof D 11/6/2023 14:12:02'!
for: aListOfValidCreditCardsAndTheirCredit
	^self new initializeWith: aListOfValidCreditCardsAndTheirCredit ! !


!classDefinition: #TusLibrosCart category: 'TusLibrosDotCom-Ejercicio'!
Object subclass: #TusLibrosCart
	instanceVariableNames: 'contents catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosDotCom-Ejercicio'!

!TusLibrosCart methodsFor: 'testing' stamp: 'eaam 11/2/2023 18:05:01'!
hasBook: aBookToCheckIfItsInCart 
	^contents includes: aBookToCheckIfItsInCart! !

!TusLibrosCart methodsFor: 'testing' stamp: 'eaam 11/2/2023 18:06:42'!
hasBook: aBookToCheckIfItsInCart inQuantity: aQuantityOfTheBook
	^(contents occurrencesOf: aBookToCheckIfItsInCart) = aQuantityOfTheBook 
! !

!TusLibrosCart methodsFor: 'testing' stamp: 'Sof D 10/30/2023 20:07:46'!
isEmpty
	^contents isEmpty ! !


!TusLibrosCart methodsFor: 'accessing' stamp: 'Sof D 10/30/2023 20:07:55'!
contents
	^contents copy! !

!TusLibrosCart methodsFor: 'accessing' stamp: 'eaam 11/2/2023 22:00:27'!
total
	^contents sum: [:aBook | (contents occurrencesOf: aBook)*(catalog at: aBook)]! !



!TusLibrosCart methodsFor: 'initialization' stamp: 'eaam 11/2/2023 21:44:30'!
initializeWith: aListOfBooksThatCanBeAddedToCart 
	contents := Bag new.
	catalog := aListOfBooksThatCanBeAddedToCart .! !


!TusLibrosCart methodsFor: 'input validation' stamp: 'Sof D 10/30/2023 20:42:06'!
validateBookISBN: anItemToValidateTheISBNOf

	 (availableBooks includes: anItemToValidateTheISBNOf) ifFalse: [ self error: self class bookNotAvailableErrorDescription ].! !

!TusLibrosCart methodsFor: 'input validation' stamp: 'Sof D 10/30/2023 20:42:31'!
validateQuantity: aQuantityToValidate

	^ (aQuantityToValidate > 0 and: aQuantityToValidate isInteger) ifFalse: [ self error: self class invalidBookQuantityErrorDescription ]! !


!TusLibrosCart methodsFor: 'adding' stamp: 'eaam 11/2/2023 18:06:09'!
addBook: anBookToAddToCart quantity: theQuantityToBeAdded
	self assertBookISBNIsInCatalog: anBookToAddToCart.
	self assertValidQuantity: theQuantityToBeAdded.
	
	contents add: anBookToAddToCart withOccurrences: theQuantityToBeAdded 
	! !


!TusLibrosCart methodsFor: 'error handling' stamp: 'eaam 11/2/2023 18:42:31'!
bookNotAvailableErrorDescription
	^'The book selected is not available'! !

!TusLibrosCart methodsFor: 'error handling' stamp: 'eaam 11/2/2023 18:42:22'!
invalidBookQuantityErrorDescription
	^'The amount of books has to be an integer greater than zero'! !


!TusLibrosCart methodsFor: 'asserting' stamp: 'eaam 11/2/2023 21:44:48'!
assertBookISBNIsInCatalog: anBookToValidateTheISBNOf

	 (catalog keys includes: anBookToValidateTheISBNOf) ifFalse: [ self error: self bookNotAvailableErrorDescription ].! !

!TusLibrosCart methodsFor: 'asserting' stamp: 'eaam 11/2/2023 18:50:48'!
assertValidQuantity: aQuantityToValidate

	(aQuantityToValidate > 0 and: aQuantityToValidate isInteger) ifFalse: [ self error: self invalidBookQuantityErrorDescription]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosCart class' category: 'TusLibrosDotCom-Ejercicio'!
TusLibrosCart class
	instanceVariableNames: ''!

!TusLibrosCart class methodsFor: 'instance creation' stamp: 'Sof D 10/30/2023 20:18:56'!
withValidBooks: aListOfBooksThatCanBeAddedToCart
	^self new initializeWith: aListOfBooksThatCanBeAddedToCart ! !


!TusLibrosCart class methodsFor: 'error descriptions' stamp: 'Sof D 10/30/2023 20:26:13'!
bookNotAvailableErrorDescription
	^'The book selected is not available'! !

!TusLibrosCart class methodsFor: 'error descriptions' stamp: 'Sof D 10/30/2023 20:39:00'!
invalidBookQuantityErrorDescription
	^'The amount of books has to be an integer greater than zero'! !


!classDefinition: #TusLibrosStoreCashier category: 'TusLibrosDotCom-Ejercicio'!
Object subclass: #TusLibrosStoreCashier
	instanceVariableNames: 'cart card purchaseAmount cardExpiryDate currentDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosDotCom-Ejercicio'!

!TusLibrosStoreCashier methodsFor: 'check out' stamp: 'Sof D 11/6/2023 04:57:28'!
checkOutCart
	| MPInterface totalIntegerPart totalDecimalPart amountString |
	self assertCartIsEmpty.
	purchaseAmount := 'Total: ', cart total asString .
	
	totalIntegerPart := (cart total integerPart) asString.
	totalDecimalPart := (cart total roundTo: 0.1) fractionPart asString.
	
	(totalDecimalPart size = 2) ifFalse: [ totalDecimalPart := totalDecimalPart, '0' ].
	 
	amountString := totalIntegerPart, totalDecimalPart .
	MPInterface := MerchantProcessorInterface new.
	MPInterface processTransactionWithCreditCardNumber: card cardNumber withName: card cardName withExpiryDate: card cardExpiryDate withCurrentDate: currentDate withTransactionamount: amountString.
	
	^purchaseAmount.! !


!TusLibrosStoreCashier methodsFor: 'initialization' stamp: 'eaam 11/3/2023 00:55:40'!
initializeForCart:  aCartToCheckOut forCard: aCard 
	cart := aCartToCheckOut.
	card := aCard.
	purchaseAmount := ''.! !

!TusLibrosStoreCashier methodsFor: 'initialization' stamp: 'Sof D 11/6/2023 04:55:44'!
initializeForCart:  aCartToCheckOut forCard: aCard forCurrentDate: theCurrentDate
	cart := aCartToCheckOut.
	card := aCard.
	purchaseAmount := ''.
	
	currentDate := theCurrentDate ! !


!TusLibrosStoreCashier methodsFor: 'asserting' stamp: 'eaam 11/3/2023 00:28:08'!
assertCartIsEmpty

	^ (cart isEmpty) ifTrue: [self error: self emptyCartCheckOutErrorDescription]! !


!TusLibrosStoreCashier methodsFor: 'error handling' stamp: 'eaam 11/2/2023 18:41:07'!
emptyCartCheckOutErrorDescription
	^'Cant check out a empty cart!!'.! !


!TusLibrosStoreCashier methodsFor: 'testing' stamp: 'eaam 11/3/2023 01:01:38'!
hasNoPurchase
	^purchaseAmount isEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosStoreCashier class' category: 'TusLibrosDotCom-Ejercicio'!
TusLibrosStoreCashier class
	instanceVariableNames: ''!

!TusLibrosStoreCashier class methodsFor: 'instance creation' stamp: 'eaam 11/2/2023 20:55:00'!
expiredCreditCardErrorDescription
	^'cant check out with a expired card'! !

!TusLibrosStoreCashier class methodsFor: 'instance creation' stamp: 'Sof D 11/6/2023 04:55:23'!
withCheckOutCart: aCartToCheckOut withCard: aCardToCheckDate  withDate: aDateToCheck
	(aCardToCheckDate isExpiredForDate: aDateToCheck) ifTrue: [self error: self expiredCreditCardErrorDescription ].
	^self new initializeForCart:  aCartToCheckOut forCard: aCardToCheckDate forCurrentDate: aDateToCheck .! !
