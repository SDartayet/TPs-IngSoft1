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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Sof D 9/17/2023 18:22:30'!
test01SentenceFinderThrowsErrorWithEmptyPrefix

	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'hola'.
	
	sentenceFinder := SentenceFinderByPrefix new.

	self
		should: [ sentenceFinder findSentencesByPrefix: '' onStack: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = EmptyPrefix prefixCannotBeEmptyErrorDescription ]
		
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Sof D 9/17/2023 21:23:15'!
test02SentenceFinderCanFindExistingSentence

	| stack sentenceFinder result expectedResult |
	
	
	expectedResult := OrderedCollection new.
	expectedResult add: 'hola'.
	
	stack := self setUpTestStackWithWords: expectedResult .
	
	sentenceFinder := SentenceFinderByPrefix new.
	result := sentenceFinder findSentencesByPrefix: 'hola' onStack: stack.
	
	self assert: expectedResult equals: result
	
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Sof D 9/17/2023 21:24:31'!
test03SentenceFinderCanFindExistingSentenceByPrefix

	| stack sentenceFinder result expectedResult |
	
	expectedResult := OrderedCollection new.
	expectedResult add: 'hola'.
	
	stack := self setUpTestStackWithWords: expectedResult .
	
	sentenceFinder := SentenceFinderByPrefix new.
	result := sentenceFinder findSentencesByPrefix: 'ho' onStack: stack.
	
	
	self assert: expectedResult equals: result
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'Sof D 9/17/2023 21:24:53'!
test04SentenceFinderCanFindMultipleExistingSentencesByPrefix

	| stack sentenceFinder result expectedResult |

	
	expectedResult := OrderedCollection new.
	expectedResult add: 'holaqtal'.
	expectedResult add: 'hola'.
	
	stack := self setUpTestStackWithWords: expectedResult .

	
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

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'eze 9/17/2023 17:26:08'!
test07SentenceFinderThrowsErrorWithEmptySpaces

	| stack sentenceFinder |
	
	stack := OOStack new.
	stack push: 'hola'.
	
	sentenceFinder := SentenceFinderByPrefix new.

	self
		should: [ sentenceFinder findSentencesByPrefix: 'ho la' onStack: stack ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = PrefixWithSeparators prefixCannotContainEmptySpacesErrorDescription ]
		
	
	
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


!SentenceFinderByPrefixTest methodsFor: 'test setup' stamp: 'Sof D 9/17/2023 21:26:55'!
setUpTestStackWithWords: aListOfWordsToPushOnTheStack
	| stack |
	stack := OOStack new.
	aListOfWordsToPushOnTheStack reverseDo: [ : aWordToPush |
		stack push: aWordToPush 
	].
	^stack! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'size elementOnTop'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'operations' stamp: 'Sof D 9/14/2023 19:19:13'!
isEmpty
	^size isZero! !

!OOStack methodsFor: 'operations' stamp: 'Sof D 9/14/2023 21:13:35'!
pop
	| valueToReturn |
	
	valueToReturn := self top.
	
	elementOnTop := elementOnTop previousElement .
	
	size := size - 1.
	
	^valueToReturn ! !

!OOStack methodsFor: 'operations' stamp: 'Sof D 9/14/2023 21:04:40'!
push: anElementToPush

	| newElementOnTop |
	newElementOnTop := OOStackElementWithContent with: anElementToPush previousElementIs:  elementOnTop.
	
	size := size + 1.
	elementOnTop := newElementOnTop ! !

!OOStack methodsFor: 'operations' stamp: 'Sof D 9/14/2023 19:45:11'!
size
	^size! !

!OOStack methodsFor: 'operations' stamp: 'Sof D 9/14/2023 19:37:15'!
top
	^elementOnTop value! !


!OOStack methodsFor: 'initialization' stamp: 'Sof D 9/14/2023 19:40:42'!
initialize
	size := 0.
	elementOnTop := NullOOStackElement new! !

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

!OOStackElement methodsFor: 'getters' stamp: 'Sof D 9/14/2023 21:05:18'!
previousElement
	^self subclassResponsibility ! !

