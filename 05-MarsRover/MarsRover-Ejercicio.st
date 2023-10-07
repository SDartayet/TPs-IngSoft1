!classDefinition: #MarsRoverTests category: 'MarsRover-Ejercicio'!
TestCase subclass: #MarsRoverTests
	instanceVariableNames: 'miMarsRover north south east west'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 03:04:12'!
test01MarsRoverStartingPositionAndDirectionDoesntChangeOnItsOwn
	
	self assert: (miMarsRover isInPosition: 0@0 andPointsToDirection: north )! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 03:04:19'!
test02MarsRoverDoesNothingOnReceivingNoCommands
	
	miMarsRover executeCommands: ''.
	
	self assert: (miMarsRover isInPosition: 0@0 andPointsToDirection: north)
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 03:04:23'!
test03MarsRoverDoesntExecuteInvalidCommands

	
	miMarsRover executeCommands: 'h'.
	
	self assert: (miMarsRover isInPosition: 0@0 andPointsToDirection: north)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 03:04:26'!
test04MarsRoverCanMoveForwardWhenCommandedTo
	
	
	miMarsRover executeCommands: 'f'.
	
	self assert: (miMarsRover isInPosition: 0@1  andPointsToDirection: north)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 03:04:32'!
test05MarsRoverCanMoveBackwardWhenCommandedTo
	
	
	miMarsRover executeCommands: 'b'.
	
	self assert: (miMarsRover isInPosition: 0@-1 andPointsToDirection: north)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 03:04:48'!
test06MarsRoverCanRotateLeftWhenCommandedTo
	
	
	miMarsRover executeCommands: 'l'.
	
	self assert: (miMarsRover isInPosition: 0@0 andPointsToDirection: west)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 03:05:03'!
test07MarsRoverCanRotateRightWhenCommandedTo
	
	
	miMarsRover executeCommands: 'r'.
	
	self assert: (miMarsRover isInPosition: 0@0 andPointsToDirection: east)
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 03:04:43'!
test08MarsRoverMovesForwardMoreThanOnce
	
	
	miMarsRover executeCommands: 'ff'.
	
	self assert: (miMarsRover isInPosition: 0@2 andPointsToDirection: north)
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 03:05:36'!
test09MarsRoverMovesBackwardMoreThanOnce
	
	
	miMarsRover executeCommands: 'bb'.
	
	self assert: (miMarsRover isInPosition: 0@-2 andPointsToDirection: north)
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 03:05:33'!
test10MarsRoverRotateLeftMoreThanOnce
	
	
	miMarsRover executeCommands: 'll'.
	
	self assert: (miMarsRover isInPosition: 0@0 andPointsToDirection: south)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 03:05:29'!
test11MarsRoverRotateRightMoreThanOnce
	
	
	miMarsRover executeCommands: 'rrr'.
	
	self assert: (miMarsRover isInPosition: 0@0 andPointsToDirection: west)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 03:05:25'!
test12MarsRoverRotateRightAndMoveForward
	
	
	miMarsRover executeCommands: 'rf'.
	
	self assert: (miMarsRover isInPosition: 1@0 andPointsToDirection: east)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 03:05:20'!
test13MarsRoverRotateRightAndMoveBackward
	
	
	miMarsRover executeCommands: 'rb'.
	
	self assert: (miMarsRover isInPosition: -1@0 andPointsToDirection: east)
	
	
	! !

!MarsRoverTests methodsFor: 'tests' stamp: 'Sof D 10/7/2023 03:05:17'!
test14MarsRoverStopsProcessingAfterInvalidCommand
	
	
	miMarsRover executeCommands: 'rbhlff'.
	
	self assert: (miMarsRover isInPosition: -1@0 andPointsToDirection: east)
	
	
	! !


!MarsRoverTests methodsFor: 'setup' stamp: 'Sof D 10/7/2023 03:03:33'!
setUp

	north := FacingNorth new.
	south := FacingSouth new.
	east := FacingEast new.
	west := FacingWest new.
	
	miMarsRover := MarsRover withPosition: 0@0 andDirection: north.
	! !


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


!MarsRover methodsFor: 'observers' stamp: 'Sof D 10/7/2023 03:01:20'!
isInPosition: aPositionToEvaluate andPointsToDirection: aDirectionToEvaluate 
	^(position = aPositionToEvaluate) and: (	direction = aDirectionToEvaluate)! !


!MarsRover methodsFor: 'command processing' stamp: 'Sof D 10/7/2023 01:57:39'!
executeCommands: aSeriesOfCommandsToExecute


	aSeriesOfCommandsToExecute do: [ : aCommand | 
			('fblr' includes: aCommand) ifFalse: [^''].
			self executeSingleCommand: aCommand.
		].! !

!MarsRover methodsFor: 'command processing' stamp: 'Sof D 10/7/2023 03:08:16'!
executeSingleCommand: aCommandToRun

	(aCommandToRun = $f) ifTrue: [ direction howToMoveForward: self ].
	(aCommandToRun = $b) ifTrue: [ direction howToMoveBackward: self ].
	(aCommandToRun = $l) ifTrue: [ direction howToRotateLeft: self ].
	(aCommandToRun = $r) ifTrue: [ direction howToRotateRight: self ]! !


