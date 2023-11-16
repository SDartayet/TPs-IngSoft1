!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/13/2023 21:52:29'!
createCustomerForLine: line

	| customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth! !

!ImportTest methodsFor: 'tests' stamp: 'S D 11/16/2023 04:41:56'!
doesAddress: anAddressToCompare haveAttributes: aListOfAddressAttributes 

	self assert: anAddressToCompare size equals: 2.
	self assert: anAddressToCompare first province equals: 'BsAs'.
	self assert: anAddressToCompare first streetNumber equals: 3322.
	self assert: anAddressToCompare first streetName equals: 'San Martin'.
	self assert: anAddressToCompare first zipCode equals: 1636.
	self assert: anAddressToCompare first town equals: 'Olivos'! !

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

!ImportTest methodsFor: 'tests' stamp: 'S D 11/14/2023 01:39:32'!
setUp

	session := DataBaseSession for: (Array with: Address with: Customer).
	session beginTransaction.
	inputStream :=  UniFileStream new open: 'input.txt' forWrite: false.! !

!ImportTest methodsFor: 'tests' stamp: 'eaam 11/13/2023 20:33:22'!
tearDown

	session commit.
	session close! !

!ImportTest methodsFor: 'tests' stamp: 'S D 11/16/2023 04:34:37'!
test01ImportAddsTheCorrectNumberOfCustomers

	| numberOfCostumers listOfSanchez listOfPerez|
	
	
	
	self importCustomersForReadStream: inputStream forSession: session .
	
	numberOfCostumers := (session selectAllOfType: Customer) size.
	
	listOfSanchez := self getAllCustomersWithIDType: 'D' andIDNumber: '22333444'.
		
	listOfPerez := self getAllCustomersWithIDType: 'C' andIDNumber: '23-25666777-9'.
	
	
	self assert: numberOfCostumers equals: 2.
	self assert: listOfSanchez size equals: 1. self assert: listOfPerez size equals: 1.
	
	! !

!ImportTest methodsFor: 'tests' stamp: 'S D 11/16/2023 04:39:33'!
test02PepeSanchezIsImportedCorrectly

	| thePibardo expectedAttributes |	
	expectedAttributes := OrderedCollection 
		with: 'Pepe'
		with: 'Sanchez'
		with: 'D'
		with: '22333444'.
	
	self importCustomersForReadStream: inputStream forSession: session .
	thePibardo := self obtainCustomerWithIDType: 'D' andIDNumber: '22333444'.

	self doesCustomer: thePibardo haveAttributes: expectedAttributes .	! !

!ImportTest methodsFor: 'tests' stamp: 'S D 11/16/2023 04:40:50'!
test03JuanPerezIsImportedCorrectly

	| thePibardo expectedAttributes |	
	expectedAttributes := OrderedCollection 
		with: 'Juan'
		with: 'Perez'
		with: 'C'
		with: '23-25666777-9'.
	
	self importCustomersForReadStream: inputStream forSession: session .
	thePibardo := self obtainCustomerWithIDType: 'C' andIDNumber: '23-25666777-9'.

	self doesCustomer: thePibardo haveAttributes: expectedAttributes .! !

!ImportTest methodsFor: 'tests' stamp: 'S D 11/16/2023 04:44:59'!
test04PepeSanchezDataIsImportedCorrectly

	| thePibardo listOfPibardoAddresses firstAddressExpectedAttributes secondAddressExpectedAttributes|
	
	firstAddressExpectedAttributes := OrderedCollection
		with: 2
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
	thePibardo := self obtainCustomerWithIDType: 'D' andIDNumber: '22333444'.
	listOfPibardoAddresses := (thePibardo) addresses.
	self doesAddress: listOfPibardoAddresses first haveAttributes: firstAddressExpectedAttributes .
	self doesAddress: listOfPibardoAddresses second haveAttributes: secondAddressExpectedAttributes .! !

!ImportTest methodsFor: 'tests' stamp: 'S D 11/16/2023 04:46:28'!
test05JuanPerezDataIsImportedCorrectly

	| thePibardo listOfPibardoAddresses expectedAddressAttributes |
		expectedAddressAttributes := OrderedCollection 
		with: 1
		with: 'CABA'
		with: 1122
		with:'Alem'
		with: 1001
		with: 'CABA'.
	
	self importCustomersForReadStream: inputStream forSession: session .
	thePibardo := self obtainCustomerWithIDType: 'C' andIDNumber: '23-25666777-9'.
	listOfPibardoAddresses := thePibardo addresses.
	
	self doesAddress: listOfPibardoAddresses first haveAttributes: expectedAddressAttributes .
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


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
Object subclass: #CustomerImporter
	instanceVariableNames: 'session inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'initialization' stamp: 'S D 11/14/2023 01:45:22'!
initializeForDatabaseSessionToRecordOn: aSession andInputStreamWithCustomerData: anInputStream
	session := aSession.
	inputStream := anInputStream.! !


!CustomerImporter methodsFor: 'evaluating' stamp: 'S D 11/14/2023 01:43:33'!
importCustomers 
	
	|newCustomer  line |

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		(line beginsWith: 'C') ifTrue: [ | customerData |
			customerData := line findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer ].

		(line beginsWith: 'A') ifTrue: [ | addressData newAddress |
			addressData := line findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth.].
			line := inputStream nextLine. ].

	inputStream close.
	! !

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
