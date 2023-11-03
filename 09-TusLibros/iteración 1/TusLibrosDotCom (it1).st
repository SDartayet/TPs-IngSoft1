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

!CartTests methodsFor: 'tests' stamp: 'eaam 10/30/2023 23:21:15'!
test02CartCanAddBook
	| cart book |
	book := '0321146530'.

	cart := TusLibrosCart withValidBooks: (OrderedCollection with: book).
	cart addBook: book quantity: 1.
	
	self assert: (cart hasBook: book). self deny: cart isEmpty ! !

!CartTests methodsFor: 'tests' stamp: 'eaam 10/30/2023 23:21:39'!
test03CartCanAddMultipleBooks
	| cart book anotherBook |
	book := '0321146530'.
	anotherBook := '1933988274'.
	cart := TusLibrosCart withValidBooks: (OrderedCollection with: book with: anotherBook).

	cart addBook: book quantity: 1. 	cart addBook: anotherBook quantity: 1.
	
	self assert: (cart hasBook: book). 	self assert: (cart hasBook: anotherBook ).! !

!CartTests methodsFor: 'tests' stamp: 'eaam 10/30/2023 23:21:52'!
test04CartCanAddMultipleOfTheSameBook
	| cart book |
	book := '0321146530'.
	cart := TusLibrosCart withValidBooks: (OrderedCollection with: book).

	cart addBook: book quantity: 2. 
	
	self assert: (cart hasBook: book inQuantity: 2). 	! !

!CartTests methodsFor: 'tests' stamp: 'eaam 10/30/2023 23:20:46'!
test05CartCanAddMultipleCopiesOfMultipleBooks
	| cart book anotherBook |
	book := '0321146530'.
	anotherBook := '9780330258647'.
	cart := TusLibrosCart withValidBooks: (OrderedCollection with: book with: anotherBook ).

	cart addBook: book quantity: 2. 
	cart addBook: anotherBook quantity: 42.
	
	
	self assert: (cart hasBook: book inQuantity: 2). 	self assert: (cart hasBook: anotherBook inQuantity: 42).! !

!CartTests methodsFor: 'tests' stamp: 'eaam 10/30/2023 23:20:18'!
test06CartCanShowItsContents
	| cart book anotherBook expectedItems |
	book := '0321146530'.
	anotherBook := '1933988274'.
	cart := TusLibrosCart withValidBooks: (OrderedCollection with: book with: anotherBook ).

	cart addBook: book quantity: 1. 	cart addBook: anotherBook quantity: 2.

	expectedItems := Dictionary new.
	expectedItems at: book put: 1; at: anotherBook put: 2 .
	
	self assert: cart contents equals: expectedItems .! !

!CartTests methodsFor: 'tests' stamp: 'eaam 10/30/2023 23:19:57'!
test07CartCantAddBookWithinvalidISBN
	| cart book availableBooks |
	
	availableBooks := OrderedCollection new.
	availableBooks add: '9780330258647'.
	cart := TusLibrosCart withValidBooks: availableBooks .
	book := '0321146530'.
	
	self should: [ cart addBook: book quantity: 1 ]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = TusLibrosCart bookNotAvailableErrorDescription.
		self deny: (cart hasBook: book).
		 ]! !

!CartTests methodsFor: 'tests' stamp: 'eaam 10/30/2023 23:19:50'!
test08CartCantAddZeroOrNegativeAmountOfBooks
	| cart book availableBooks |
	
	availableBooks := OrderedCollection new.
	availableBooks add: '9780330258647'.
	cart := TusLibrosCart withValidBooks: availableBooks .
	book := '9780330258647'.
	
	self should: [ cart addBook: book quantity: -1 ]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = TusLibrosCart invalidBookQuantityErrorDescription.
		self deny: (cart hasBook: book).
		 ]! !

!CartTests methodsFor: 'tests' stamp: 'eaam 10/30/2023 23:19:29'!
test09CartCantAddNonIntegerAmountOfBooks
	| cart book availableBooks |
	
	availableBooks := OrderedCollection new.
	availableBooks add: '9780330258647'.
	cart := TusLibrosCart withValidBooks: availableBooks .
	book := '9780330258647'.
	
	self should: [ cart addBook: book quantity: 0.42 ]
	raise: Error
	withExceptionDo: [ : anError | 
		self assert: anError messageText = TusLibrosCart invalidBookQuantityErrorDescription.
		self deny: (cart hasBook: book).
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


!TusLibrosCart methodsFor: 'cart management' stamp: 'eaam 10/30/2023 23:22:03'!
addBook: anBookToAddToCart quantity: theQuantityToBeAdded
	self validateBookISBN: anBookToAddToCart.
	self validateQuantity: theQuantityToBeAdded.
	
	contents at: anBookToAddToCart put: theQuantityToBeAdded 
	! !


!TusLibrosCart methodsFor: 'initialization' stamp: 'Sof D 10/30/2023 20:19:31'!
initializeWith: aListOfBooksThatCanBeAddedToCart 
	contents := Dictionary new.
	availableBooks := aListOfBooksThatCanBeAddedToCart .! !


!TusLibrosCart methodsFor: 'input validation' stamp: 'eaam 10/30/2023 23:22:34'!
validateBookISBN: anBookToValidateTheISBNOf

	 (availableBooks includes: anBookToValidateTheISBNOf) ifFalse: [ self error: self class bookNotAvailableErrorDescription ].! !

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
