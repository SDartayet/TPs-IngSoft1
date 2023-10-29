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

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/27/2023 02:08:43'!
test01WindowStartsOutShowingRoverPositionAndDirectionNorth

	| rover  |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	
	self assert: (rover window) position equals: (0@0) asString.
	self assert: (rover window) direction equals: 'North'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/27/2023 02:10:10'!
test02WindowStartsOutShowingRoverPositionAndDirectionSouth

	| rover  |
	rover := MarsRover at: 0@1heading: MarsRoverHeadingSouth .
	
	self assert: (rover window) position equals: (0@1) asString.
	self assert: (rover window) direction equals: 'South'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/29/2023 01:38:56'!
test03WindowStartsOutShowingRoverPositionAndDirectionWest

	| rover |
	rover := MarsRover at: 1@0 heading: MarsRoverHeadingWest .
	
	self assert: (rover window) position equals: (1@0) asString.
	self assert: (rover window) direction equals: 'West'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/27/2023 02:10:42'!
test04WindowStartsOutShowingRoverPositionAndDirectionEast

	| rover  |
	rover := MarsRover at: 1@1 heading: MarsRoverHeadingEast .
	
	self assert: (rover window) position equals: (1@1) asString.
	self assert: (rover window) direction equals: 'East'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/27/2023 02:13:24'!
test05WindowChangesWestwardMovement
	| rover  |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingWest .
	rover process: 'f'.
	
	self assert: rover window position equals: (-1@0) asString.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/27/2023 02:15:23'!
test06WindowChangesNorthwardMovement
	| rover |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth .
	rover process: 'f'.
	
	self assert: rover window position equals: (0@1) asString.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/27/2023 02:16:12'!
test07WindowChangesEastwardMovement
	| rover |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast .
	rover process: 'f'.
	
	self assert: rover window position equals: (1@0) asString.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/27/2023 02:16:27'!
test08WindowChangesEastwardMovement
	| rover |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast .
	rover process: 'f'.
	
	self assert: rover window position equals: (1@0) asString.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/27/2023 02:17:09'!
test09WindowChangesSouthwardMovement
	| rover |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingSouth .
	rover process: 'f'.
	
	self assert: rover window position equals: (0@-1) asString.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/29/2023 01:42:35'!
test10WindowRegisterWestwardRotation
	| rover |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingSouth.
	rover process: 'r'.
	
	self assert: rover window direction equals: 'West'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/29/2023 01:42:48'!
test11WindowRegisterNorthwardRotation
	| rover |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingWest.
	rover process: 'r'.
	
	self assert: rover window direction equals: 'North'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/29/2023 01:43:07'!
test12WindowRegisterSouthwardRotation
	| rover |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingEast.
	rover process: 'r'.
	
	self assert: rover window direction equals: 'South'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/29/2023 01:43:14'!
test13WindowRegisterEastwardRotation
	| rover |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	rover process: 'r'.
	
	self assert: rover window direction equals: 'East'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/29/2023 01:43:20'!
test14WindowRegisterMultipleRotations
	| rover |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	rover process: 'rr'.
	
	self assert: rover window direction equals: 'South'.
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/29/2023 01:43:25'!
test15WindowRegisterMultipleMovements
	| rover |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	rover process: 'fbf'.
	
	self assert: rover window position equals: (0@1) asString .
	! !

!MarsRoverWindowTest methodsFor: 'tests' stamp: 'eaam 10/29/2023 01:43:32'!
test16WindowRegistersMovementAndRotation
	| rover |
	rover := MarsRover at: 0@0 heading: MarsRoverHeadingNorth.
	rover process: 'fr'.

	self assert: rover window direction equals: 'East'.
	self assert: rover window position equals: (0@1) asString .
! !


!classDefinition: #ObserverProxyTest category: 'MarsRover-WithHeading'!
TestCase subclass: #ObserverProxyTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ObserverProxyTest methodsFor: 'tests' stamp: 'eaam 10/29/2023 00:43:15'!
test01AProxyInitializesWithAVariable
	| observer |
	observer := ObserverProxy with: 1.
	self assert: observer variableValue equals: 1.! !

!ObserverProxyTest methodsFor: 'tests' stamp: 'eaam 10/29/2023 02:08:02'!
test02AProxyCanAttachAObserver
	| observer aWindow attachedCollection|
	observer := ObserverProxy with: 1.
	aWindow := RoverWindowPosition new.
	observer attach: aWindow.
	attachedCollection := OrderedCollection new.
	attachedCollection add: aWindow .
	self assert: observer attachedComplements equals: attachedCollection.! !

