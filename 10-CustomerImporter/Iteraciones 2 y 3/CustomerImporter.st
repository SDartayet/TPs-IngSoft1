!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 12:18:12'!
doesAddress: anAddressToCompare haveAttributes: aListOfAddressAttributes 

	self assert: anAddressToCompare province equals: aListOfAddressAttributes first.
	self assert: anAddressToCompare streetNumber equals: aListOfAddressAttributes second.
	self assert: anAddressToCompare streetName equals: aListOfAddressAttributes third .
	self assert: anAddressToCompare zipCode equals: aListOfAddressAttributes fourth .
	self assert: anAddressToCompare town equals: aListOfAddressAttributes fifth.! !

!ImportTest methodsFor: 'tests' stamp: 'S D 11/16/2023 04:38:34'!
doesCustomer: aCustomerToCompare haveAttributes: aListOfCustomerAttributes 

	self assert: aCustomerToCompare firstName equals: aListOfCustomerAttributes first.		
	self assert: aCustomerToCompare lastName equals: aListOfCustomerAttributes second.	
	self assert: aCustomerToCompare identificationType equals: aListOfCustomerAttributes third.	
	self assert: aCustomerToCompare identificationNumber equals: aListOfCustomerAttributes fourth! !

!ImportTest methodsFor: 'tests' stamp: 'S D 11/16/2023 04:34:37'!
getAllCustomersWithIDType: theIDTypeOfTheCustomers andIDNumber: theIDNumberOfTheCustomers 

	^ session 
		select: [:aCustomer | aCustomer identificationType = theIDTypeOfTheCustomers and:[ aCustomer identificationNumber = theIDNumberOfTheCustomers]] 
		ofType: Customer! !

!ImportTest methodsFor: 'tests' stamp: 'S D 11/14/2023 01:46:31'!
importCustomersForReadStream: aReadStreamToRead forSession: aSessionToRecordDataOn
	(CustomerImporter forDatabaseSessionToRecordOn: aSessionToRecordDataOn andInputStreamWithCustomerData: aReadStreamToRead) importCustomers! !

!ImportTest methodsFor: 'tests' stamp: 'S D 11/16/2023 04:34:37'!
obtainCustomerWithIDType: theTypeOfID andIDNumber: theIDNumberOfTheCustomer 

	^( self getAllCustomersWithIDType: theTypeOfID andIDNumber: theIDNumberOfTheCustomer) anyOne! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 18:09:56'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
	inputStream :=  ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 17:56:51'!
tearDown

	session commit.
	session close.
		
	inputStream close.! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 19:19:47'!
test01ImportAddsTheCorrectNumberOfCustomers

	| numberOfCostumers listOfSanchez listOfPerez|

	self importCustomersForReadStream: inputStream forSession: session .
	
	numberOfCostumers := (session selectAllOfType: Customer) size.
	
	listOfSanchez := self getAllCustomersWithIDType: 'D' andIDNumber: '22333444'.
		
	listOfPerez := self getAllCustomersWithIDType: 'C' andIDNumber: '23-25666777-9'.
	
	self assert: numberOfCostumers equals: 2.
	self assert: listOfSanchez size equals: 1. self assert: listOfPerez size equals: 1.
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 17:58:45'!
test02PepeSanchezIsImportedCorrectly

	| customer expectedAttributes |	
	expectedAttributes :=  OrderedCollection 
		with: 'Pepe'
		with: 'Sanchez'
		with: 'D'
		with: '22333444'.
	
	self importCustomersForReadStream: inputStream forSession: session .
	customer := self obtainCustomerWithIDType: 'D' andIDNumber: '22333444'.
	self doesCustomer: customer haveAttributes: expectedAttributes .	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 17:58:58'!
test03JuanPerezIsImportedCorrectly

	| customer expectedAttributes |	
	expectedAttributes := OrderedCollection 
		with: 'Juan'
		with: 'Perez'
		with: 'C'
		with: '23-25666777-9'.
	
	self importCustomersForReadStream: inputStream forSession: session .
	customer := self obtainCustomerWithIDType: 'C' andIDNumber: '23-25666777-9'.

	self doesCustomer: customer haveAttributes: expectedAttributes .! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 18:37:08'!