!OOStackElement methodsFor: 'getters' stamp: 'Sof D 9/14/2023 21:05:34'!
value
	^self subclassResponsibility ! !


!classDefinition: #NullOOStackElement category: 'Stack-Exercise'!
OOStackElement subclass: #NullOOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NullOOStackElement methodsFor: 'getters' stamp: 'Sof D 9/14/2023 19:52:21'!
previousElement
	^self error: OOStack stackEmptyErrorDescription ! !

!NullOOStackElement methodsFor: 'getters' stamp: 'Sof D 9/14/2023 19:51:56'!
value
	^self error: OOStack stackEmptyErrorDescription ! !


!classDefinition: #OOStackElementWithContent category: 'Stack-Exercise'!
OOStackElement subclass: #OOStackElementWithContent
	instanceVariableNames: 'previousElement value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElementWithContent methodsFor: 'getters' stamp: 'Sof D 9/14/2023 19:38:26'!
previousElement
	^previousElement ! !

!OOStackElementWithContent methodsFor: 'getters' stamp: 'Sof D 9/14/2023 19:36:05'!
value
	^value ! !


!OOStackElementWithContent methodsFor: 'initialization' stamp: 'Sof D 9/14/2023 19:32:42'!
initializeWith: anElementValue previousElementIs: thePreviousStackElement
	value := anElementValue.
	previousElement  := thePreviousStackElement 
	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElementWithContent class' category: 'Stack-Exercise'!
OOStackElementWithContent class
	instanceVariableNames: ''!

!OOStackElementWithContent class methodsFor: 'initialization' stamp: 'Sof D 9/14/2023 21:15:02'!
with: anElementValue previousElementIs: thePreviousStackElement
	^self new initializeWith: anElementValue previousElementIs: thePreviousStackElement! !


!classDefinition: #PrefixString category: 'Stack-Exercise'!
Object subclass: #PrefixString
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixString methodsFor: 'prefix messages' stamp: 'eze 9/17/2023 04:08:51'!
isPrefixOf: aStringToEvaluate
	"| substringOfStringToEvaluate |
	
	substringOfStringToEvaluate := aStringToEvaluate first: self size.
	^self = substringOfStringToEvaluate "
	^self subclassResponsibility 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrefixString class' category: 'Stack-Exercise'!
PrefixString class
	instanceVariableNames: ''!

!PrefixString class methodsFor: 'instance creators' stamp: 'eze 9/17/2023 17:05:40'!
hasEmptySpaces: aStringToEvaluate
	| emptySpacesInString |
	emptySpacesInString := aStringToEvaluate select: [ : aCharacter | aCharacter isSeparator].
	^((emptySpacesInString isEmpty) not)! !

!PrefixString class methodsFor: 'instance creators' stamp: 'eze 9/17/2023 03:48:49'!
with: aPrefix
	"(aPrefix isEmpty) ifTrue: [self error: self prefixCannotBeEmptyErrorDescription].
	(self hasEmptySpaces: aPrefix) ifTrue: [self error: self prefixCannotContainEmptySpacesErrorDescription]."
	"^PrefixString new initializeWith: aPrefix"
	^(PrefixString allSubclasses detect:[:aClass | aClass canHandle: aPrefix]) for: aPrefix ! !


!classDefinition: #EmptyPrefix category: 'Stack-Exercise'!
PrefixString subclass: #EmptyPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyPrefix methodsFor: 'prefix operators' stamp: 'Sof D 9/17/2023 16:30:07'!
isPrefixOf: aStringToEvaluate
	^self error: self class prefixCannotBeEmptyErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyPrefix class' category: 'Stack-Exercise'!
EmptyPrefix class
	instanceVariableNames: ''!

!EmptyPrefix class methodsFor: 'initialization' stamp: 'eze 9/17/2023 04:11:41'!
canHandle: aPrefixToEvaluate
	^ '' = aPrefixToEvaluate! !

!EmptyPrefix class methodsFor: 'initialization' stamp: 'Sof D 9/17/2023 16:39:45'!
for: aStringValue
	^self error: self prefixCannotBeEmptyErrorDescription ! !