!MarsRover methodsFor: 'movement' stamp: 'Sof D 10/7/2023 02:39:11'!
moveEast
	position := position + (1@0)! !

!MarsRover methodsFor: 'movement' stamp: 'Sof D 10/7/2023 02:39:30'!
moveNorth
	position := position + (0@1)! !

!MarsRover methodsFor: 'movement' stamp: 'Sof D 10/7/2023 02:38:59'!
moveSouth
	position := position + (0@-1)! !

!MarsRover methodsFor: 'movement' stamp: 'Sof D 10/7/2023 02:39:21'!
moveWest
	position := position + (-1@0)! !

!MarsRover methodsFor: 'movement' stamp: 'Sof D 10/7/2023 02:56:01'!
rotateEast
	direction := FacingEast new! !

!MarsRover methodsFor: 'movement' stamp: 'Sof D 10/7/2023 02:56:23'!
rotateNorth
	direction := FacingNorth new! !

!MarsRover methodsFor: 'movement' stamp: 'Sof D 10/7/2023 02:56:30'!
rotateSouth
	direction := FacingSouth new! !

!MarsRover methodsFor: 'movement' stamp: 'Sof D 10/7/2023 02:59:39'!
rotateWest
	direction := FacingWest new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-Ejercicio'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'initialization' stamp: 'Sof D 10/7/2023 02:51:37'!
withPosition: aPositionToStartIn andDirection: aDirectionToStartOutLookingTowards 
	

	
	^self new initializeWithPosition: aPositionToStartIn andDirection: aDirectionToStartOutLookingTowards! !


!classDefinition: #RoverDirection category: 'MarsRover-Ejercicio'!
Object subclass: #RoverDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!RoverDirection methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:21:50'!
howToMoveBackward: anObjectThatMoves
	^self subclassResponsibility ! !

!RoverDirection methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:22:03'!
howToMoveForward: anObjectThatMoves
	^self subclassResponsibility ! !

!RoverDirection methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:57:53'!
howToRotateLeft: anObjectToRotate
	^self subclassResponsibility ! !

!RoverDirection methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:58:39'!
howToRotateRight: anObjectToRotate
	^self subclassResponsibility ! !


!RoverDirection methodsFor: 'as yet unclassified' stamp: 'Sof D 10/7/2023 03:02:22'!
= anObjectToCompare
	^(anObjectToCompare class) = (self class)! !


!classDefinition: #FacingEast category: 'MarsRover-Ejercicio'!
RoverDirection subclass: #FacingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!FacingEast methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:39:21'!
howToMoveBackward: anObjectThatMoves
	anObjectThatMoves moveWest! !

!FacingEast methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:39:11'!
howToMoveForward: anObjectThatMoves
	anObjectThatMoves moveEast! !

!FacingEast methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:58:19'!
howToRotateLeft: anObjectToRotate
	anObjectToRotate rotateNorth ! !

!FacingEast methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:58:50'!
howToRotateRight: anObjectToRotate
	anObjectToRotate rotateSouth ! !


!classDefinition: #FacingNorth category: 'MarsRover-Ejercicio'!
RoverDirection subclass: #FacingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!FacingNorth methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:39:00'!
howToMoveBackward: anObjectThatMoves
	anObjectThatMoves moveSouth! !

!FacingNorth methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:39:31'!
howToMoveForward: anObjectThatMoves
	anObjectThatMoves moveNorth ! !

!FacingNorth methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:59:53'!
howToRotateLeft: anObjectToRotate
	anObjectToRotate rotateWest ! !

!FacingNorth methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:59:59'!
howToRotateRight: anObjectToRotate
	anObjectToRotate rotateEast ! !


!classDefinition: #FacingSouth category: 'MarsRover-Ejercicio'!
RoverDirection subclass: #FacingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!FacingSouth methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:39:31'!
howToMoveBackward: anObjectThatMoves
	anObjectThatMoves moveNorth ! !

!FacingSouth methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:39:00'!
howToMoveForward: anObjectThatMoves
	anObjectThatMoves moveSouth ! !

!FacingSouth methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:58:59'!
howToRotateLeft: anObjectToRotate
	anObjectToRotate rotateEast ! !

!FacingSouth methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:59:12'!
howToRotateRight: anObjectToRotate
	anObjectToRotate rotateWest! !


!classDefinition: #FacingWest category: 'MarsRover-Ejercicio'!
RoverDirection subclass: #FacingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-Ejercicio'!

!FacingWest methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:39:11'!
howToMoveBackward: anObjectThatMoves
	anObjectThatMoves moveEast ! !

!FacingWest methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 02:39:21'!
howToMoveForward: anObjectThatMoves
	anObjectThatMoves moveWest 
	! !

!FacingWest methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 03:00:07'!
howToRotateLeft: anObjectToRotate
	anObjectToRotate rotateSouth ! !

!FacingWest methodsFor: 'action relative to direction' stamp: 'Sof D 10/7/2023 03:00:19'!
howToRotateRight: anObjectToRotate
	anObjectToRotate rotateNorth! !