test04PepeSanchezDataIsImportedCorrectly

	| customer firstAddressesOfCustomer firstAddressExpectedAttributes secondAddressExpectedAttributes secondAddressesOfCustomer |
	
	firstAddressExpectedAttributes := OrderedCollection
		with: 'BsAs'
		with: 3322
		with: 'San Martin'
		with: 1636
		with: 'Olivos'.
	
	secondAddressExpectedAttributes := OrderedCollection 
		with: 'Buenos Aires'
		with: 888
		with: 'Maipu'
		with: 1122
		with: 'Florida'.
	self importCustomersForReadStream: inputStream forSession: session .
	customer := self obtainCustomerWithIDType: 'D' andIDNumber: '22333444'.
	firstAddressesOfCustomer := customer addressAt: 'San Martin' ifNone: [self fail.].	secondAddressesOfCustomer := customer addressAt: 'Maipu' ifNone: [self fail.].

	self doesAddress: firstAddressesOfCustomer haveAttributes: firstAddressExpectedAttributes .
	self doesAddress: secondAddressesOfCustomer haveAttributes: secondAddressExpectedAttributes .! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 18:35:07'!
test05JuanPerezDataIsImportedCorrectly

	| customer listOfCustomerAddresses expectedAddressAttributes |
		expectedAddressAttributes := OrderedCollection 
		with: 'CABA'
		with: 1122
		with:'Alem'
		with: 1001
		with: 'CABA'.
	
	self importCustomersForReadStream: inputStream forSession: session .
	customer := self obtainCustomerWithIDType: 'C' andIDNumber: '23-25666777-9'.
	listOfCustomerAddresses := customer addressAt: 'Alem' ifNone: [self fail.].
	
	self doesAddress: listOfCustomerAddresses haveAttributes: expectedAddressAttributes .
! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 19:39:47'!
test06FailImportingWhenCustomerRecordHasLessThanFiveParameters

	| importer|
	importer := CustomerImporter forDatabaseSessionToRecordOn: session andInputStreamWithCustomerData: (ReadStream on: 'C,Hernan,0,smallTalk').
	
	self should: [importer importCustomers]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: anError messageText equals: importer invalidCustomerRecord.
		"self assert: (self sNotImportedCustomerWithName: 'Hernan')."
		]
	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 19:34:41'!
test07FailImportingWhenCustomerRecordHasMoreThanFiveParameters

	| importer|
	importer := CustomerImporter forDatabaseSessionToRecordOn: session andInputStreamWithCustomerData: (ReadStream on: 'C,Hernan,0,smallTalk,cuis,TDD').
	
	self should: [importer importCustomers]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: anError messageText equals: importer invalidCustomerRecord.
		self assert: '' equals: ''.
		]
	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 20:19:28'!
test08FailImportingWhenAddressRecordHasLessThanFiveParameters

	| importer|
	importer := CustomerImporter forDatabaseSessionToRecordOn: session andInputStreamWithCustomerData: (ReadStream on: 'C,Hernan,0,smallTalk,cuis
A,Henderson,712,Red Bark Ln,1122').
	
	self should: [importer importCustomers]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: anError messageText equals: importer invalidAddressRecord .
		"self assert: (self sNotImportedCustomerWithName: 'Hernan')."
		]
	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 20:19:41'!
test09FailImportingWhenAddressRecordHasMoreThanFiveParameters

	| importer|
	importer := CustomerImporter forDatabaseSessionToRecordOn: session andInputStreamWithCustomerData: (ReadStream on: 'C,Hernan,0,smallTalk,cuis
A,Henderson,712,Red Bark Ln,1122,Nevada,Tompson').
	
	self should: [importer importCustomers]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: anError messageText equals: importer invalidAddressRecord.
		"self assert: (self sNotImportedCustomerWithName: 'Hernan')."
		]
	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 20:21:11'!
test10FailImportingWhenRecordHasAnInvalidType

	| importer|
	importer := CustomerImporter forDatabaseSessionToRecordOn: session andInputStreamWithCustomerData: (ReadStream on: 'HelloWorld,Hernan,0,smallTalk,cuis').
	
	self should: [importer importCustomers]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: anError messageText equals: importer invalidRecord.
		"self assert: (self sNotImportedCustomerWithName: 'Hernan')."
		]
	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 20:52:22'!
test11FailImportingWhenRecordHasEmptyLine

	| importer|
	importer := CustomerImporter forDatabaseSessionToRecordOn: session andInputStreamWithCustomerData: (ReadStream on: '
HelloWorld,Hernan,0,smallTalk,cuis').
	
	self should: [importer importCustomers]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: anError messageText equals: importer invalidRecord.
		"self assert: (self sNotImportedCustomerWithName: 'Hernan')."
		]
	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 20:51:58'!
