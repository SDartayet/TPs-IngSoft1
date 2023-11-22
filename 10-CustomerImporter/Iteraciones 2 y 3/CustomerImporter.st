!classDefinition: #Enviroment category: 'CustomerImporter'!
TestCase subclass: #Enviroment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Enviroment methodsFor: 'as yet unclassified' stamp: 'eaam 11/19/2023 19:57:19'!
createSystem
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Enviroment class' category: 'CustomerImporter'!
Enviroment class
	instanceVariableNames: ''!

!Enviroment class methodsFor: 'as yet unclassified' stamp: 'eaam 11/19/2023 19:56:07'!
current
	^(self subclasses detect: [:anEnviroment | anEnviroment isCurrent]) new.! !


!classDefinition: #Development category: 'CustomerImporter'!
Enviroment subclass: #Development
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Development methodsFor: 'as yet unclassified' stamp: 'eaam 11/19/2023 19:57:47'!
createSystem
	^TransientCustomerSystem new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Development class' category: 'CustomerImporter'!
Development class
	instanceVariableNames: ''!

!Development class methodsFor: 'as yet unclassified' stamp: 'eaam 11/19/2023 19:51:31'!
isCurrent
	^(Smalltalk at: #env) = 'dev'! !


!classDefinition: #Integration category: 'CustomerImporter'!
Enviroment subclass: #Integration
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Integration methodsFor: 'as yet unclassified' stamp: 'eaam 11/19/2023 19:58:39'!
createSystem
	^PersistentCustomerSystem new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Integration class' category: 'CustomerImporter'!
Integration class
	instanceVariableNames: ''!

!Integration class methodsFor: 'as yet unclassified' stamp: 'eaam 11/19/2023 19:52:19'!
isCurrent
	^Development isCurrent not.! !


!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'customerSystem validInputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:20:26'!
assertAddress: anAddressToCompare haveProvince: aProvinceToCheck andStreetNumber: aStreetNumberToCheck andStreetName: aStreetNameToCheck andZipCode: aZipCodeToCheck andTown: aTownToCheck  

	self assert: anAddressToCompare province equals: aProvinceToCheck .
	self assert: anAddressToCompare streetNumber equals: aStreetNumberToCheck .
	self assert: anAddressToCompare streetName equals: aStreetNameToCheck .
	self assert: anAddressToCompare zipCode equals: aZipCodeToCheck .
	self assert: anAddressToCompare town equals: aTownToCheck .! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:19:12'!
assertCustomer: aCustomerToCompare haveFirstName: aFirstNameToCheck andLastName: aLastNameToCheck andIDType: anIDTypeToCheck andIDNumber: anIDNumberToCheck  

	self assert: aCustomerToCompare firstName equals: aFirstNameToCheck .
	self assert: aCustomerToCompare lastName equals: aLastNameToCheck .
	self assert: aCustomerToCompare identificationType equals: anIDTypeToCheck .
	self assert: aCustomerToCompare identificationNumber equals: anIDNumberToCheck .! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:16:39'!
assertCustomerImporterImportsRightAmountOfCustomers

	| numberOfCostumers |
	numberOfCostumers := (customerSystem selectAllOfType: Customer) size.	
	self assert: numberOfCostumers equals: 2! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:18:10'!
assertCustomerImporterOnlyImportsOneOfEachCustomer

	| listOfSanchez listOfPerez|
	listOfSanchez := self getAllCustomersWithIDType: 'D' andIDNumber: '22333444'.
		
	listOfPerez := self getAllCustomersWithIDType: 'C' andIDNumber: '23-25666777-9'.
	
	self assert: listOfSanchez size equals: 1. self assert: listOfPerez size equals: 1! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:44:21'!
forImporter: aImporter shouldImportCustomersRaiseAnErrorErrorMessage: aErrorMessage withCondition: aClossure   

	^ self should: [aImporter importCustomers]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: anError messageText equals: aErrorMessage.
		aClossure value.
		]! !

!ImportTest methodsFor: 'tests' stamp: 'S D 11/22/2023 14:25:56'!
getCustomerWithIDType: theTypeOfID andIDNumber: theIDNumberOfTheCustomer 

	^( self getAllCustomersWithIDType: theTypeOfID andIDNumber: theIDNumberOfTheCustomer) anyOne! !

!ImportTest methodsFor: 'tests' stamp: 'S D 11/22/2023 01:25:05'!
importCustomersForReadStream: aReadStreamToRead forSystem: aSessionToRecordDataOn
	(CustomerImporter forCustomerSystemToRecordOn: aSessionToRecordDataOn andInputStreamWithCustomerData: aReadStreamToRead) importCustomers! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:18:20'!