!EmptyPrefix class methodsFor: 'error handling' stamp: 'Sof D 9/17/2023 16:26:30'!
prefixCannotBeEmptyErrorDescription
	^'Prefix cannot be empty!!'! !


!classDefinition: #PrefixWithSeparators category: 'Stack-Exercise'!
PrefixString subclass: #PrefixWithSeparators
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixWithSeparators methodsFor: 'prefix operators' stamp: 'eze 9/17/2023 17:02:13'!
isPrefixOf: aStringToEvaluate
	^self error: self class prefixCannotContainEmptySpacesErrorDescription ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrefixWithSeparators class' category: 'Stack-Exercise'!
PrefixWithSeparators class
	instanceVariableNames: ''!

!PrefixWithSeparators class methodsFor: 'initialization' stamp: 'eze 9/17/2023 04:12:07'!
canHandle: aPrefixToEvaluate
	^self hasEmptySpaces: aPrefixToEvaluate! !

!PrefixWithSeparators class methodsFor: 'initialization' stamp: 'Sof D 9/17/2023 16:39:55'!
for: aStringValue
	^self error: self prefixCannotContainEmptySpacesErrorDescription ! !


!PrefixWithSeparators class methodsFor: 'error handling' stamp: 'eze 9/17/2023 17:01:43'!
prefixCannotContainEmptySpacesErrorDescription
	^'Prefix cannot contain empty spaces!!'! !


!classDefinition: #WellFormedPrefix category: 'Stack-Exercise'!
PrefixString subclass: #WellFormedPrefix
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!WellFormedPrefix methodsFor: 'prefix operators' stamp: 'Sof D 9/17/2023 16:43:43'!
isPrefixOf: aStringToEvaluate
	^aStringToEvaluate beginsWith: value! !


!WellFormedPrefix methodsFor: 'initialization' stamp: 'Sof D 9/17/2023 16:43:05'!
initializeWith: aStringValue
	value := aStringValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WellFormedPrefix class' category: 'Stack-Exercise'!
WellFormedPrefix class
	instanceVariableNames: 'value'!

!WellFormedPrefix class methodsFor: 'instance creators' stamp: 'Sof D 9/17/2023 16:53:58'!
canHandle: aPrefixToEvaluate
	^( '' = aPrefixToEvaluate and: (self hasEmptySpaces: aPrefixToEvaluate)) not! !

!WellFormedPrefix class methodsFor: 'instance creators' stamp: 'Sof D 9/17/2023 16:40:29'!
for: aStringValue
	^self new initializeWith: aStringValue ! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'storage'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'auxiliaries' stamp: 'eze 9/17/2023 17:21:02'!
popAndPreserveStack: aStackToExplore in: listOfStackElements
	| stackBackup |
	stackBackup := aStackToExplore.
	^ self popStack: stackBackup in: listOfStackElements! !

!SentenceFinderByPrefix methodsFor: 'auxiliaries' stamp: 'eze 9/17/2023 17:20:32'!
popStack: stackBackup in: listOfStackElements

	^ [stackBackup isEmpty not] whileTrue: [
		listOfStackElements add: stackBackup pop.
	]! !

!SentenceFinderByPrefix methodsFor: 'auxiliaries' stamp: 'eze 9/17/2023 17:22:12'!
showAsCollectionTheStack: aStackToExplore
	| listOfStackElements |
	listOfStackElements := OrderedCollection new.
	self popAndPreserveStack: aStackToExplore in: listOfStackElements.
	^ listOfStackElements ! !


!SentenceFinderByPrefix methodsFor: 'string finder' stamp: 'eze 9/17/2023 17:09:58'!
findSentencesByPrefix: aPrefixToSearchFor onStack: aStackToSearch
	| aPrefixToUse |
	aPrefixToUse := PrefixString with: aPrefixToSearchFor.
	^(self showAsCollectionTheStack: aStackToSearch) select: [ : aStringToEvaluate | aPrefixToUse isPrefixOf: aStringToEvaluate ].! !
