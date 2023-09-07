!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'Sof D 9/5/2023 00:51:49'!
currentTimeInMilliseconds

	^ Time millisecondClockValue * millisecond! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Sof D 9/5/2023 01:08:23'!
isRuntimeOf: aClosure lessThan: anAmountOfMilliseconds

	| millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := self currentTimeInMilliseconds.
	aClosure value.
	millisecondsAfterRunning := self currentTimeInMilliseconds.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (anAmountOfMilliseconds * millisecond)! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Sof D 9/5/2023 02:16:11'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self isRuntimeOf: [ customerBook addCustomerNamed: 'John Lennon'.] lessThan: 50

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Sof D 9/5/2023 02:15:40'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	self isRuntimeOf: [ customerBook removeCustomerNamed: paulMcCartney.] lessThan: 100

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Sof D 9/7/2023 04:43:10'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self tryToDo: [ customerBook addCustomerNamed: ''.] 	onError: Error do: [ : anError| self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage. self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Sof D 9/7/2023 04:43:35'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self tryToDo: [ customerBook removeCustomerNamed: 'Paul McCartney'.] 		onError: NotFound 	do: [ self assert: customerBook numberOfCustomers = 1. self assert:( customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Sof D 9/7/2023 04:46:25'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self theCustomerBook: customerBook hasActive: 0 andSuspended: 1 andFulfills: [(customerBook includesCustomerNamed: paulMcCartney)].



	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ea 9/5/2023 11:35:27'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	
		self theCustomerBook: customerBook hasActive: 0 andSuspended: 0 andFulfills: [(customerBook includesCustomerNamed: paulMcCartney) not].


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Sof D 9/7/2023 04:47:32'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self tryToDo: [ customerBook suspendCustomerNamed: 'George Harrison'.] 		onError: CantSuspend do: [self assert: customerBook numberOfCustomers = 1. self assert:( customerBook includesCustomerNamed: johnLennon )]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Sof D 9/7/2023 04:47:08'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self tryToDo: [ customerBook suspendCustomerNamed: johnLennon ] onError: CantSuspend
		do: [self assert: customerBook numberOfCustomers = 1. self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'ea 9/5/2023 11:32:58'!
theCustomerBook: customerBook hasActive: aNumber andSuspended: anotherNumber andFulfills: aClosure
	self assert: aNumber equals: customerBook numberOfActiveCustomers.
	self assert: anotherNumber equals: customerBook numberOfSuspendedCustomers.
	self assert: (aNumber+anotherNumber) equals: customerBook numberOfCustomers.
	self assert: aClosure.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Sof D 9/7/2023 04:48:42'!
tryToDo: aClosure onError: aKindOfError do: anotherClosure
	[aClosure value. self fail]
		on: aKindOfError 
		do: anotherClosure! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'Sof D 9/5/2023 02:32:23'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'ea 9/5/2023 16:23:16'!
from: aCollection remove: aName ifNotFound: aClosure
	1 to: aCollection size do: 
	[ :index |
		aName = (aCollection at: index)
			ifTrue: [
				aCollection removeAt: index.
				 ^aName 
			] 
	].
	^aClosure value! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'ea 9/5/2023 16:21:48'!
removeCustomerNamed: aName 
 
	^self from: active remove: aName ifNotFound:
	[self from: suspended remove: aName ifNotFound:[NotFound signal]].
! !

!CustomerBook methodsFor: 'customer management' stamp: 'Sof D 9/7/2023 03:50:23'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'Sof D 9/7/2023 03:50:32'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:48'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 9/4/2023 17:02:52'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
