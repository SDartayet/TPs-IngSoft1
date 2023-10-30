!classDefinition: #MarsRoverLogTest category: 'TheReturnOfMarsRover-Tests'!
TestCase subclass: #MarsRoverLogTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TheReturnOfMarsRover-Tests'!

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 14:17:22'!
test01LogStartsOutEmpty
	| rover expectedLog log |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	expectedLog := OrderedCollection new.
	log := MarsRoverLog for: rover.
	
	self assert: expectedLog equals: log positionsAndDirections.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 14:33:36'!
test02LogRegisterNorthwardMovement
	| rover expectedLog log |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	log := MarsRoverLog for: rover.
	rover process: 'f'.
	expectedLog := OrderedCollection with: ((0@1) asString).
	
	
	self assert: expectedLog equals: log positionsAndDirections.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 14:33:54'!
test03LogRegisterEastwardMovement
	| rover expectedLog log |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast .
	log := MarsRoverLog for: rover.

	rover process: 'f'.
	expectedLog := OrderedCollection with: ((1@0) asString).
	
	self assert: expectedLog equals: log positionsAndDirections .! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 14:34:06'!
test04LogRegisterWestwardMovement
	| rover expectedLog log |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingWest .
	log := MarsRoverLog for: rover.

	rover process: 'f'.
	expectedLog := OrderedCollection with: ((-1@0) asString).
	
	self assert: expectedLog equals: log positionsAndDirections .! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 14:34:16'!
test05LogRegisterSouthwardMovement
	| rover expectedLog log |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingSouth.
	log := MarsRoverLog for: rover.

	rover process: 'f'.
	expectedLog := OrderedCollection with: ((0@-1) asString).
	
	self assert: expectedLog equals:  log positionsAndDirections .! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 14:34:26'!
test06LogRegisterWestwardRotation
	| rover expectedLog log |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingSouth.
	log := MarsRoverLog for: rover.

	rover process: 'r'.
	expectedLog := OrderedCollection with: ('West').
	
	self assert: expectedLog equals: log positionsAndDirections .! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 14:34:38'!
test07LogRegisterEastwardRotation
	| rover expectedLog log |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingSouth.
	log := MarsRoverLog for: rover.

	rover process: 'l'.
	expectedLog := OrderedCollection with: ('East').
	
	self assert: expectedLog equals: log positionsAndDirections .! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 14:34:53'!
test08LogRegisterNorthwardRotation
	| rover expectedLog log |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast.
	log := MarsRoverLog for: rover.

	rover process: 'l'.
	expectedLog := OrderedCollection with: ('North').
	
	self assert: expectedLog equals: log positionsAndDirections .! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 14:35:12'!
test09LogRegisterSouthwardRotation
	| rover expectedLog log |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast.
	log := MarsRoverLog for: rover.

	rover process: 'r'.
	expectedLog := OrderedCollection with: ('South').
	
	self assert: expectedLog equals: log positionsAndDirections .! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 14:35:48'!
test10LogRegistersMultipleRotations
	| rover expectedLog log |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast.
	log := MarsRoverLog for: rover.

	rover process: 'r'.
	rover process: 'r'.

	expectedLog := OrderedCollection with: ('South') with: 'West'.
	
	self assert: expectedLog equals: log positionsAndDirections .! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 14:36:02'!
test11LogRegistersMultipleMovements
	| rover expectedLog log |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	log := MarsRoverLog for: rover.

	rover process: 'fb'.

	expectedLog := OrderedCollection with: ((0@1) asString) with: ((0@0) asString).
	
	self assert: expectedLog equals: log positionsAndDirections .! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 14:36:12'!
test12LogRegistersMovementAndRotation
	| rover expectedLog log |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	log := MarsRoverLog for: rover.

	rover process: 'fr'.

	expectedLog := OrderedCollection with: ((0@1) asString) with: ('East').
	
	self assert: expectedLog equals: log positionsAndDirections .! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 14:36:32'!
test13LogCanReturnJustTheDirections
	| rover expectedLog log |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	log := MarsRoverLog for: rover.

	rover process: 'fr'.

	expectedLog := OrderedCollection with: ('East').
	
	self assert: expectedLog equals: log directions.! !

!MarsRoverLogTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 14:37:26'!
test14LogCanReturnJustThePositions
	| rover expectedLog log |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	log := MarsRoverLog for: rover.
	rover process: 'fr'.

	expectedLog := OrderedCollection with: ((0@1) asString) .
	
	self assert: expectedLog equals: log positions.! !


