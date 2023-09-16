!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Sof D 9/14/2023 20:41:22'!
test01SentenceFinderThrowsErrorWithEmptyPrefix

	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'hola'.
	
	sentenceFinder := SentenceFinderByPrefix new.

	self
		should: [ sentenceFinder findSentencesByPrefix: '' onStack: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCannotBeEmptyErrorDescription ]
		
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Sof D 9/14/2023 22:05:17'!
test02SentenceFinderCanFindExistingSentence

	| stack sentenceFinder result expectedResult |
	
	stack := OOStack new.
	stack push: 'hola'.
	
	expectedResult := OrderedCollection new.
	expectedResult add: 'hola'.
	
	sentenceFinder := SentenceFinderByPrefix new.
	result := sentenceFinder findSentencesByPrefix: 'hola' onStack: stack.
	
	self assert: expectedResult equals: result
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Sof D 9/14/2023 22:05:49'!
test03SentenceFinderCanFindExistingSentenceByPrefix

	| stack sentenceFinder result expectedResult |
	
	stack := OOStack new.
	stack push: 'hola'.
	
	expectedResult := OrderedCollection new.
	expectedResult add: 'hola'.
	
	sentenceFinder := SentenceFinderByPrefix new.
	result := sentenceFinder findSentencesByPrefix: 'ho' onStack: stack.
	
	
	self assert: expectedResult equals: result
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Sof D 9/14/2023 22:09:18'!
test04SentenceFinderCanFindMultipleExistingSentencesByPrefix

	| stack sentenceFinder result expectedResult |
	
	stack := OOStack new.
	stack push: 'hola'.
	stack push: 'holaqtal'.
	
	expectedResult := OrderedCollection new.
	expectedResult add: 'hola'.
	expectedResult add: 'holaqtal'.
	
	sentenceFinder := SentenceFinderByPrefix new.
	result := sentenceFinder findSentencesByPrefix: 'hola' onStack: stack.
	
	self assert: expectedResult equals: result	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Sof D 9/14/2023 22:09:53'!
test05SentenceFinderCannotFindNonexistingSentence

	| stack sentenceFinder result |
	
	stack := OOStack new.
	stack push: 'hola'.
	

	
	sentenceFinder := SentenceFinderByPrefix new.
	result := sentenceFinder findSentencesByPrefix: 'chau' onStack: stack.
	
	self assert: result isEmpty 
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Sof D 9/14/2023 20:35:29'!
test06SentenceFinderCanDistinguishCapitalLetters

	| stack sentenceFinder result |
	
	stack := OOStack new.
	stack push: 'hola'.
	
	sentenceFinder := SentenceFinderByPrefix new.
	result := sentenceFinder findSentencesByPrefix: 'Ho' onStack: stack.
	self assert: result isEmpty
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Sof D 9/14/2023 20:37:25'!
test07SentenceFinderThrowsErrorWithEmptySpaces

	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'hola'.
	
	sentenceFinder := SentenceFinderByPrefix new.

	self
		should: [ sentenceFinder findSentencesByPrefix: 'ho la' onStack: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixCannotContainEmptySpacesErrorDescription ]
		
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Sof D 9/14/2023 22:10:18'!
test08StackIsUnchangedAfterUsingSentenceFinder

	| stackBeforeUsingFinder stackAfterUsingFinder sentenceFinder |
	
	stackBeforeUsingFinder := OOStack new.
	stackBeforeUsingFinder push: 'hola'.
	stackAfterUsingFinder := stackBeforeUsingFinder .
	
	sentenceFinder := SentenceFinderByPrefix new.
	sentenceFinder findSentencesByPrefix: 'Ho' onStack: stackAfterUsingFinder .
	self assert: stackBeforeUsingFinder equals: stackAfterUsingFinder
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Sof D 9/14/2023 22:10:32'!
test09SentenceFinderOnlyFindsSentencesByTheirPrefix

	| stack sentenceFinder result |
	
	stack := OOStack new.
	stack push: 'holaqtal'.
	
	sentenceFinder := SentenceFinderByPrefix new.
	result := sentenceFinder findSentencesByPrefix: 'tal' onStack: stack .
	
	self assert: result isEmpty 
		
	
	
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'size elementOnTop'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 19:40:42'!
initialize
	size := 0.
	elementOnTop := NullOOStackElement new! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 19:19:13'!