!ObserverProxyTest methodsFor: 'tests' stamp: 'eaam 10/29/2023 02:07:56'!
test03AProxyCanAttachMultipleObservers
	| observer aWindow aLog attachedCollection|
	observer := ObserverProxy with: 1.
	aWindow := RoverWindowPosition new.
	aLog := MarsRoverLog new.
	observer attach: aWindow.
	observer attach: aLog.
	attachedCollection := OrderedCollection new.
	attachedCollection add: aWindow. attachedCollection add: aLog.
	self assert: observer attachedComplements equals: attachedCollection.! !

!ObserverProxyTest methodsFor: 'tests' stamp: 'eaam 10/29/2023 02:09:05'!
test04AProxyCanActualizeItsVariable
	| observer |
	observer := ObserverProxy with: 0@0.
	observer actualize: 0@1.
	self assert: observer variableValue equals: 0@1 .! !

!ObserverProxyTest methodsFor: 'tests' stamp: 'eaam 10/29/2023 02:10:39'!
test05AProxyCanActualizeAObserver
	| observer aWindow |
	observer := ObserverProxy with: 1.
	aWindow := RoverWindowPosition new.
	aWindow actualize: 0@0.
	observer attach: aWindow.
	observer actualize: 0@1.
	self assert: aWindow position equals: 0@1 .! !

!ObserverProxyTest methodsFor: 'tests' stamp: 'eaam 10/29/2023 02:20:02'!
test06AProxyCanActualizeMultipleObservers
	| observer aWindow anotherWindow|
	observer := ObserverProxy with: 1.
	aWindow := RoverWindowPosition new.
	anotherWindow := RoverWindowPosition new.
	aWindow actualize: 0@0.
	anotherWindow actualize: 10@10.
	observer attach: aWindow.
	observer attach: anotherWindow.
	observer actualize: 0@1.
	self assert: aWindow position equals: 0@1 .
	self assert: anotherWindow position equals: 0@1 .! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head generalLog directionLog positionLog window'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'eaam 10/27/2023 02:04:08'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self .
	
	generalLog := MarsRoverLog new.
	
	directionLog := MarsRoverLog new.
	
	positionLog := MarsRoverLog new.
	
	window := RoverWindow new.
	window actualizePosition: position asString.
	window actualizeDirection: head name.! !


!MarsRover methodsFor: 'heading' stamp: 'eaam 10/27/2023 01:54:10'!
headEast
	
	head := MarsRoverHeadingEast for: self.
	
	generalLog registerToLog: 'East'. directionLog registerToLog: 'East'.
	window actualizeDirection: 'East'.! !

!MarsRover methodsFor: 'heading' stamp: 'eaam 10/27/2023 01:54:28'!
headNorth
	
	head := MarsRoverHeadingNorth for: self .
	
	generalLog registerToLog: 'North'. 	directionLog registerToLog: 'North'.
	window actualizeDirection: 'North'.! !

!MarsRover methodsFor: 'heading' stamp: 'eaam 10/27/2023 01:54:44'!
headSouth
	
	head := MarsRoverHeadingSouth for: self.
	
	generalLog registerToLog: 'South'. 	directionLog registerToLog: 'South'.
	window actualizeDirection: 'South'.! !

!MarsRover methodsFor: 'heading' stamp: 'eaam 10/27/2023 01:54:59'!
headWest
	
	head := MarsRoverHeadingWest for: self .
	
	generalLog registerToLog: 'West'. 	directionLog registerToLog: 'West'.
	window actualizeDirection: 'West'.! !

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

!MarsRover methodsFor: 'moving' stamp: 'eaam 10/27/2023 01:53:52'!
moveEast
	
	position := position + (1@0).
	
	generalLog registerToLog: (position asString). 
	positionLog registerToLog: (position asString).
	window actualizePosition: (position asString).! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'eaam 10/27/2023 01:53:48'!
moveNorth
	
	position := position + (0@1).
	
	generalLog registerToLog: (position asString ). 
	positionLog registerToLog: (position asString ).
	window actualizePosition: (position asString).! !

!MarsRover methodsFor: 'moving' stamp: 'eaam 10/27/2023 01:53:45'!
moveSouth
	
	position := position + (0@-1).
	
	generalLog registerToLog: (position asString).
	positionLog registerToLog: (position asString).
	window actualizePosition: (position asString).! !

!MarsRover methodsFor: 'moving' stamp: 'eaam 10/27/2023 01:53:39'!
moveWest
	
	position := position + (-1@0).
	
	generalLog registerToLog: (position asString).
	positionLog registerToLog: (position asString).
	window actualizePosition: (position asString).! !


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


!MarsRover methodsFor: 'category-name' stamp: 'eaam 10/27/2023 01:37:04'!
directionLog
	^directionLog contents! !

!MarsRover methodsFor: 'category-name' stamp: 'eaam 10/27/2023 01:36:58'!
log
	^generalLog contents ! !

