!classDefinition: #CartTests category: 'TusLibrosDotCom-Tests'!
TestCase subclass: #CartTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosDotCom-Tests'!

!CartTests methodsFor: 'tests' stamp: 'Sof D 10/30/2023 20:30:22'!
test01CartStartsOutEmpty
	| cart |
	cart := TusLibrosCart withValidBooks: OrderedCollection new.
	
	self assert: cart isEmpty.! !

!CartTests methodsFor: 'tests' stamp: 'Sof D 10/30/2023 20:30:53'!
test02CartCanAddBook
	| cart item |
	item := '0321146530'.

	cart := TusLibrosCart withValidBooks: (OrderedCollection with: item).
	cart addBook: item quantity: 1.
	
	self assert: (cart hasBook: item). self deny: cart isEmpty ! !

!CartTests methodsFor: 'tests' stamp: 'Sof D 10/30/2023 20:31:08'!
test03CartCanAddMultipleBooks
	| cart item anotherItem |
	item := '0321146530'.
	anotherItem := '1933988274'.
	cart := TusLibrosCart withValidBooks: (OrderedCollection with: item with: anotherItem).

	cart addBook: item quantity: 1. 	cart addBook: anotherItem quantity: 1.
	
	self assert: (cart hasBook: item). 	self assert: (cart hasBook: anotherItem ).! !

!CartTests methodsFor: 'tests' stamp: 'Sof D 10/30/2023 20:31:28'!
test04CartCanAddMultipleOfTheSameBook
	| cart item |
	item := '0321146530'.
	cart := TusLibrosCart withValidBooks: (OrderedCollection with: item).

	cart addBook: item quantity: 2. 
	
	self assert: (cart hasBook: item inQuantity: 2). 	! !

!CartTests methodsFor: 'tests' stamp: 'Sof D 10/30/2023 20:31:46'!
test05CartCanAddMultipleCopiesOfMultipleBooks
	| cart item anotherItem |
	item := '0321146530'.
	anotherItem := '9780330258647'.
	cart := TusLibrosCart withValidBooks: (OrderedCollection with: item with: anotherItem ).

	cart addBook: item quantity: 2. 
	cart addBook: anotherItem quantity: 42.
	
	
	self assert: (cart hasBook: item inQuantity: 2). 	self assert: (cart hasBook: anotherItem inQuantity: 42).! !

!CartTests methodsFor: 'tests' stamp: 'Sof D 10/30/2023 20:32:09'!
test06CartCanShowItsContents
	| cart item anotherItem expectedItems |
	item := '0321146530'.
	anotherItem := '1933988274'.
	cart := TusLibrosCart withValidBooks: (OrderedCollection with: item with: anotherItem ).

	cart addBook: item quantity: 1. 	cart addBook: anotherItem quantity: 2.

	expectedItems := Dictionary new.
	expectedItems at: item put: 1; at: anotherItem put: 2 .
	
	self assert: cart contents equals: expectedItems .! !

!CartTests methodsFor: 'tests' stamp: 'Sof D 10/30/2023 20:29:07'!
test07CartCantAddBookWithinvalidISBN
	| cart item availableBooks |
	
	availableBooks := OrderedCollection new.
	availableBooks add: '9780330258647'.
	cart := TusLibrosCart withValidBooks: availableBooks .
	item := '0321146530'.
	
	self should: [ cart addBook: item quantity: 1 ]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = TusLibrosCart bookNotAvailableErrorDescription.
		self deny: (cart hasBook: item).
		 ]! !

!CartTests methodsFor: 'tests' stamp: 'Sof D 10/30/2023 20:37:19'!
test08CartCantAddZeroOrNegativeAmountOfBooks
	| cart item availableBooks |
	
	availableBooks := OrderedCollection new.
	availableBooks add: '9780330258647'.
	cart := TusLibrosCart withValidBooks: availableBooks .
	item := '9780330258647'.
	
	self should: [ cart addBook: item quantity: -1 ]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = TusLibrosCart invalidBookQuantityErrorDescription.
		self deny: (cart hasBook: item).
		 ]! !

!CartTests methodsFor: 'tests' stamp: 'Sof D 10/30/2023 20:40:14'!
test09CartCantAddNonIntegerAmountOfBooks
	| cart item availableBooks |
	
	availableBooks := OrderedCollection new.
	availableBooks add: '9780330258647'.
	cart := TusLibrosCart withValidBooks: availableBooks .
	item := '9780330258647'.
	
	self should: [ cart addBook: item quantity: 0.42 ]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = TusLibrosCart invalidBookQuantityErrorDescription.
		self deny: (cart hasBook: item).
		 ]! !
!classDefinition: #TusLibrosCart category: 'TusLibrosDotCom-Ejercicio'!
Object subclass: #TusLibrosCart
	instanceVariableNames: 'contents availableBooks'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibrosDotCom-Ejercicio'!

!TusLibrosCart methodsFor: 'testing' stamp: 'Sof D 10/30/2023 20:07:37'!
hasBook: aBookToCheckIfItsInCart 
	^contents includesKey: aBookToCheckIfItsInCart! !

!TusLibrosCart methodsFor: 'testing' stamp: 'Sof D 10/30/2023 20:09:10'!
hasBook: aBookToCheckIfItsInCart inQuantity: aQuantityOfTheBook
	^(contents at: aBookToCheckIfItsInCart) = aQuantityOfTheBook 
! !

!TusLibrosCart methodsFor: 'testing' stamp: 'Sof D 10/30/2023 20:07:46'!
isEmpty
	^contents isEmpty ! !


!TusLibrosCart methodsFor: 'accessing' stamp: 'Sof D 10/30/2023 20:07:55'!
contents
	^contents copy! !


!TusLibrosCart methodsFor: 'cart management' stamp: 'Sof D 10/30/2023 20:42:31'!
addBook: anItemToAddToCart quantity: theQuantityToBeAdded
	self validateBookISBN: anItemToAddToCart.
	self validateQuantity: theQuantityToBeAdded.
	
	contents at: anItemToAddToCart put: theQuantityToBeAdded 
	! !


!TusLibrosCart methodsFor: 'initialization' stamp: 'Sof D 10/30/2023 20:19:31'!
initializeWith: aListOfBooksThatCanBeAddedToCart 
	contents := Dictionary new.
	availableBooks := aListOfBooksThatCanBeAddedToCart .! !


!TusLibrosCart methodsFor: 'input validation' stamp: 'Sof D 10/30/2023 20:42:06'!
validateBookISBN: anItemToValidateTheISBNOf

	 (availableBooks includes: anItemToValidateTheISBNOf) ifFalse: [ self error: self class bookNotAvailableErrorDescription ].! !

!TusLibrosCart methodsFor: 'input validation' stamp: 'Sof D 10/30/2023 20:42:31'!
validateQuantity: aQuantityToValidate

	^ (aQuantityToValidate > 0 and: aQuantityToValidate isInteger) ifFalse: [ self error: self class invalidBookQuantityErrorDescription ]! !

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