!classDefinition: #MarsRoverTest category: 'TheReturnOfMarsRover-Tests'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TheReturnOfMarsRover-Tests'!

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


!classDefinition: #MarsRoverWindowTest category: 'TheReturnOfMarsRover-Tests'!
TestCase subclass: #MarsRoverWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TheReturnOfMarsRover-Tests'!

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:29:50'!
test01WindowStartsOutShowingRoverPositionAndDirectionNorth

	| rover  window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	window := MarsRoverWindow for: rover.
	
	self assert: window position equals: (0@0) asString.
	self assert: window direction equals: 'North'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:35:59'!
test02WindowStartsOutShowingRoverPositionAndDirectionSouth

	| rover window |
	rover := MarsRover at: 0@1heading: MarsRoverHeadingSouth .
	
	window := MarsRoverWindow for: rover.
	
	self assert: window position equals: (0@1) asString.
	self assert: window direction equals: 'South'.
	
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:37:34'!
test03WindowStartsOutShowingRoverPositionAndDirectionWest

	| rover window |
	rover := MarsRover at: 1@0 heading: MarsRoverHeadingWest .
	
	window := MarsRoverWindow for: rover.
	
	self assert: window position equals: (1@0) asString.
	self assert: window direction equals: 'West'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:37:48'!
test04WindowStartsOutShowingRoverPositionAndDirectionEast

	| rover window |
	rover := MarsRover at: 1@1 heading: MarsRoverHeadingEast .
	
	window := MarsRoverWindow for: rover.
	
	self assert: window position equals: (1@1) asString.
	self assert: window direction equals: 'East'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:38:21'!
test05WindowChangesWestwardMovement
	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingWest .
	rover process: 'f'.
	
	window := MarsRoverWindow for: rover.

	
	self assert: window position equals: (-1@0) asString.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:38:34'!
test06WindowChangesNorthwardMovement
	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	rover process: 'f'.
	window := MarsRoverWindow for: rover.

	
	self assert: window position equals: (0@1) asString.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:39:46'!
test07WindowChangesEastwardMovement
	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast .
	rover process: 'f'.
	
	window := MarsRoverWindow for: rover.

	
	self assert: window position equals: (1@0) asString.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:40:27'!
test08WindowChangesSouthwardMovement
	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingSouth .
	rover process: 'f'.
	
 	window := MarsRoverWindow for: rover.

	
	self assert: window position equals: (0@-1) asString.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:40:47'!
test09WindowRegisterWestwardRotation
	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingSouth.
	rover process: 'r'.
	
	window := MarsRoverWindow for: rover.

	
	self assert: window direction equals: 'West'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:41:10'!
test10WindowRegisterNorthwardRotation
	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingWest.
	rover process: 'r'.
	window := MarsRoverWindow for: rover.

	
	self assert: window direction equals: 'North'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:41:21'!
test11WindowRegisterSouthwardRotation
	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast.
	rover process: 'r'.
	window := MarsRoverWindow for: rover.

	
	self assert:  window direction equals: 'South'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:41:36'!
test12WindowRegisterEastwardRotation
	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	rover process: 'r'.
	window := MarsRoverWindow for: rover.

	
	self assert: window direction equals: 'East'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:42:31'!
test13WindowRegisterMultipleRotations
	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	rover process: 'rr'.
	
	window := MarsRoverWindow for: rover.

	
	self assert: window direction equals: 'South'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:42:43'!
test14WindowRegisterMultipleMovements
	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	rover process: 'fbf'.
	
	window := MarsRoverWindow for: rover.

	
	self assert: window position equals: (0@1) asString .
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:43:00'!
test15WindowRegistersMovementAndRotation
	| rover window |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	rover process: 'fr'.
	window := MarsRoverWindow for: rover.


	self assert: window direction equals: 'East'.
	self assert: window position equals: (0@1) asString .
! !


!classDefinition: #ObserverProxyTest category: 'TheReturnOfMarsRover-Tests'!
TestCase subclass: #ObserverProxyTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TheReturnOfMarsRover-Tests'!

!ObserverProxyTest methodsFor: 'tests' stamp: 'eaam 10/29/2023 00:43:15'!
test01AProxyInitializesWithAVariable
	| observer |
	observer := ObserverProxy with: 1.
	self assert: observer variableValue equals: 1.! !

!ObserverProxyTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:35:02'!
test02AProxyCanAttachAObserver
	| observer aWindow attachedCollection aClosure |
	aClosure := [ : test : test2 |].
	observer := ObserverProxy with: 1.
	aWindow := MarsRoverWindow new.
	observer attach: aWindow onUpdateDo: aClosure .
	attachedCollection := Dictionary new.
	attachedCollection at: 	aWindow put: aClosure .
	self assert: (observer attachedComplements) equals: attachedCollection.! !

!ObserverProxyTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:35:20'!
test03AProxyCanAttachMultipleObservers
	| observer aWindow aLog attachedCollection aClosure anotherClosure |
	aClosure := [ : test : test2 |]. 	anotherClosure := [ : test : test2 |].

	observer := ObserverProxy with: 1.
	aWindow := MarsRoverWindow new.
	aLog := MarsRoverLog new.
	observer attach: aWindow onUpdateDo: aClosure .
	observer attach: aLog onUpdateDo: anotherClosure .
	attachedCollection := Dictionary new.
	attachedCollection at: aWindow put: aClosure ; at: aLog put: anotherClosure .
	self assert: observer attachedComplements equals: attachedCollection.! !

!ObserverProxyTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 01:27:56'!
test04AProxyCanUpdateItsVariable
	| observer |
	observer := ObserverProxy with: 0@0.
	observer updateVariable: 0@1.
	self assert: observer variableValue equals: 0@1 .! !

!ObserverProxyTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:29:50'!
test05AProxyCanUpdateAnObserver
	| observer aWindow aClosure |
	aClosure := [ : aMarsRoverWindow : aPosition | aMarsRoverWindow updatePosition: aPosition ].
	observer := ObserverProxy with: 1.
	aWindow := MarsRoverWindow new.
	aWindow updatePosition: 0@0.
	observer attach: aWindow onUpdateDo: aClosure .
	observer updateVariable: 0@1.
	self assert: aWindow position equals: (0@1) asString .! !

!ObserverProxyTest methodsFor: 'tests' stamp: 'Sof D 10/30/2023 02:29:50'!
test06AProxyCanUpdateMultipleObservers
	| observer aWindow anotherWindow aClosure anotherClosure |
	aClosure := [ : aMarsRoverWindow : aPosition | aMarsRoverWindow updatePosition: aPosition ].
	anotherClosure := [ : aMarsRoverWindow : aPosition | aMarsRoverWindow updatePosition: aPosition ].

	observer := ObserverProxy with: 1.
	aWindow := MarsRoverWindow new.
	anotherWindow := MarsRoverWindow new.
	aWindow updatePosition: 0@0.
	anotherWindow updatePosition: 10@10.
	observer attach: aWindow onUpdateDo: aClosure .
	observer attach: anotherWindow onUpdateDo: anotherClosure .
	observer updateVariable: 0@1.
	self assert: aWindow position equals: (0@1) asString .
	self assert: anotherWindow position equals: (0@1) asString .! !
!classDefinition: #MarsRover category: 'TheReturnOfMarsRover-Ejercicio'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TheReturnOfMarsRover-Ejercicio'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'Sof D 10/30/2023 02:16:09'!
initializeAt: aPosition heading: aHeadingType

	position := ObserverProxy with: aPosition.
	head := ObserverProxy with: (aHeadingType for: self) .
	
	! !


!MarsRover methodsFor: 'heading' stamp: 'Sof D 10/30/2023 02:08:28'!
headEast
	
	head updateVariable: ( MarsRoverHeadingEast for: self).
	! !

!MarsRover methodsFor: 'heading' stamp: 'Sof D 10/30/2023 02:08:50'!
headNorth
	
	head updateVariable: (MarsRoverHeadingNorth for: self ).
	
	! !

!MarsRover methodsFor: 'heading' stamp: 'Sof D 10/30/2023 02:09:12'!
headSouth
	
	head updateVariable: (MarsRoverHeadingSouth for: self).
	! !

!MarsRover methodsFor: 'heading' stamp: 'Sof D 10/30/2023 02:09:24'!
headWest
	
	head updateVariable: (MarsRoverHeadingWest for: self).
	! !

!MarsRover methodsFor: 'heading' stamp: 'Sof D 10/30/2023 02:15:19'!
rotateLeft
	
	head variableValue rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'Sof D 10/30/2023 02:15:10'!
rotateRight
	
	head variableValue rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'Sof D 10/30/2023 02:14:48'!
isAt: aPosition heading: aHeadingType

	^position variableValue = aPosition and: [ head variableValue isHeading: aHeadingType ]! !

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


!MarsRover methodsFor: 'moving' stamp: 'Sof D 10/30/2023 02:16:00'!
moveBackward
	
	head variableValue moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'Sof D 10/30/2023 02:13:25'!
moveEast
	
	position updateVariable: (position variableValue + (1@0)).
	
	! !