test01ImportAddsTheCorrectNumberOfCustomers

	self importCustomersForReadStream: validInputStream forSystem: customerSystem .
	
	self assertCustomerImporterImportsRightAmountOfCustomers.
	
	self assertCustomerImporterOnlyImportsOneOfEachCustomer.
	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:19:12'!
test02PepeSanchezIsImportedCorrectly

	| customer |	
	self importCustomersForReadStream: validInputStream forSystem: customerSystem .
	customer := self getCustomerWithIDType: 'D' andIDNumber: '22333444'.
	self assertCustomer: customer haveFirstName: 'Pepe' andLastName: 'Sanchez' andIDType: 'D' andIDNumber: '22333444' .	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:19:12'!
test03JuanPerezIsImportedCorrectly

	| customer |
	
	self importCustomersForReadStream: validInputStream forSystem: customerSystem .
	customer := self getCustomerWithIDType: 'C' andIDNumber: '23-25666777-9'.

	self assertCustomer: customer haveFirstName: 'Juan' andLastName: 'Perez' andIDType: 'C' andIDNumber: '23-25666777-9'.! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:20:26'!
test04PepeSanchezDataIsImportedCorrectly

	| customer firstAddressesOfCustomer secondAddressesOfCustomer |

	self importCustomersForReadStream: validInputStream forSystem: customerSystem .
	customer := self getCustomerWithIDType: 'D' andIDNumber: '22333444'.
	firstAddressesOfCustomer := customer addressAt: 'San Martin' ifNone: [self fail.].	secondAddressesOfCustomer := customer addressAt: 'Maipu' ifNone: [self fail.].

	self assertAddress: firstAddressesOfCustomer haveProvince: 'BsAs' andStreetNumber: 3322 andStreetName: 'San Martin' andZipCode: 1636 andTown: 'Olivos'.
	
	self assertAddress: secondAddressesOfCustomer haveProvince: 'Buenos Aires' andStreetNumber: 		888 andStreetName: 'Maipu' andZipCode: 1122 andTown: 'Florida' .
! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:20:26'!
test05JuanPerezDataIsImportedCorrectly

	| customer listOfCustomerAddresses |
	self importCustomersForReadStream: validInputStream forSystem: customerSystem .
	customer := self getCustomerWithIDType: 'C' andIDNumber: '23-25666777-9'.
	listOfCustomerAddresses := customer addressAt: 'Alem' ifNone: [self fail.].
	
	self assertAddress: listOfCustomerAddresses haveProvince: 'CABA' andStreetNumber: 1122 andStreetName: 'Alem' andZipCode: 1001 andTown: 'CABA' .
! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:45:12'!
test06FailImportingWhenCustomerRecordHasLessThanFiveParameters

	| importer|
	importer := CustomerImporter forCustomerSystemToRecordOn: customerSystem andInputStreamWithCustomerData: (ReadStream on: 'C,Hernan,0,smallTalk').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer invalidCustomerRecord 
	withCondition: [self assert: self customerSystemDataIsEmpty]! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:45:21'!
test07FailImportingWhenCustomerRecordHasMoreThanFiveParameters

	| importer|
	importer := CustomerImporter forCustomerSystemToRecordOn: customerSystem andInputStreamWithCustomerData: (ReadStream on: 'C,Hernan,0,smallTalk,cuis,TDD').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer invalidCustomerRecord 
	withCondition: [self assert: self customerSystemDataIsEmpty]! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:48:15'!