test12FailImportingWhenAddressHasNoAssociatedCustomer

	| importer|
	importer := CustomerImporter forDatabaseSessionToRecordOn: session andInputStreamWithCustomerData: (ReadStream on:  'A,Henderson,71a2,Red Bark Ln,1122, Louisiana').
	
	self should: [importer importCustomers]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: anError messageText equals: importer invalidAddressRecord.
		"self assert: (self sNotImportedCustomerWithName: 'Hernan')."
		]
	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 20:54:51'!
test13FailImportingWhenAddressRecordTypeIsNotA

	| importer|
	importer := CustomerImporter forDatabaseSessionToRecordOn: session andInputStreamWithCustomerData: (ReadStream on: 'C,Hernan,0,smallTalk,cuis
Alpaca,Henderson,712,Red Bark Ln,1122,Nevada').
	
	self should: [importer importCustomers]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: anError messageText equals: importer invalidRecord.
		"self assert: (self sNotImportedCustomerWithName: 'Hernan')."
		]
	! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/16/2023 20:58:29'!
test14FailImportingWhenCustomerRecordTypeIsNotC

	| importer|
	importer := CustomerImporter forDatabaseSessionToRecordOn: session andInputStreamWithCustomerData: (ReadStream on: 'Cobayo,Hernan,0,smallTalk,cuis
A,Henderson,712,Red Bark Ln,1122,Nevada').
	
	self should: [importer importCustomers]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: anError messageText equals: importer invalidRecord.
		"self assert: (self sNotImportedCustomerWithName: 'Hernan')."
		]
	! !


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


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
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


!Customer methodsFor: 'initialization' stamp: 'HAW 5/22/2022 00:19:29'!
initialize

	super initialize.
	addresses := OrderedCollection new.! !


!Customer methodsFor: 'testing' stamp: 'eaam 11/16/2023 18:34:13'!
addressAt: aStreetToSearchFor ifNone: aBlockIfNone 
	^addresses detect: [:anAddress | anAddress isInStreet: aStreetToSearchFor ] ifNone: aBlockIfNone.! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session inputStream line newCustomer newAddress record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'S D 11/14/2023 01:45:22'!
initializeForDatabaseSessionToRecordOn: aSession andInputStreamWithCustomerData: anInputStream
	session := aSession.
	inputStream := anInputStream.! !


!CustomerImporter methodsFor: 'error handling' stamp: 'eaam 11/16/2023 19:50:09'!
invalidAddressRecord
	^'an address must have 6 parameters'.! !

!CustomerImporter methodsFor: 'error handling' stamp: 'eaam 11/16/2023 18:56:35'!
invalidCustomerRecord
	^'invalid customer record'! !

!CustomerImporter methodsFor: 'error handling' stamp: 'eaam 11/16/2023 20:21:46'!
invalidRecord
	^'invalid record'! !


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

!CustomerImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/16/2023 20:51:26'!
importAddress

	((record size = 6 )not or: (newCustomer isNil)) ifTrue: [self error: self invalidAddressRecord].


	newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: record second.
			newAddress streetNumber: record third asNumber .
			newAddress town: record fourth.
			newAddress zipCode: record fifth asNumber .
			newAddress province: record sixth! !

!CustomerImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/16/2023 20:50:16'!
importCustomer

	((record size = 5 )not) ifTrue: [self error: self invalidCustomerRecord].
		

	newCustomer := Customer new.
			newCustomer firstName: record second.
			newCustomer lastName: record third.
			newCustomer identificationType: record fourth.
			newCustomer identificationNumber: record fifth.
			session persist: newCustomer! !

!CustomerImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/16/2023 21:01:01'!
importRecord

	(record isEmpty) ifTrue: [ self error: self invalidRecord ].
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

!CustomerImporter methodsFor: 'input validation' stamp: 'eaam 11/16/2023 20:30:54'!
recordHasValidType
	^self isCustomerRecord or: self isAddressRecord ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerImporter class' category: 'CustomerImporter'!
CustomerImporter class
	instanceVariableNames: ''!

!CustomerImporter class methodsFor: 'instance creation' stamp: 'S D 11/14/2023 01:45:47'!
forDatabaseSessionToRecordOn: aSessionToRecordDataOn andInputStreamWithCustomerData: anInputStreamToReadFrom 
	^self new initializeForDatabaseSessionToRecordOn: aSessionToRecordDataOn andInputStreamWithCustomerData: anInputStreamToReadFrom ! !


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

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
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


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 5/22/2022 00:19:29'!
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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: 'CustomerImporter'!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