!MarsRover methodsFor: 'moving' stamp: 'Sof D 10/30/2023 02:15:54'!
moveForward
	
	head variableValue moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'Sof D 10/30/2023 02:13:44'!
moveNorth
	
	position updateVariable: (position variableValue + (0@1))
	
	! !

!MarsRover methodsFor: 'moving' stamp: 'Sof D 10/30/2023 02:14:00'!
moveSouth
	
	position updateVariable: (position variableValue + (0@-1))
	! !

!MarsRover methodsFor: 'moving' stamp: 'Sof D 10/30/2023 02:14:15'!
moveWest
	
	position updateVariable: (position variableValue + (-1@0)).
	! !


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


!MarsRover methodsFor: 'add observers' stamp: 'Sof D 10/30/2023 02:32:54'!
attachToDirection: anObserverToAttach onUpdateDo: aClosureToValueOnUpdate
	head attach: anObserverToAttach onUpdateDo: aClosureToValueOnUpdate .! !

!MarsRover methodsFor: 'add observers' stamp: 'Sof D 10/30/2023 02:32:35'!
attachToPosition: anObserverToAttach onUpdateDo: aClosureToValueOnUpdate
	position attach: anObserverToAttach onUpdateDo: aClosureToValueOnUpdate .! !


!MarsRover methodsFor: 'observers' stamp: 'Sof D 10/30/2023 14:20:30'!
direction
	^head variableValue ! !

!MarsRover methodsFor: 'observers' stamp: 'Sof D 10/30/2023 14:20:20'!
position
	^position variableValue ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'TheReturnOfMarsRover-Ejercicio'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'TheReturnOfMarsRover-Ejercicio'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TheReturnOfMarsRover-Ejercicio'!

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


!MarsRoverHeading methodsFor: 'direction name' stamp: 'Sof D 10/30/2023 02:21:39'!
directionName
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'TheReturnOfMarsRover-Ejercicio'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'TheReturnOfMarsRover-Ejercicio'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TheReturnOfMarsRover-Ejercicio'!

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


!MarsRoverHeadingEast methodsFor: 'direction name' stamp: 'Sof D 10/30/2023 02:21:39'!
directionName
	^'East'! !


!classDefinition: #MarsRoverHeadingNorth category: 'TheReturnOfMarsRover-Ejercicio'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TheReturnOfMarsRover-Ejercicio'!

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


!MarsRoverHeadingNorth methodsFor: 'direction name' stamp: 'Sof D 10/30/2023 02:21:39'!
directionName
	^'North'! !


!classDefinition: #MarsRoverHeadingSouth category: 'TheReturnOfMarsRover-Ejercicio'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TheReturnOfMarsRover-Ejercicio'!

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


!MarsRoverHeadingSouth methodsFor: 'direction name' stamp: 'Sof D 10/30/2023 02:21:39'!
directionName
	^'South'! !


!classDefinition: #MarsRoverHeadingWest category: 'TheReturnOfMarsRover-Ejercicio'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TheReturnOfMarsRover-Ejercicio'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'direction name' stamp: 'Sof D 10/30/2023 02:21:40'!
directionName
	^'West'! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #MarsRoverLog category: 'TheReturnOfMarsRover-Ejercicio'!
Object subclass: #MarsRoverLog
	instanceVariableNames: 'positionsAndDirections positions directions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TheReturnOfMarsRover-Ejercicio'!

!MarsRoverLog methodsFor: 'accessing' stamp: 'Sof D 10/30/2023 14:36:52'!
directions
	^directions! !

!MarsRoverLog methodsFor: 'accessing' stamp: 'Sof D 10/30/2023 14:36:58'!
positions
	^positions! !

!MarsRoverLog methodsFor: 'accessing' stamp: 'Sof D 10/30/2023 14:20:01'!
positionsAndDirections
	^positionsAndDirections 
	! !


!MarsRoverLog methodsFor: 'initialization' stamp: 'Sof D 10/30/2023 14:28:37'!
initializeWith: aRoverToLogTheActionsOf

	aRoverToLogTheActionsOf attachToPosition: self onUpdateDo: [ : anObserver : aPosition | anObserver addPositionToLog: aPosition ].
	aRoverToLogTheActionsOf attachToDirection: self onUpdateDo: [ : anObserver : aDirection | anObserver addDirectionToLog: aDirection ].
	positionsAndDirections := OrderedCollection new.
	positions := OrderedCollection new.
	directions := OrderedCollection new.! !