test08FailImportingWhenAddressRecordHasLessThanFiveParameters

	| importer|
	importer := CustomerImporter forCustomerSystemToRecordOn: customerSystem andInputStreamWithCustomerData: (ReadStream on: 'C,Hernan,0,smallTalk,cuis
A,Henderson,712,Red Bark Ln,1122').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer invalidAddressRecord 
	withCondition: [| customer |
		customer := self getCustomerWithIDType: 'smallTalk' andIDNumber: 'cuis'.
		self assert: customer addresses isEmpty.]
	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:48:20'!
test09FailImportingWhenAddressRecordHasMoreThanFiveParameters

	| importer|
	importer := CustomerImporter forCustomerSystemToRecordOn: customerSystem andInputStreamWithCustomerData: (ReadStream on: 'C,Hernan,0,smallTalk,cuis
A,Henderson,712,Red Bark Ln,1122,Nevada,Tompson').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer invalidAddressRecord 
	withCondition: [| customer |
		customer := self getCustomerWithIDType: 'smallTalk' andIDNumber: 'cuis'.
		self assert: customer addresses isEmpty.]
	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:46:00'!
test10FailImportingWhenRecordHasAnInvalidType

	| importer|
	importer := CustomerImporter forCustomerSystemToRecordOn: customerSystem andInputStreamWithCustomerData: (ReadStream on: 'HelloWorld,Hernan,0,smallTalk,cuis').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer invalidRecord 
	withCondition: [self assert: self customerSystemDataIsEmpty]
	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:45:53'!
test11FailImportingWhenRecordHasEmptyLine

	| importer|
	importer := CustomerImporter forCustomerSystemToRecordOn: customerSystem andInputStreamWithCustomerData: (ReadStream on: '
HelloWorld,Hernan,0,smallTalk,cuis').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer invalidRecord
	withCondition: [self assert: self customerSystemDataIsEmpty] .
	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:46:14'!
test12FailImportingWhenAddressHasNoAssociatedCustomer

	| importer|
	importer := CustomerImporter forCustomerSystemToRecordOn: customerSystem andInputStreamWithCustomerData: (ReadStream on:  'A,Henderson,71a2,Red Bark Ln,1122, Louisiana').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer invalidAddressRecord 
	withCondition: [self assert: self customerSystemDataIsEmpty] .
	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:47:42'!
test13FailImportingWhenAddressRecordTypeIsNotA

	| importer|
	importer := CustomerImporter forCustomerSystemToRecordOn: customerSystem andInputStreamWithCustomerData: (ReadStream on: 'C,Hernan,0,smallTalk,cuis
Alpaca,Henderson,712,Red Bark Ln,1122,Nevada').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer invalidRecord
	withCondition: [| customer |
		customer := self getCustomerWithIDType: 'smallTalk' andIDNumber: 'cuis'.
		self assert: customer addresses isEmpty.]
		! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/22/2023 18:46:19'!
test14FailImportingWhenCustomerRecordTypeIsNotC

	| importer|
	importer := CustomerImporter forCustomerSystemToRecordOn: customerSystem andInputStreamWithCustomerData: (ReadStream on: 'Cobayo,Hernan,0,smallTalk,cuis
A,Henderson,712,Red Bark Ln,1122,Nevada').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer invalidRecord
	withCondition: [self assert: self customerSystemDataIsEmpty] .! !



!ImportTest methodsFor: 'tear down' stamp: 'eaam 11/19/2023 20:06:55'!
tearDown
	customerSystem close.
		
	validInputStream close.! !


!ImportTest methodsFor: 'set up' stamp: 'eaam 11/19/2023 20:07:00'!
setUp

	customerSystem := CustomerSystem newCustomerSystem .
	customerSystem start.
	validInputStream :=  ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !


!ImportTest methodsFor: 'private' stamp: 'S D 11/22/2023 14:24:35'!
customerSystemDataIsEmpty
	^customerSystem isEmpty.! !

!ImportTest methodsFor: 'private' stamp: 'eaam 11/19/2023 20:06:55'!
getAllCustomersWithIDType: theIDTypeOfTheCustomers andIDNumber: theIDNumberOfTheCustomers 

	^ customerSystem 
		select: [:aCustomer | (aCustomer hasIdentificationType: theIDTypeOfTheCustomers) and:[ aCustomer hasIdentificationNumber: theIDNumberOfTheCustomers]] 
		ofType: Customer! !


!classDefinition: #Address category: 'CustomerImporter'!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'eaam 11/16/2023 18:29:11'!
isInStreet: aAddressDirection
	^aAddressDirection = streetName .! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'town' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'town' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: 'CustomerImporter'!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'eaam 11/19/2023 19:34:36'!
hasIdentificationType: aIDType
	^aIDType = identificationType
! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'S D 11/22/2023 01:38:59'!
initialize
	
	super initialize.
	
	addresses := OrderedCollection new.! !


!Customer methodsFor: 'testing' stamp: 'eaam 11/16/2023 18:34:13'!
addressAt: aStreetToSearchFor ifNone: aBlockIfNone 
	^addresses detect: [:anAddress | anAddress isInStreet: aStreetToSearchFor ] ifNone: aBlockIfNone.! !

!Customer methodsFor: 'testing' stamp: 'eaam 11/19/2023 19:35:30'!
hasIdentificationNumber: aIDNumber
	^aIDNumber = identificationNumber 
! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'customerSystem inputStream line newCustomer newAddress record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'eaam 11/22/2023 18:57:10'!
initializeForCustomerSystemToRecordOn: aCustomerSystemToRecordDataOn andInputStreamWithCustomerData: anInputStream

	customerSystem := aCustomerSystemToRecordDataOn.
	inputStream := anInputStream.! !


!CustomerImporter methodsFor: 'error handling' stamp: 'eaam 11/22/2023 18:55:52'!
invalidAddressRecord
	^'an address record must have 6 parameters'.! !

!CustomerImporter methodsFor: 'error handling' stamp: 'eaam 11/22/2023 18:56:04'!
invalidCustomerRecord
	^'an custoer record must have 5 parameters'! !

!CustomerImporter methodsFor: 'error handling' stamp: 'eaam 11/22/2023 18:56:42'!
invalidRecord
	^'record cant be empty and every line must start with "C" or "A"'! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'eaam 11/16/2023 18:47:15'!
importCustomers 
	[self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord.
		].
	! !


!CustomerImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/16/2023 21:12:37'!
createRecord
	
	^ record := line findTokens: $,! !

!CustomerImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/22/2023 18:55:08'!
importAddress

	self signalIfRecordHasNotSixParameters .

	newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: record second.
			newAddress streetNumber: record third asNumber .
			newAddress town: record fourth.
			newAddress zipCode: record fifth asNumber .
			newAddress province: record sixth! !

!CustomerImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/22/2023 18:53:50'!
importCustomer

	self signalIfRecordHasNotFiveParameters .
		
	newCustomer := Customer new.
			newCustomer firstName: record second.
			newCustomer lastName: record third.
			newCustomer identificationType: record fourth.
			newCustomer identificationNumber: record fifth.
			customerSystem addCustomer: newCustomer! !

!CustomerImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/22/2023 18:49:41'!
importRecord

	self signalIfRecordIsEmpty.
	(self isCustomerRecord) ifTrue: [ ^self importCustomer ].
	(self isAddressRecord) ifTrue: [ 		^self importAddress.].
	self error: self invalidRecord! !


!CustomerImporter methodsFor: 'input validation' stamp: 'eaam 11/16/2023 18:46:12'!
hasLineToImport

	line := inputStream nextLine. 
	^line notNil! !

!CustomerImporter methodsFor: 'input validation' stamp: 'eaam 11/16/2023 20:56:09'!
isAddressRecord

	^ record first = 'A'! !

!CustomerImporter methodsFor: 'input validation' stamp: 'eaam 11/16/2023 20:59:18'!
isCustomerRecord

	^ record first = 'C'! !

!CustomerImporter methodsFor: 'input validation' stamp: 'eaam 11/22/2023 18:54:58'!
recordHasValidType

	^self isCustomerRecord or: self isAddressRecord ! !

!CustomerImporter methodsFor: 'input validation' stamp: 'eaam 11/22/2023 18:54:47'!
signalIfRecordHasNotFiveParameters

	((record size = 5 ) not) ifTrue: [self error: self invalidCustomerRecord].! !

!CustomerImporter methodsFor: 'input validation' stamp: 'eaam 11/22/2023 18:54:49'!
signalIfRecordHasNotSixParameters

	((record size = 6 ) not or: (newCustomer isNil)) ifTrue: [self error: self invalidAddressRecord].! !

!CustomerImporter methodsFor: 'input validation' stamp: 'eaam 11/22/2023 18:54:53'!
signalIfRecordIsEmpty

	^ (record isEmpty) ifTrue: [ self error: self invalidRecord ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'eaam 11/19/2023 20:01:54'!
forCustomerSystemToRecordOn: aCustomerSystemToRecordDataOn andInputStreamWithCustomerData: anInputStreamToReadFrom 
	^self new initializeForCustomerSystemToRecordOn: aCustomerSystemToRecordDataOn andInputStreamWithCustomerData: anInputStreamToReadFrom ! !


!classDefinition: #CustomerSystem category: 'CustomerImporter'!
Object subclass: #CustomerSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerSystem methodsFor: 'customer management' stamp: 'eaam 11/19/2023 19:14:30'!
addCustomer: anObject

	self subclassResponsibility! !

!CustomerSystem methodsFor: 'customer management' stamp: 'eaam 11/19/2023 19:17:38'!
isEmpty

	self subclassResponsibility! !

!CustomerSystem methodsFor: 'customer management' stamp: 'eaam 11/19/2023 19:17:42'!
select: aCondition ofType: aType

	self subclassResponsibility! !

!CustomerSystem methodsFor: 'customer management' stamp: 'eaam 11/19/2023 19:17:45'!
selectAllOfType: aType

	self subclassResponsibility! !


!CustomerSystem methodsFor: 'transaction management' stamp: 'eaam 11/19/2023 19:12:08'!
beginTransaction
	self subclassResponsibility .! !

!CustomerSystem methodsFor: 'transaction management' stamp: 'eaam 11/19/2023 19:17:30'!
close

	self subclassResponsibility! !

!CustomerSystem methodsFor: 'transaction management' stamp: 'eaam 11/19/2023 19:17:50'!
start

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerSystem class' category: 'CustomerImporter'!
CustomerSystem class
	instanceVariableNames: ''!

!CustomerSystem class methodsFor: 'as yet unclassified' stamp: 'eaam 11/19/2023 20:03:09'!
newCustomerSystem
	^Enviroment current createSystem .! !


!classDefinition: #PersistentCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #PersistentCustomerSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentCustomerSystem methodsFor: 'initialization' stamp: 'eaam 11/19/2023 18:22:26'!
initialize
	 
	session := DataBaseSession for: (Array with: Address with: Customer).! !


!PersistentCustomerSystem methodsFor: 'customer management' stamp: 'eaam 11/19/2023 19:36:37'!
addCustomer: anObject 
	session persist: anObject.! !

!PersistentCustomerSystem methodsFor: 'customer management' stamp: 'eaam 11/19/2023 19:07:02'!
isEmpty
	^session isEmpty .! !

!PersistentCustomerSystem methodsFor: 'customer management' stamp: 'eaam 11/19/2023 19:02:33'!
select: aCondition ofType: aType
	^session select: aCondition ofType: aType.! !

!PersistentCustomerSystem methodsFor: 'customer management' stamp: 'eaam 11/19/2023 18:28:40'!
selectAllOfType: aType 
	^session selectAllOfType: aType.! !


!PersistentCustomerSystem methodsFor: 'transaction management' stamp: 'eaam 11/19/2023 19:16:11'!
close
	session commit.
	session close.! !

!PersistentCustomerSystem methodsFor: 'transaction management' stamp: 'eaam 11/19/2023 19:15:39'!
start
	session beginTransaction.! !


!classDefinition: #TransientCustomerSystem category: 'CustomerImporter'!
CustomerSystem subclass: #TransientCustomerSystem
	instanceVariableNames: 'dataCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientCustomerSystem methodsFor: 'transaction management' stamp: 'eaam 11/19/2023 19:25:25'!
close! !

!TransientCustomerSystem methodsFor: 'transaction management' stamp: 'eaam 11/19/2023 20:06:06'!
isEmpty
	^dataCollection isEmpty.! !

!TransientCustomerSystem methodsFor: 'transaction management' stamp: 'eaam 11/19/2023 19:20:19'!
start! !


!TransientCustomerSystem methodsFor: 'initialization' stamp: 'eaam 11/19/2023 20:06:06'!
initialize
	 
	dataCollection := OrderedCollection new.! !


!TransientCustomerSystem methodsFor: 'customer management' stamp: 'eaam 11/19/2023 20:06:06'!
addCustomer: anObject 
	dataCollection add: anObject.! !

!TransientCustomerSystem methodsFor: 'customer management' stamp: 'eaam 11/22/2023 18:57:49'!
select: aCondition ofType: aType
	^((self selectAllOfType: aType) select: aCondition )copy.! !

!TransientCustomerSystem methodsFor: 'customer management' stamp: 'eaam 11/22/2023 18:57:33'!
selectAllOfType: aType 
	^dataCollection select:[:anObject | anObject class = aType] copy.! !


!classDefinition: #DataBaseSession category: 'CustomerImporter'!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'eaam 11/13/2023 20:20:11'!
beginTransaction
! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 5/22/2022 19:17:36'!
commit

	(tables at: Customer ifAbsent: [#()]) do: [ :aCustomer | self persistAddressesOf: aCustomer ]
	! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 5/22/2022 00:19:29'!
close

	! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 19:29:06'!
objectsOfType: aType

	^ tables at: aType ifAbsent: [ #() ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'eaam 11/19/2023 19:13:54'!
persistAddressesOf: anObjectWithAddresses

	anObjectWithAddresses addresses do: [ :anAddress | self persist: anAddress ]
	! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'eaam 11/19/2023 19:13:54'!
persist: anObject

	| table |

	self delay.
	table := tables at: anObject class ifAbsentPut: [ Set new ].

	self defineIdOf: anObject.
	table add: anObject.

	(anObject isKindOf: Customer) ifTrue: [ self persistAddressesOf: anObject ].! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
select: aCondition ofType: aType

	self delay.
	^(self objectsOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 5/22/2022 19:29:06'!
selectAllOfType: aType

	self delay.
	^(self objectsOfType: aType) copy ! !


!DataBaseSession methodsFor: 'testing' stamp: 'eaam 11/19/2023 14:04:33'!
isEmpty
	^tables isEmpty.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