!MarsRover methodsFor: 'category-name' stamp: 'eaam 10/27/2023 01:37:01'!
positionLog
	^positionLog contents! !

!MarsRover methodsFor: 'category-name' stamp: 'eaam 10/27/2023 01:49:20'!
window
	^window! !

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


!MarsRoverHeadingEast methodsFor: 'category-name' stamp: 'eaam 10/27/2023 02:04:37'!
name
	^'East'! !


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


!MarsRoverHeadingNorth methodsFor: 'category-name' stamp: 'eaam 10/27/2023 02:04:57'!
name
	^'North'! !


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


!MarsRoverHeadingSouth methodsFor: 'category-name' stamp: 'eaam 10/27/2023 02:05:26'!
name
	^'South'! !


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


!MarsRoverHeadingWest methodsFor: 'category-name' stamp: 'eaam 10/27/2023 02:05:54'!
name
	^'West'! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #MarsRoverLog category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverLog
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLog methodsFor: 'accessing' stamp: 'eaam 10/27/2023 01:40:55'!
attachToRover: aRover
	"Cada tipo de log debe tener su attach correspondiente, este es un log genérico y por ahora no lo tiene, pero seguramente los tres sean polimorficos"! !

!MarsRoverLog methodsFor: 'accessing' stamp: 'eaam 10/27/2023 01:05:43'!
contents
	^content 
	! !

!MarsRoverLog methodsFor: 'accessing' stamp: 'eaam 10/27/2023 01:07:27'!
registerToLog: objectToAdd
	content add: objectToAdd ! !


!MarsRoverLog methodsFor: 'initialization' stamp: 'eaam 10/27/2023 01:04:11'!
initialize
	content := OrderedCollection new! !


!classDefinition: #ObserverProxy category: 'MarsRover-WithHeading'!
Object subclass: #ObserverProxy
	instanceVariableNames: 'variable attachedObservers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!ObserverProxy methodsFor: 'initialization' stamp: 'eaam 10/29/2023 02:20:53'!
initializeWith: aVariableToStore 
	variable := aVariableToStore.
	attachedObservers := OrderedCollection new.! !


!ObserverProxy methodsFor: 'observer' stamp: 'eaam 10/29/2023 02:20:53'!
actualize: aVariable
	variable := aVariable .
	attachedObservers do: [:aConcreteObserver | aConcreteObserver actualize: variable]
	! !

!ObserverProxy methodsFor: 'observer' stamp: 'eaam 10/29/2023 02:20:53'!
attach: aComplementToAttach
	^attachedObservers add: aComplementToAttach.! !

!ObserverProxy methodsFor: 'observer' stamp: 'eaam 10/29/2023 02:20:53'!
attachedComplements
	^attachedObservers .! !

!ObserverProxy methodsFor: 'observer' stamp: 'eaam 10/29/2023 00:43:59'!
variableValue
	^variable .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ObserverProxy class' category: 'MarsRover-WithHeading'!
ObserverProxy class
	instanceVariableNames: ''!

!ObserverProxy class methodsFor: 'as yet unclassified' stamp: 'eaam 10/29/2023 00:43:32'!
with: aVariable
	^self new initializeWith: aVariable.! !


!classDefinition: #RoverWindow category: 'MarsRover-WithHeading'!
Object subclass: #RoverWindow
	instanceVariableNames: 'positionWindow direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverWindow methodsFor: 'as yet unclassified' stamp: 'eaam 10/27/2023 01:48:11'!
actualizeDirection: aDirection
	direction := aDirection .! !

!RoverWindow methodsFor: 'as yet unclassified' stamp: 'eaam 10/29/2023 01:41:40'!
actualizePosition: aPosition
	positionWindow actualize: aPosition .! !

!RoverWindow methodsFor: 'as yet unclassified' stamp: 'eaam 10/27/2023 01:48:36'!
direction
	^direction! !

!RoverWindow methodsFor: 'as yet unclassified' stamp: 'eaam 10/29/2023 01:42:03'!
initialize
	positionWindow := RoverWindowPosition new.! !

!RoverWindow methodsFor: 'as yet unclassified' stamp: 'eaam 10/29/2023 01:41:23'!
position
	^positionWindow position.! !


!classDefinition: #RoverWindowPosition category: 'MarsRover-WithHeading'!
Object subclass: #RoverWindowPosition
	instanceVariableNames: 'position'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!RoverWindowPosition methodsFor: 'as yet unclassified' stamp: 'eaam 10/29/2023 01:40:09'!
aWindow! !

!RoverWindowPosition methodsFor: 'as yet unclassified' stamp: 'eaam 10/29/2023 01:40:46'!
actualize: aNewPosition
	position := aNewPosition ! !

!RoverWindowPosition methodsFor: 'as yet unclassified' stamp: 'eaam 10/29/2023 01:40:17'!
position
	^position! !