isEmpty
	^size isZero! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 21:13:35'!
pop
	| valueToReturn |
	
	valueToReturn := self top.
	
	elementOnTop := elementOnTop previousElement .
	
	size := size - 1.
	
	^valueToReturn ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 21:04:40'!
push: anElementToPush

	| newElementOnTop |
	newElementOnTop := OOStackElementWithContent with: anElementToPush previousElementIs:  elementOnTop.
	
	size := size + 1.
	elementOnTop := newElementOnTop ! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 19:45:11'!
size
	^size! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 19:37:15'!
top
	^elementOnTop value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/14/2023 08:12:21'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
Object subclass: #OOStackElement
	instanceVariableNames: 'previousStackElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 21:05:18'!
previousElement
	^self subclassResponsibility ! !

!OOStackElement methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 21:05:34'!
value
	^self subclassResponsibility ! !


!classDefinition: #NullOOStackElement category: 'Stack-Exercise'!
OOStackElement subclass: #NullOOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NullOOStackElement methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 19:52:21'!
previousElement
	^self error: OOStack stackEmptyErrorDescription ! !

!NullOOStackElement methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 19:51:56'!
value
	^self error: OOStack stackEmptyErrorDescription ! !


!classDefinition: #OOStackElementWithContent category: 'Stack-Exercise'!
OOStackElement subclass: #OOStackElementWithContent
	instanceVariableNames: 'previousElement value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElementWithContent methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 19:32:42'!
initializeWith: anElementValue previousElementIs: thePreviousStackElement
	value := anElementValue.
	previousElement  := thePreviousStackElement 
	
! !

!OOStackElementWithContent methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 19:38:26'!
previousElement
	^previousElement ! !

!OOStackElementWithContent methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 19:36:05'!
value
	^value ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElementWithContent class' category: 'Stack-Exercise'!
OOStackElementWithContent class
	instanceVariableNames: ''!

!OOStackElementWithContent class methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 21:15:02'!
with: anElementValue previousElementIs: thePreviousStackElement
	^self new initializeWith: anElementValue previousElementIs: thePreviousStackElement! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'storage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 21:55:50'!
findSentencesByPrefix: aPrefixToSearchFor onStack: aStackToSearch
	| searchResults |
	searchResults := OrderedCollection new.
	self storeStack: aStackToSearch.
	searchResults := storage select: [ : aStringToEvaluate | self isString: aPrefixToSearchFor aPrefixOf: aStringToEvaluate ]. 
	^searchResults ! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 22:00:43'!
initialize
	storage := OrderedCollection new! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 22:13:01'!
isString: aPrefixString aPrefixOf: aStringToEvaluate
	| substringOfStringToEvaluate |
	self checkStringIsntEmpty: aPrefixString .
	self checkStringDoesnthaveSpaces: aPrefixString .
	substringOfStringToEvaluate := aStringToEvaluate copyFrom: 1 to: aPrefixString size.
	^aPrefixString = substringOfStringToEvaluate ! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 21:59:31'!
rebuildStack: aStackToRebuild
	
	storage do: [ : aStackElementToPush | aStackToRebuild push: aStackElementToPush ]! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 22:11:06'!
storeStack: aStackToStore
	|elementoActual |
	[aStackToStore size > 0] whileTrue: [
		elementoActual := aStackToStore pop.
		storage addFirst: elementoActual
	]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 20:31:03'!
prefixCannotBeEmptyErrorDescription
	^'Prefix cannot be empty!!'! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'Sof D 9/14/2023 20:36:43'!
prefixCannotContainEmptySpacesErrorDescription
	^'Prefix cannot contain empty spaces!!'! !
