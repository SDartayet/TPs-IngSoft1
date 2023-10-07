!classDefinition: #MarsRoverTests category: 'MarsRover-Ejercicio'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: 'miMarsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 01:35:48'!
test01MarsRoverStartingPositionAndDirectionDoesntChangeOnItsOwn
	
	self assert: (miMarsRover isInPosition: 0@0 andPointsToDirection: North)! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 01:58:51'!
test02MarsRoverDoesNothingOnReceivingNoCommands
	
	miMarsRover executeCommands: ''.
	
	self assert: (miMarsRover isInPosition: 0@0 andPointsToDirection: North)
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 01:41:40'!
test02MarsRoverStartingDirectionMustBeValid
	
	"self should: [ MarsRover withPosition: 0@0 andDirection: #L. ]
	raise: Error
	withExceptionDo: [ :error | 
			self assert: error messageText equals: MarsRover directionMustBeNSOEErrorDescription ]"
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 01:14:23'!
test03MarsRoverDoesntExecuteInvalidCommands

	
	miMarsRover executeCommands: 'h'.
	
	self assert: (miMarsRover isInPosition: 0@0 andPointsToDirection: North)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 01:14:26'!
test04MarsRoverCanMoveForwardWhenCommandedTo
	
	
	miMarsRover executeCommands: 'f'.
	
	self assert: (miMarsRover isInPosition: 0@1  andPointsToDirection: North)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 01:14:29'!
test05MarsRoverCanMoveBackwardWhenCommandedTo
	
	
	miMarsRover executeCommands: 'b'.
	
	self assert: (miMarsRover isInPosition: 0@-1 andPointsToDirection: North)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 01:14:32'!
test06MarsRoverCanRotateLeftWhenCommandedTo
	
	
	miMarsRover executeCommands: 'l'.
	
	self assert: (miMarsRover isInPosition: 0@0 andPointsToDirection: West)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 01:14:38'!
test07MarsRoverCanRotateRightWhenCommandedTo
	
	
	miMarsRover executeCommands: 'r'.
	
	self assert: (miMarsRover isInPosition: 0@0 andPointsToDirection: East)
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 01:14:40'!
test08MarsRoverMovesForwardMoreThanOnce
	
	
	miMarsRover executeCommands: 'ff'.
	
	self assert: (miMarsRover isInPosition: 0@2 andPointsToDirection: North)
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 01:14:44'!
test09MarsRoverMovesBackwardMoreThanOnce
	
	
	miMarsRover executeCommands: 'bb'.
	
	self assert: (miMarsRover isInPosition: 0@-2 andPointsToDirection: North)
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 01:14:47'!
test10MarsRoverRotateLeftMoreThanOnce
	
	
	miMarsRover executeCommands: 'll'.
	
	self assert: (miMarsRover isInPosition: 0@0 andPointsToDirection: South)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 01:42:09'!
test11MarsRoverRotateRightMoreThanOnce
	
	
	miMarsRover executeCommands: 'rrr'.
	
	self assert: (miMarsRover isInPosition: 0@0 andPointsToDirection: West)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 01:45:32'!
test12MarsRoverRotateRightAndMoveForward
	
	
	miMarsRover executeCommands: 'rf'.
	
	self assert: (miMarsRover isInPosition: 1@0 andPointsToDirection: East)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 01:49:17'!
test13MarsRoverRotateRightAndMoveBackward
	
	
	miMarsRover executeCommands: 'rb'.
	
	self assert: (miMarsRover isInPosition: -1@0 andPointsToDirection: East)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 01:51:17'!
test14MarsRoverStopsProcessingAfterInvalidCommand
	
	
	miMarsRover executeCommands: 'rbhlff'.
	
	self assert: (miMarsRover isInPosition: -1@0 andPointsToDirection: East)
	
	
	! !


!MarsRoverTests methodsFor: 'setup' stamp: 'Sof D 10/7/2023 01:36:01'!
setUp

	
	
	miMarsRover := MarsRover withPosition: 0@0 andDirection: North .
	! !


!classDefinition: #CardinalDirection category: 'MarsRover-Ejercicio'!
Object subclass: #CardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!CardinalDirection methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:49:47'!
whichWayIsBackward
	^self subclassResponsibility ! !

!CardinalDirection methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:46:25'!
whichWayIsForward
	^self subclassResponsibility ! !

!CardinalDirection methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:54:12'!
whichWayIsLeft
	^self subclassResponsibility ! !