!MarsRoverLog methodsFor: 'updating' stamp: 'Sof D 10/30/2023 14:37:55'!
addDirectionToLog: aDirectionOfTheRoverToLog
	| direction |
	direction := aDirectionOfTheRoverToLog directionName .
	positionsAndDirections add: direction .
	directions add: direction .! !

!MarsRoverLog methodsFor: 'updating' stamp: 'Sof D 10/30/2023 14:29:31'!
addPositionToLog: aPositionOfTheRoverToLog
	| position |
	position := aPositionOfTheRoverToLog asString.
	positionsAndDirections add: position .
	positions add: position .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverLog class' category: 'TheReturnOfMarsRover-Ejercicio'!
MarsRoverLog class
	instanceVariableNames: ''!

!MarsRoverLog class methodsFor: 'instance creation' stamp: 'Sof D 10/30/2023 14:18:02'!
for: aRoverToLogTheActionsOf
	^self new initializeWith: aRoverToLogTheActionsOf ! !


!classDefinition: #MarsRoverWindow category: 'TheReturnOfMarsRover-Ejercicio'!
Object subclass: #MarsRoverWindow
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TheReturnOfMarsRover-Ejercicio'!

!MarsRoverWindow methodsFor: 'initialization' stamp: 'Sof D 10/30/2023 14:24:26'!
initializeWith: aRoverToObserve

	aRoverToObserve attachToPosition: self onUpdateDo: [ : anObserver : aPosition | anObserver updatePosition: aPosition ].
	aRoverToObserve attachToDirection: self onUpdateDo: [ : anObserver : aDirection | anObserver updateDirection: aDirection ].
	position := aRoverToObserve position asString.
	direction := aRoverToObserve direction directionName .
	! !


!MarsRoverWindow methodsFor: 'updating' stamp: 'Sof D 10/30/2023 02:18:39'!
updateDirection: aDirection
	direction := aDirection directionName.! !

!MarsRoverWindow methodsFor: 'updating' stamp: 'Sof D 10/30/2023 02:22:18'!
updatePosition: aPosition
	position := aPosition asString .! !


!MarsRoverWindow methodsFor: 'accessing' stamp: 'eaam 10/27/2023 01:48:36'!
direction
	^direction! !

!MarsRoverWindow methodsFor: 'accessing' stamp: 'Sof D 10/30/2023 02:24:28'!
position
	^position.! !

!MarsRoverWindow methodsFor: 'accessing' stamp: 'Sof D 10/30/2023 02:22:55'!
positionAndDirection
	^position, ', ', direction! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindow class' category: 'TheReturnOfMarsRover-Ejercicio'!
MarsRoverWindow class
	instanceVariableNames: ''!

!MarsRoverWindow class methodsFor: 'as yet unclassified' stamp: 'Sof D 10/30/2023 02:27:12'!
for: aRoverToObserve
	^self new initializeWith: aRoverToObserve ! !


!classDefinition: #ObserverProxy category: 'TheReturnOfMarsRover-Ejercicio'!
Object subclass: #ObserverProxy
	instanceVariableNames: 'variable attachedObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TheReturnOfMarsRover-Ejercicio'!

!ObserverProxy methodsFor: 'initialization' stamp: 'Sof D 10/30/2023 01:40:15'!
initializeWith: aVariableToStore 
	variable := aVariableToStore.
	attachedObservers := Dictionary  new.! !


!ObserverProxy methodsFor: 'value' stamp: 'eaam 10/29/2023 00:43:59'!
variableValue
	^variable .! !


!ObserverProxy methodsFor: 'observer actions' stamp: 'Sof D 10/30/2023 14:21:05'!
attach: aComplementToAttach onUpdateDo: aClosureWithActionToDoOnVariableUpdate 
	attachedObservers at: aComplementToAttach put: aClosureWithActionToDoOnVariableUpdate .
	! !

!ObserverProxy methodsFor: 'observer actions' stamp: 'eaam 10/29/2023 02:20:53'!
attachedComplements
	^attachedObservers .! !

!ObserverProxy methodsFor: 'observer actions' stamp: 'Sof D 10/30/2023 02:03:41'!
updateVariable: aVariable
	variable := aVariable .
	attachedObservers keysAndValuesDo: [: anObserver : aClosure | (aClosure value: anObserver value: aVariable) ]
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ObserverProxy class' category: 'TheReturnOfMarsRover-Ejercicio'!
ObserverProxy class
	instanceVariableNames: ''!

!ObserverProxy class methodsFor: 'as yet unclassified' stamp: 'eaam 10/29/2023 00:43:32'!
with: aVariable
	^self new initializeWith: aVariable.! !
