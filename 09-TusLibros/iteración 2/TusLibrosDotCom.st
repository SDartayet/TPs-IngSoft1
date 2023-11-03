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

!CreditCard methodsFor: 'as yet unclassified' stamp: 'eaam 11/2/2023 21:08:53'!
initializeWithId: aId withMonthOfYear: aMonthOfYear withName: aName
	id := aId.
	expireDate := aMonthOfYear.
	name := aName.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'eaam 11/2/2023 21:16:07'!
isExpiredForDate: aDate
	^ expireDate < aDate! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'eaam 11/2/2023 21:16:17'!
isExpiredForMonthOfYear: aDate
	^ expireDate < aDate! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibrosDotCom-Ejercicio'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'eaam 11/2/2023 21:06:20'!
withId: aId withMonthOfYear: aMonthOfYear withName: aName
	^self new initializeWithId: aId withMonthOfYear: aMonthOfYear withName: aName.! !


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


!TusLibrosCart methodsFor: 'adding' stamp: 'eaam 11/2/2023 18:06:09'!
addBook: anBookToAddToCart quantity: theQuantityToBeAdded
	self assertBookISBNIsInCatalog: anBookToAddToCart.
	self assertValidQuantity: theQuantityToBeAdded.
	
	contents add: anBookToAddToCart withOccurrences: theQuantityToBeAdded 
	! !


!TusLibrosCart methodsFor: 'initialization' stamp: 'eaam 11/2/2023 21:44:30'!
initializeWith: aListOfBooksThatCanBeAddedToCart 
	contents := Bag new.
	catalog := aListOfBooksThatCanBeAddedToCart .! !


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



!classDefinition: #TusLibrosStoreCashier category: 'TusLibrosDotCom-Ejercicio'!
Object subclass: #TusLibrosStoreCashier
	instanceVariableNames: 'cart card purchaseAmount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosDotCom-Ejercicio'!

!TusLibrosStoreCashier methodsFor: 'check out' stamp: 'eaam 11/3/2023 00:55:40'!
checkOutCart
	self assertCartIsEmpty.
	purchaseAmount := 'Total: ', cart total asString .
	^purchaseAmount.! !


!TusLibrosStoreCashier methodsFor: 'initialization' stamp: 'eaam 11/3/2023 00:55:40'!
initializeForCart:  aCartToCheckOut forCard: aCard 
	cart := aCartToCheckOut.
	card := aCard.
	purchaseAmount := ''.! !


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

!TusLibrosStoreCashier class methodsFor: 'instance creation' stamp: 'eaam 11/2/2023 21:33:35'!
withCheckOutCart: aCartToCheckOut withCard: aCardToCheckDate  withDate: aDateToCheck
	(aCardToCheckDate isExpiredForDate: aDateToCheck) ifTrue: [self error: self expiredCreditCardErrorDescription ].
	^self new initializeForCart:  aCartToCheckOut forCard: aCardToCheckDate.! !