!CardinalDirection methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:54:32'!
whichWayIsRight
	^self subclassResponsibility ! !


!classDefinition: #East category: 'MarsRover-Ejercicio'!
CardinalDirection subclass: #East
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!East methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:50:01'!
whichWayIsBackward
	^-1@0! !

!East methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:48:15'!
whichWayIsForward
	^1@0! !

!East methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:54:12'!
whichWayIsLeft
	^North new! !

!East methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:54:32'!
whichWayIsRight
	^South new! !


!classDefinition: #North category: 'MarsRover-Ejercicio'!
CardinalDirection subclass: #North
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!North methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:50:09'!
whichWayIsBackward
	^0@-1! !

!North methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:48:24'!
whichWayIsForward
	^0@1! !

!North methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:54:12'!
whichWayIsLeft
	^West new! !

!North methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:54:33'!
whichWayIsRight
	^East new! !


!classDefinition: #South category: 'MarsRover-Ejercicio'!
CardinalDirection subclass: #South
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!South methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:50:21'!
whichWayIsBackward
	^0@1! !

!South methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:48:31'!
whichWayIsForward
	^0@-1! !

!South methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:54:12'!
whichWayIsLeft
	^East new! !

!South methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:54:33'!
whichWayIsRight
	^West new! !


!classDefinition: #West category: 'MarsRover-Ejercicio'!
CardinalDirection subclass: #West
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!West methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:50:34'!
whichWayIsBackward
	^1@0! !

!West methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:48:40'!
whichWayIsForward
	^-1@0! !

!West methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:54:12'!
whichWayIsLeft
	^South new! !

!West methodsFor: 'observe relative to direction' stamp: 'Sof D 10/7/2023 01:54:33'!
whichWayIsRight
	^North new! !


!classDefinition: #MarsRover category: 'MarsRover-Ejercicio'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!MarsRover methodsFor: 'initialization' stamp: 'Sof D 10/5/2023 21:37:34'!
initializeWithPosition: aPositionToStartIn andDirection: aDirectionToStartOutLookingTowards 
	
	position := aPositionToStartIn.
	direction := aDirectionToStartOutLookingTowards.! !


!MarsRover methodsFor: 'observers' stamp: 'Sof D 10/5/2023 20:30:26'!
direction
	
	^direction! !

!MarsRover methodsFor: 'observers' stamp: 'Sof D 10/7/2023 01:35:42'!
isInPosition: aPositionToEvaluate andPointsToDirection: aDirectionToEvaluate 
	^(position = aPositionToEvaluate) and: (	direction class = aDirectionToEvaluate)! !

!MarsRover methodsFor: 'observers' stamp: 'Sof D 10/5/2023 20:30:09'!
position
	
	^position! !


!MarsRover methodsFor: 'command processing' stamp: 'Sof D 10/7/2023 01:57:39'!
executeCommands: aSeriesOfCommandsToExecute


	aSeriesOfCommandsToExecute do: [ : aCommand | 
			('fblr' includes: aCommand) ifFalse: [^''].
			self executeSingleCommand: aCommand.
		].! !

!MarsRover methodsFor: 'command processing' stamp: 'Sof D 10/7/2023 01:59:42'!
executeSingleCommand: aCommandToRun

	(aCommandToRun = $f) ifTrue: [ position := position + direction whichWayIsForward ].
	(aCommandToRun = $b) ifTrue: [ position := position + direction whichWayIsBackward ].
	(aCommandToRun = $l) ifTrue: [ direction := direction whichWayIsLeft ].
	(aCommandToRun = $r) ifTrue: [ direction := direction whichWayIsRight ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Ejercicio'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'Sof D 10/7/2023 01:18:24'!
withPosition: aPositionToStartIn andDirection: aDirectionToStartOutLookingTowards 
	
	self isDirectionValid: aDirectionToStartOutLookingTowards.
	
	^self new initializeWithPosition: aPositionToStartIn andDirection: aDirectionToStartOutLookingTowards new! !


!MarsRover class methodsFor: 'as yet unclassified' stamp: 'Sof D 10/5/2023 20:36:54'!
directionMustBeNSOEErrorDescription
	^'Direction must be North (N), South (S), West (O) or East (E)'! !

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'Sof D 10/7/2023 01:38:52'!
isDirectionValid: aDirectionToValidate
	(aDirectionToValidate superclass = CardinalDirection) ifFalse: [ self error: self directionMustBeNSOEErrorDescription ]
	! !
