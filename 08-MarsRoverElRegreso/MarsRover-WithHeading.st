!classDefinition: #MarsRoverLogTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/26/2023 20:40:02'!
test01LogStartsOutEmpty
	| rover expectedLog |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	expectedLog := OrderedCollection new.
	
	self assert: expectedLog equals: rover log.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/26/2023 20:39:37'!
test02LogRegisterNorthwardMovement
	| rover expectedLog |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	rover process: 'f'.
	expectedLog := OrderedCollection with: ((0@1) asString).
	
	self assert: expectedLog equals: rover log.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/26/2023 20:41:03'!
test03LogRegisterEastwardMovement
	| rover expectedLog |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast .
	rover process: 'f'.
	expectedLog := OrderedCollection with: ((1@0) asString).
	
	self assert: expectedLog equals: rover log.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/26/2023 20:41:31'!
test04LogRegisterWestwardMovement
	| rover expectedLog |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingWest .
	rover process: 'f'.
	expectedLog := OrderedCollection with: ((-1@0) asString).
	
	self assert: expectedLog equals: rover log.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/26/2023 20:41:51'!
test05LogRegisterSouthwardMovement
	| rover expectedLog |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingSouth.
	rover process: 'f'.
	expectedLog := OrderedCollection with: ((0@-1) asString).
	
	self assert: expectedLog equals: rover log.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/26/2023 20:46:52'!
test06LogRegisterWestwardRotation
	| rover expectedLog |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingSouth.
	rover process: 'r'.
	expectedLog := OrderedCollection with: ('West').
	
	self assert: expectedLog equals: rover log.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/26/2023 20:47:26'!
test07LogRegisterEastwardRotation
	| rover expectedLog |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingSouth.
	rover process: 'l'.
	expectedLog := OrderedCollection with: ('East').
	
	self assert: expectedLog equals: rover log.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/26/2023 20:48:26'!
test08LogRegisterNorthwardRotation
	| rover expectedLog |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast.
	rover process: 'l'.
	expectedLog := OrderedCollection with: ('North').
	
	self assert: expectedLog equals: rover log.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/26/2023 20:49:26'!
test09LogRegisterSouthwardRotation
	| rover expectedLog |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast.
	rover process: 'r'.
	expectedLog := OrderedCollection with: ('South').
	
	self assert: expectedLog equals: rover log.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/26/2023 20:57:59'!
test10LogRegistersMultipleRotations
	| rover expectedLog |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast.
	rover process: 'r'.
	rover process: 'r'.

	expectedLog := OrderedCollection with: ('South') with: 'West'.
	
	self assert: expectedLog equals: rover log.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/26/2023 20:59:14'!
test11LogRegistersMultipleMovements
	| rover expectedLog |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	rover process: 'fb'.

	expectedLog := OrderedCollection with: ((0@1) asString) with: ((0@0) asString).
	
	self assert: expectedLog equals: rover log.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/26/2023 20:59:37'!
test12LogRegistersMovementAndRotation
	| rover expectedLog |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	rover process: 'fr'.

	expectedLog := OrderedCollection with: ((0@1) asString) with: ('East').
	
	self assert: expectedLog equals: rover log.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/26/2023 21:03:24'!
test13LogCanReturnJustTheDirections
	| rover expectedLog |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	rover process: 'fr'.

	expectedLog := OrderedCollection with: ('East').
	
	self assert: expectedLog equals: rover directionLog.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/26/2023 21:08:28'!
test14LogCanReturnJustThePositoins
	| rover expectedLog |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	rover process: 'fr'.

	expectedLog := OrderedCollection with: ((0@1) asString) .
	
	self assert: expectedLog equals: rover positionLog.! !


!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRoverWindowTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'Sof D 10/26/2023 21:12:06'!
test01WindowStartsOutShowingRoverPositionAndDirection

	| expectedWindow rover |! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head log directionLog positionLog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'Sof D 10/26/2023 21:09:27'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self .
	
	log := OrderedCollection new.
	
	directionLog := OrderedCollection new.
	
	positionLog := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'Sof D 10/26/2023 21:05:38'!
headEast
	
	head := MarsRoverHeadingEast for: self.
	
	log add: 'East'. directionLog add: 'East'.! !

!MarsRover methodsFor: 'heading' stamp: 'Sof D 10/26/2023 21:05:44'!
headNorth
	
	head := MarsRoverHeadingNorth for: self .
	
	log add: 'North'. 	directionLog add: 'North'! !

!MarsRover methodsFor: 'heading' stamp: 'Sof D 10/26/2023 21:05:50'!
headSouth
	
	head := MarsRoverHeadingSouth for: self.
	
	log add: 'South'. 	directionLog add: 'South'! !

!MarsRover methodsFor: 'heading' stamp: 'Sof D 10/26/2023 21:05:57'!
headWest
	
	head := MarsRoverHeadingWest for: self .
	
	log add: 'West'. 	directionLog add: 'West'! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'Sof D 10/26/2023 21:09:38'!
moveEast
	
	position := position + (1@0).
	
	log add: (position asString). 	positionLog add: (position asString)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'Sof D 10/26/2023 21:09:48'!
moveNorth
	
	position := position + (0@1).
	
	log add: (position asString ). 	positionLog add: (position asString ).! !

!MarsRover methodsFor: 'moving' stamp: 'Sof D 10/26/2023 21:10:00'!
moveSouth
	
	position := position + (0@-1).
	
	log add: (position asString). 	positionLog add: (position asString)! !

!MarsRover methodsFor: 'moving' stamp: 'Sof D 10/26/2023 21:10:03'!
moveWest
	
	position := position + (-1@0).
	
	log add: (position asString). 	positionLog add: (position asString)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'category-name' stamp: 'Sof D 10/26/2023 21:05:03'!
directionLog
	^directionLog! !

!MarsRover methodsFor: 'category-name' stamp: 'Sof D 10/26/2023 20:38:09'!
log
	^log! !

!MarsRover methodsFor: 'category-name' stamp: 'Sof D 10/26/2023 21:08:39'!
positionLog
	^positionLog! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #MarsRoverLog category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverLog
	instanceVariableNames: 'rover content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLog methodsFor: 'accessing' stamp: 'Sof D 10/26/2023 20:30:49'!
contents
	
	! !

!MarsRoverLog methodsFor: 'accessing' stamp: 'Sof D 10/26/2023 20:18:45'!
directionChanges
	^OrderedCollection new.! !


!MarsRoverLog methodsFor: 'initialization' stamp: 'Sof D 10/26/2023 20:29:30'!
initializeFor: aRoverToLogTheActionsOf 
	rover := aRoverToLogTheActionsOf.
	content := OrderedCollection new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLog class' category: 'MarsRover-WithHeading'!
MarsRoverLog class
	instanceVariableNames: ''!

!MarsRoverLog class methodsFor: 'instance creation' stamp: 'Sof D 10/26/2023 20:27:25'!
for: aRoverToLogTheActionsOf 
	^self new initializeFor: aRoverToLogTheActionsOf ! !
