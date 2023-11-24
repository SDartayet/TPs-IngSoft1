!classDefinition: #Enviroment category: 'CustomerImporter'!
TestCase subclass: #Enviroment
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Enviroment methodsFor: 'customer system creation' stamp: 'eaam 11/19/2023 19:57:19'!
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

!Development methodsFor: 'customer system creation' stamp: 'eaam 11/23/2023 18:16:17'!
createSystem
	^TransientErpSystem new.! !

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

!Integration methodsFor: 'customer system creation' stamp: 'eaam 11/23/2023 18:16:08'!
createSystem
	^PersistentErpSystem new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Integration class' category: 'CustomerImporter'!
Integration class
	instanceVariableNames: ''!

!Integration class methodsFor: 'as yet unclassified' stamp: 'S D 11/23/2023 02:16:48'!
isCurrent
	^(Smalltalk at: #env) = 'int'! !


!classDefinition: #ImportTest category: 'CustomerImporter'!
TestCase subclass: #ImportTest
	instanceVariableNames: 'system validInputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 23:54:53'!
assertCustomerImporterImportsRightAmountOfCustomers
	
	| numberOfCostumers |
	numberOfCostumers := (system selectAllOfType: Customer) size.	
	self assert: numberOfCostumers equals: 2! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 23:56:12'!
assertCustomerImporterOnlyImportsOneOfEachCustomer
	| listOfSanchez listOfPerez|
	listOfSanchez := system getAllCustomersWithIDType: 'D' andIDNumber: '22333444'.
		
	listOfPerez := system getAllCustomersWithIDType: 'C' andIDNumber: '23-25666777-9'.
	
	self assert: listOfSanchez size equals: 1. self assert: listOfPerez size equals: 1! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 18:19:50'!
forImporter: aImporter shouldImportCustomersRaiseAnErrorErrorMessage: aErrorMessage withCondition: aClossure   

	^ self should: [aImporter import]
	raise: Error - MessageNotUnderstood 
	withExceptionDo:[:anError |
		self assert: anError messageText equals: aErrorMessage.
		aClossure value.
		]! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 18:19:50'!
importCustomersForReadStream: aReadStreamToRead forSystem: aSessionToRecordDataOn
	(CustomerImporter forSystemToRecordOn: aSessionToRecordDataOn andInputStream: aReadStreamToRead) import! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 18:27:01'!
test01ImportAddsTheCorrectNumberOfCustomers

	self importCustomersForReadStream: validInputStream forSystem: system .
	
	self assertCustomerImporterImportsRightAmountOfCustomers.
	
	self assertCustomerImporterOnlyImportsOneOfEachCustomer.
	! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 21:29:06'!
test02PepeSanchezIsImportedCorrectly

	| customer |	
	self importCustomersForReadStream: validInputStream forSystem: system .
	customer := system getCustomerWithIDType: 'D' andIDNumber: '22333444'.
	self assert: (customer hasFirstName: 'Pepe' andLastName: 'Sanchez' andIDType: 'D' andIDNumber:'22333444' ).! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 21:29:25'!
test03JuanPerezIsImportedCorrectly

	| customer |
	
	self importCustomersForReadStream: validInputStream forSystem: system .
	customer := system getCustomerWithIDType: 'C' andIDNumber: '23-25666777-9'.

	self assert: (customer hasFirstName: 'Juan' andLastName: 'Perez' andIDType: 'C' andIDNumber: '23-25666777-9').! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 21:29:46'!
test04PepeSanchezDataIsImportedCorrectly

	| customer |

	self importCustomersForReadStream: validInputStream forSystem: system .
	customer := system getCustomerWithIDType: 'D' andIDNumber: '22333444'.
	
	self assert: (customer hasAddressWithProvince: 'BsAs' andStreetName: 'San Martin' andStreetNumber: 3322 andZipCode: 1636 andTown: 'Olivos').
	
	self assert: (customer hasAddressWithProvince: 'Buenos Aires' andStreetName: 'Maipu' andStreetNumber: 		888 andZipCode: 1122 andTown: 'Florida') .
! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 21:29:56'!
test05JuanPerezDataIsImportedCorrectly

	| customer |
	self importCustomersForReadStream: validInputStream forSystem: system .
	customer := system getCustomerWithIDType: 'C' andIDNumber: '23-25666777-9'.	
	self assert: (customer hasAddressWithProvince: 'CABA'  andStreetName: 'Alem' andStreetNumber: 1122 andZipCode: 1001 andTown: 'CABA')! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 21:12:39'!
test06FailImportingWhenCustomerRecordHasLessThanFiveParameters

	| importer|
	importer := CustomerImporter forSystemToRecordOn: system andInputStream: (ReadStream on: 'C,Hernan,0,smallTalk').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class invalidCustomerRecordErrorMessage 
	withCondition: [self assert: self customerSystemDataIsEmpty]! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 21:12:53'!
test07FailImportingWhenCustomerRecordHasMoreThanFiveParameters

	| importer|
	importer := CustomerImporter forSystemToRecordOn: system andInputStream: (ReadStream on: 'C,Hernan,0,smallTalk,cuis,TDD').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class invalidCustomerRecordErrorMessage 
	withCondition: [self assert: self customerSystemDataIsEmpty]! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 21:30:16'!
test08FailImportingWhenAddressRecordHasLessThanFiveParameters

	| importer|
	importer := CustomerImporter forSystemToRecordOn: system andInputStream: (ReadStream on: 'C,Hernan,0,smallTalk,cuis
A,Henderson,712,Red Bark Ln,1122').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class invalidAddressRecordErrorMessage 
	withCondition: [| customer |
		customer := system getCustomerWithIDType: 'smallTalk' andIDNumber: 'cuis'.
		self assert: customer numberOfAddresses equals: 0.]
	! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 21:30:31'!
test09FailImportingWhenAddressRecordHasMoreThanFiveParameters

	| importer|
	importer := CustomerImporter forSystemToRecordOn: system andInputStream: (ReadStream on: 'C,Hernan,0,smallTalk,cuis
A,Henderson,712,Red Bark Ln,1122,Nevada,Tompson').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class invalidAddressRecordErrorMessage 
	withCondition: [| customer |
		customer := system getCustomerWithIDType: 'smallTalk' andIDNumber: 'cuis'.
		self assert: customer numberOfAddresses equals: 0.]
	! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 21:17:21'!
test10FailImportingWhenRecordHasAnInvalidType

	| importer|
	importer := CustomerImporter forSystemToRecordOn: system andInputStream: (ReadStream on: 'HelloWorld,Hernan,0,smallTalk,cuis').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class invalidRecord 
	withCondition: [self assert: self customerSystemDataIsEmpty]
	! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 21:17:24'!
test11FailImportingWhenRecordHasEmptyLine

	| importer|
	importer := CustomerImporter forSystemToRecordOn: system andInputStream: (ReadStream on: '
HelloWorld,Hernan,0,smallTalk,cuis').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class invalidRecord
	withCondition: [self assert: self customerSystemDataIsEmpty] .
	! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 21:16:29'!
test12FailImportingWhenAddressHasNoAssociatedCustomer

	| importer|
	importer := CustomerImporter forSystemToRecordOn: system andInputStream: (ReadStream on:  'A,Henderson,71a2,Red Bark Ln,1122, Louisiana').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class addressMustHaveOwnerErrorMessage 
	withCondition: [self assert: self customerSystemDataIsEmpty] .
	! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 21:30:47'!
test13FailImportingWhenAddressRecordTypeIsNotA

	| importer|
	importer := CustomerImporter forSystemToRecordOn: system andInputStream: (ReadStream on: 'C,Hernan,0,smallTalk,cuis
Alpaca,Henderson,712,Red Bark Ln,1122,Nevada').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class invalidRecord
	withCondition: [| customer |
		customer := system getCustomerWithIDType: 'smallTalk' andIDNumber: 'cuis'.
		self assert: customer numberOfAddresses equals: 0.]
		! !

!ImportTest methodsFor: 'customer tests' stamp: 'eaam 11/23/2023 21:17:47'!
test14FailImportingWhenCustomerRecordTypeIsNotC

	| importer|
	importer := CustomerImporter forSystemToRecordOn: system andInputStream: (ReadStream on: 'Cobayo,Hernan,0,smallTalk,cuis
A,Henderson,712,Red Bark Ln,1122,Nevada').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class invalidRecord
	withCondition: [self assert: self customerSystemDataIsEmpty] .! !


!ImportTest methodsFor: 'tear down' stamp: 'eaam 11/23/2023 18:27:01'!
tearDown
	system close.
		
	validInputStream close.! !


!ImportTest methodsFor: 'set up' stamp: 'eaam 11/23/2023 18:27:01'!
setUp

	system := ErpSystem newCustomerSystem .
	system start.
	validInputStream :=  ReadStream on: 'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'.! !


!ImportTest methodsFor: 'private' stamp: 'eaam 11/23/2023 18:27:01'!
customerSystemDataIsEmpty
	^system isEmpty.! !


!ImportTest methodsFor: 'supplier tests' stamp: 'eaam 11/23/2023 21:05:15'!
test01SupplierIsImportedCorrectly
	| stream suplier |
	
	stream := ReadStream on: 'S,Supplier1,D,123'.
	(SupplierImporter forSystemToRecordOn: system andInputStream: stream) import.
	
	self assert: system numberOfSuppliers equals: 1.
	
	suplier := system getSupplierWithName: 'Supplier1' andIdNumber: '123'.
	
	self assert: (suplier hasName: 'Supplier1' andIDType: 'D' andIdNumber: '123').
	self assert: (suplier idTypeIs: 'D').! !

!ImportTest methodsFor: 'supplier tests' stamp: 'eaam 11/23/2023 19:33:34'!
test02SupplierAddressesIsImportedCorrectly
	| stream supplier |
	
	stream := ReadStream on: 'S,Supplier1,D,123
A,San Martin,3322,Olivos,1636,BsAs'.
	(SupplierImporter forSystemToRecordOn: system andInputStream: stream) import.
	
	supplier := system getSupplierWithName: 'Supplier1' andIdNumber: '123'.
	
	self assert: (supplier numberOfAddresses ) equals: 1.
	self assert: (supplier hasAddressWithProvince: 'BsAs' andStreetName: 'San Martin' andStreetNumber:  3322 andZipCode: 1636 andTown: 'Olivos').! !

!ImportTest methodsFor: 'supplier tests' stamp: 'eaam 11/23/2023 19:33:51'!
test03MultipleSupplierAddressesAreImportedCorrectly
	| stream supplier |
	
	stream := ReadStream on: 'S,Supplier1,D,123
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires'.
	(SupplierImporter forSystemToRecordOn: system andInputStream: stream) import.
	
	supplier := system getSupplierWithName: 'Supplier1' andIdNumber: '123'.
	
	self assert: (supplier numberOfAddresses ) equals: 2.
	self assert: (supplier hasAddressWithProvince: 'BsAs' andStreetName: 'San Martin' andStreetNumber:  3322 andZipCode: 1636 andTown: 'Olivos').
	self assert: (supplier hasAddressWithProvince: 'Buenos Aires' andStreetName: 'Maipu' andStreetNumber:  888 andZipCode: 1122 andTown: 'Florida').! !

!ImportTest methodsFor: 'supplier tests' stamp: 'eaam 11/23/2023 20:07:31'!
test04SupplierCanImportExistingCustomerCorrectly
	| supplierStream customerStream supplier |
	
	supplierStream := ReadStream on: 'S,Supplier1,D,123
EC,D,5456774'.
	customerStream := ReadStream on: 'C,Juan,Perez,D,5456774'.
	(CustomerImporter forSystemToRecordOn: system andInputStream: customerStream ) import.
	(SupplierImporter forSystemToRecordOn: system andInputStream: supplierStream) import.
	
	supplier := system getSupplierWithName: 'Supplier1' andIdNumber: '123'.
	
	self assert: (supplier numberOfCustomers ) equals: 1.
	self assert: (supplier hasCustomerWithIDType: 'D' andIDNumber: '5456774' andFirstName: 'Juan' andLastName: 'Perez').
! !

!ImportTest methodsFor: 'supplier tests' stamp: 'eaam 11/23/2023 20:38:43'!
test05SupplierCanImportNewCustomerCorrectly
	| supplierStream supplier |
	
	supplierStream := ReadStream on: 'S,Supplier1,D,123
NC,Pepe,Sanchez,D,22333444'.
	(SupplierImporter forSystemToRecordOn: system andInputStream: supplierStream) import.
	
	supplier := system getSupplierWithName: 'Supplier1' andIdNumber: '123'.
	
	self assert: (supplier numberOfCustomers ) equals: 1.
	self assert: (supplier hasCustomerWithIDType: 'D' andIDNumber: '22333444' andFirstName: 'Pepe' andLastName: 'Sanchez').
! !

!ImportTest methodsFor: 'supplier tests' stamp: 'eaam 11/23/2023 20:40:20'!
test06FailImportingWhenSupplierRecordHasLessThanFourParameters

	| importer|
	importer := SupplierImporter forSystemToRecordOn: system andInputStream: (ReadStream on: 'S,Hernan,D').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer invalidSupplierRecord 
	withCondition: [self assert: self customerSystemDataIsEmpty]! !

!ImportTest methodsFor: 'supplier tests' stamp: 'eaam 11/23/2023 20:41:55'!
test07FailImportingWhenSupplierRecordHasMoreThanFourParameters

	| importer|
	importer := SupplierImporter forSystemToRecordOn: system andInputStream: (ReadStream on: 'S,Hernan,D,123, smalltalk').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer invalidSupplierRecord 
	withCondition: [self assert: self customerSystemDataIsEmpty]! !

!ImportTest methodsFor: 'supplier tests' stamp: 'eaam 11/23/2023 21:17:17'!
test08FailImportingWhenRecordHasAnInvalidType

	| importer|
	importer := SupplierImporter forSystemToRecordOn: system andInputStream: (ReadStream on: 'HelloWorld,Hernan,0,smallTalk').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class invalidRecord 
	withCondition: [self assert: self customerSystemDataIsEmpty]! !

!ImportTest methodsFor: 'supplier tests' stamp: 'eaam 11/23/2023 21:16:08'!
test09FailImportingWhenAddressHasNoAssociatedSupplier

	| importer|
	importer := SupplierImporter forSystemToRecordOn: system andInputStream: (ReadStream on:  'A,Henderson,71a2,Red Bark Ln,1122, Louisiana').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class addressMustHaveOwnerErrorMessage 
	withCondition: [self assert: self customerSystemDataIsEmpty] .
	! !

!ImportTest methodsFor: 'supplier tests' stamp: 'eaam 11/23/2023 21:16:16'!
test10FailImportingWhenExistingCustomerHasNoAssociatedSupplier

	| importer|
	importer := SupplierImporter forSystemToRecordOn: system andInputStream: (ReadStream on:  'EC,D,545677').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class customersMustHaveASupplierErrorMessage 
	withCondition: [self assert: self customerSystemDataIsEmpty] .
	! !

!ImportTest methodsFor: 'supplier tests' stamp: 'eaam 11/23/2023 21:16:25'!
test11FailImportingWhenNewCustomerHasNoAssociatedSupplier

	| importer|
	importer := SupplierImporter forSystemToRecordOn: system andInputStream: (ReadStream on:  'NC,Pepe,Sanchez,D,22333444').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class customersMustHaveASupplierErrorMessage 
	withCondition: [self assert: self customerSystemDataIsEmpty] .
	
	! !

!ImportTest methodsFor: 'supplier tests' stamp: 'eaam 11/23/2023 21:17:34'!
test12FailImportingWhenSupplierRecordTypeIsNotS

	| importer|
	importer := SupplierImporter forSystemToRecordOn: system andInputStream: (ReadStream on: 'Smalltalk,Hernan,0,smallTalk,cuis
A,Henderson,712,Red Bark Ln,1122,Nevada').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class invalidRecord
	withCondition: [self assert: self customerSystemDataIsEmpty] .
	! !

!ImportTest methodsFor: 'supplier tests' stamp: 'eaam 11/23/2023 21:17:43'!
test13FailImportingWhenExistingCustomerRecordTypeIsNotEC

	| importer|
	importer := SupplierImporter forSystemToRecordOn: system andInputStream: (ReadStream on: 'S,Supplier1,D,123
ECosistema,Hernan,0,smallTalk,cuis').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class invalidRecord
	withCondition: [ | supplier |
		supplier := system getSupplierWithName: 'Supplier1' andIdNumber: '123'. 
		self assert: supplier numberOfCustomers equals: 0.
		] .
	! !

!ImportTest methodsFor: 'supplier tests' stamp: 'eaam 11/23/2023 21:17:50'!
test14FailImportingWhenNewCustomerRecordTypeIsNotNC

	| importer|
	importer := SupplierImporter forSystemToRecordOn: system andInputStream: (ReadStream on: 'S,Supplier1,D,123
NCR,Hernan,0,smallTalk,cuis').
	
	self forImporter: importer 
	shouldImportCustomersRaiseAnErrorErrorMessage: importer class invalidRecord
	withCondition: [ | supplier |
		supplier := system getSupplierWithName: 'Supplier1' andIdNumber: '123'. 
		self deny: (system hasCustomerWithIDType: 'smallTalk' andIDNumber: 'cuis').
		self assert: supplier numberOfCustomers equals: 0.
		] .
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


!Address methodsFor: 'as yet unclassified' stamp: 'eaam 11/23/2023 19:15:08'!
hasProvince: aProvinceToCheck streetNumber: aStreetNumberToCheck streetName: aStreetNameToCheck  zipCode:  aZipCodeToCheck town: aTownToCheck
	^(aProvinceToCheck = province) 
	and: (aStreetNumberToCheck = streetNumber) 
	and: (aStreetNameToCheck = streetName)
	and: (aZipCodeToCheck = zipCode)
	and: (aTownToCheck = town)! !


!classDefinition: #CSVImporter category: 'CustomerImporter'!
Object subclass: #CSVImporter
	instanceVariableNames: 'system inputStream line record'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CSVImporter methodsFor: 'initialization' stamp: 'eaam 11/23/2023 18:36:54'!
initializeForCustomerSystemToRecordOn: aCustomerSystemToRecordDataOn andInputStreamWithCustomerData: anInputStream

	system := aCustomerSystemToRecordDataOn.
	inputStream := anInputStream.! !


!CSVImporter methodsFor: 'error handling' stamp: 'eaam 11/23/2023 21:17:11'!
signalIfRecordIsEmpty

	^ (record isEmpty) ifTrue: [ self error: self class invalidRecord ]! !


!CSVImporter methodsFor: 'evaluating' stamp: 'eaam 11/23/2023 18:20:05'!
import 
	[self hasLineToImport ] whileTrue: [
		self createRecord.
		self importRecord.
		].
	! !


!CSVImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/23/2023 21:26:00'!
checkRecordTypeAndImportIt

	self subclassResponsibility! !

!CSVImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/23/2023 18:20:15'!
createRecord
	
	^ record := line findTokens: $,! !

!CSVImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/23/2023 21:26:10'!
importRecord
	self signalIfRecordIsEmpty.
	self checkRecordTypeAndImportIt! !


!CSVImporter methodsFor: 'input validation' stamp: 'eaam 11/23/2023 18:20:40'!
hasLineToImport

	line := inputStream nextLine. 
	^line notNil! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CSVImporter class' category: 'CustomerImporter'!
CSVImporter class
	instanceVariableNames: ''!

!CSVImporter class methodsFor: 'instance creation' stamp: 'eaam 11/23/2023 18:17:44'!
forSystemToRecordOn: aCustomerSystemToRecordDataOn andInputStream: anInputStreamToReadFrom 
	^self new initializeForCustomerSystemToRecordOn: aCustomerSystemToRecordDataOn andInputStreamWithCustomerData: anInputStreamToReadFrom ! !


!CSVImporter class methodsFor: 'error handling' stamp: 'eaam 11/23/2023 21:17:07'!
invalidRecord
	^'record cant be empty and every line must start with "C" or "A"'! !


!classDefinition: #PartyDataImporter category: 'CustomerImporter'!
CSVImporter subclass: #PartyDataImporter
	instanceVariableNames: 'newCustomer newAddress'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PartyDataImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/23/2023 21:24:56'!
checkRecordTypeAndImportIt

	self subclassResponsibility! !

!PartyDataImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/23/2023 20:31:48'!
createAddress

	self signalIfRecordHasNotSixParameters .
	self signalAddressHasNoOwner.

	newAddress := Address new.
			newAddress streetName: record second.
			newAddress streetNumber: record third asNumber .
			newAddress town: record fourth.
			newAddress zipCode: record fifth asNumber .
			newAddress province: record sixth! !

!PartyDataImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/23/2023 20:32:23'!
importAddress

	self subclassResponsibility! !

!PartyDataImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/23/2023 20:30:18'!
importCustomer

	self signalIfRecordHasNotFiveParameters .
		
	newCustomer := Customer new.
			newCustomer firstName: record second.
			newCustomer lastName: record third.
			newCustomer identificationType: record fourth.
			newCustomer identificationNumber: record fifth.
	system add: newCustomer! !


!PartyDataImporter methodsFor: 'error handling' stamp: 'eaam 11/23/2023 20:33:14'!
signalAddressHasNoOwner

	^self subclassResponsibility .! !

!PartyDataImporter methodsFor: 'error handling' stamp: 'eaam 11/23/2023 21:11:57'!
signalIfRecordHasNotFiveParameters

	((record size = 5 ) not) ifTrue: [self error: self class invalidCustomerRecordErrorMessage].! !

!PartyDataImporter methodsFor: 'error handling' stamp: 'eaam 11/23/2023 21:12:02'!
signalIfRecordHasNotSixParameters

	((record size = 6 ) not) ifTrue: [self error: self class invalidAddressRecordErrorMessage].! !


!PartyDataImporter methodsFor: 'input validation' stamp: 'eaam 11/23/2023 19:21:34'!
isAddressRecord

	^ record first = 'A'! !

!PartyDataImporter methodsFor: 'input validation' stamp: 'eaam 11/23/2023 19:21:46'!
recordHasValidType

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PartyDataImporter class' category: 'CustomerImporter'!
PartyDataImporter class
	instanceVariableNames: ''!

!PartyDataImporter class methodsFor: 'error messages' stamp: 'eaam 11/23/2023 21:11:42'!
invalidAddressRecordErrorMessage
	^'an address record must have 6 parameters'.! !

!PartyDataImporter class methodsFor: 'error messages' stamp: 'eaam 11/23/2023 21:11:37'!
invalidCustomerRecordErrorMessage
	^'an custoer record must have 5 parameters'! !


!PartyDataImporter class methodsFor: 'error handling' stamp: 'eaam 11/23/2023 21:14:05'!
addressMustHaveOwnerErrorMessage
	^'Addresses must have an owner'! !


!classDefinition: #CustomerImporter category: 'CustomerImporter'!
PartyDataImporter subclass: #CustomerImporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerImporter methodsFor: 'error handling' stamp: 'eaam 11/23/2023 21:14:22'!
signalAddressHasNoOwner
	(newCustomer isNil) ifTrue: [self error: self class addressMustHaveOwnerErrorMessage]! !


!CustomerImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/23/2023 21:24:05'!
checkRecordTypeAndImportIt
	(self isCustomerRecord) ifTrue: [ ^self importCustomer ].
	(self isAddressRecord) ifTrue: [ 		^self importAddress.].
	self error: super class invalidRecord! !

!CustomerImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/23/2023 20:31:06'!
importAddress

	self createAddress.
	
	newCustomer addAddress: newAddress.! !


!CustomerImporter methodsFor: 'input validation' stamp: 'eaam 11/16/2023 20:59:18'!
isCustomerRecord

	^ record first = 'C'! !

!CustomerImporter methodsFor: 'input validation' stamp: 'eaam 11/22/2023 18:54:58'!
recordHasValidType

	^self isCustomerRecord or: self isAddressRecord ! !


!classDefinition: #SupplierImporter category: 'CustomerImporter'!
PartyDataImporter subclass: #SupplierImporter
	instanceVariableNames: 'newSupplier'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!SupplierImporter methodsFor: 'error handling' stamp: 'eaam 11/23/2023 21:15:44'!
signalAddressHasNoOwner
	(newSupplier isNil) ifTrue: [self error: self class addressMustHaveOwnerErrorMessage]! !

!SupplierImporter methodsFor: 'error handling' stamp: 'eaam 11/23/2023 21:15:55'!
signalCustomerHasAnAssociatedSupplier
	(newSupplier isNil) ifTrue: [self error: self class customersMustHaveASupplierErrorMessage ]
	! !

!SupplierImporter methodsFor: 'error handling' stamp: 'eaam 11/23/2023 19:28:06'!
signalIfRecordHasNotFourParameters
	((record size = 4 ) not) ifTrue: [self error: self invalidSupplierRecord].! !


!SupplierImporter methodsFor: 'input validation' stamp: 'eaam 11/23/2023 20:41:00'!
invalidSupplierRecord
	^'Supplier record must have 4 parameters'! !

!SupplierImporter methodsFor: 'input validation' stamp: 'eaam 11/23/2023 19:36:11'!
isExistingCustomerRecord
	^ record first = 'EC'
! !

!SupplierImporter methodsFor: 'input validation' stamp: 'eaam 11/23/2023 20:09:17'!
isNewCustomerRecord
	^ record first = 'NC'
! !

!SupplierImporter methodsFor: 'input validation' stamp: 'eaam 11/23/2023 19:27:14'!
isSupplierRecord
	^ record first = 'S'! !


!SupplierImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/23/2023 21:24:39'!
checkRecordTypeAndImportIt
	(self isAddressRecord) ifTrue: [ 		^self importAddress.].
	(self isSupplierRecord) ifTrue: [ ^self importSupplier.].
	(self isExistingCustomerRecord) ifTrue: [ ^self importExistingCustomer ].
	(self isNewCustomerRecord) ifTrue: [ ^self importNewCustomer ].
	self error: super class invalidRecord.! !

!SupplierImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/23/2023 20:32:11'!
importAddress

	self createAddress.
			
	newSupplier addAddress: newAddress.! !

!SupplierImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/23/2023 20:47:53'!
importExistingCustomer

	| idType idNumber |
	
	self signalCustomerHasAnAssociatedSupplier.
	
	idType := record second.
	idNumber := record third.
	
	newCustomer := system getCustomerWithIDType: idType andIDNumber: idNumber.
	
	newSupplier addCustomer: newCustomer .! !

!SupplierImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/23/2023 20:49:21'!
importNewCustomer
	self signalCustomerHasAnAssociatedSupplier .
	self importCustomer .
	
	newSupplier addCustomer: newCustomer ! !

!SupplierImporter methodsFor: 'record creation auxiliaries' stamp: 'eaam 11/23/2023 20:41:26'!
importSupplier

	self signalIfRecordHasNotFourParameters .
		
	newSupplier := Supplier name: record second identificationType: record third identificationNumber: record fourth.
	system add: newSupplier! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SupplierImporter class' category: 'CustomerImporter'!
SupplierImporter class
	instanceVariableNames: ''!

!SupplierImporter class methodsFor: 'input validation' stamp: 'eaam 11/23/2023 21:15:33'!
customersMustHaveASupplierErrorMessage
	^'Customers must have associated supplier'! !


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


!classDefinition: #ErpSystem category: 'CustomerImporter'!
Object subclass: #ErpSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ErpSystem methodsFor: 'transaction management' stamp: 'eaam 11/19/2023 19:17:30'!
close

	self subclassResponsibility! !

!ErpSystem methodsFor: 'transaction management' stamp: 'eaam 11/19/2023 19:17:50'!
start

	self subclassResponsibility! !


!ErpSystem methodsFor: 'initialization' stamp: 'S D 11/23/2023 02:05:09'!
initialize

	self subclassResponsibility! !


!ErpSystem methodsFor: 'accessing' stamp: 'eaam 11/23/2023 19:55:25'!
getAllCustomersWithIDType: theIDTypeOfTheCustomers andIDNumber: theIDNumberOfTheCustomers 

	^ self select: [:aCustomer | (aCustomer hasIdentificationType: theIDTypeOfTheCustomers) and:[ aCustomer hasIdentificationNumber: theIDNumberOfTheCustomers]] 
		ofType: Customer.! !

!ErpSystem methodsFor: 'accessing' stamp: 'eaam 11/23/2023 19:55:42'!
getCustomerWithIDType: theTypeOfID andIDNumber: theIDNumberOfTheCustomer 

	^(self getAllCustomersWithIDType: theTypeOfID andIDNumber: theIDNumberOfTheCustomer) anyOne! !

!ErpSystem methodsFor: 'accessing' stamp: 'eaam 11/23/2023 21:05:15'!
getSupplierWithName: aName andIdNumber: aIdNumber 
	^(self select: [:aSupplier | aSupplier hasName: aName andIDType: 'D' andIdNumber: aIdNumber] ofType: Supplier) anyOne .! !

!ErpSystem methodsFor: 'accessing' stamp: 'eaam 11/23/2023 21:03:39'!
hasCustomerWithIDType: anIDTypeToCheck andIDNumber: anIDNumberToCheck
	^(self select: [ : aCustomer | aCustomer hasIDType: anIDTypeToCheck andIDNumber: anIDNumberToCheck] ofType: Customer) isEmpty not! !

!ErpSystem methodsFor: 'accessing' stamp: 'eaam 11/23/2023 19:55:52'!
numberOfSuppliers
	^(self selectAllOfType: Supplier ) size.! !


!ErpSystem methodsFor: 'private' stamp: 'eaam 11/23/2023 18:55:25'!
add: anObject

	self subclassResponsibility! !

!ErpSystem methodsFor: 'private' stamp: 'eaam 11/19/2023 19:17:38'!
isEmpty

	self subclassResponsibility! !

!ErpSystem methodsFor: 'private' stamp: 'eaam 11/19/2023 19:17:42'!
select: aCondition ofType: aType

	self subclassResponsibility! !

!ErpSystem methodsFor: 'private' stamp: 'eaam 11/19/2023 19:17:45'!
selectAllOfType: aType

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ErpSystem class' category: 'CustomerImporter'!
ErpSystem class
	instanceVariableNames: ''!

!ErpSystem class methodsFor: 'as yet unclassified' stamp: 'eaam 11/19/2023 20:03:09'!
newCustomerSystem
	^Enviroment current createSystem .! !


!classDefinition: #PersistentErpSystem category: 'CustomerImporter'!
ErpSystem subclass: #PersistentErpSystem
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentErpSystem methodsFor: 'initialization' stamp: 'eaam 11/23/2023 21:01:32'!
initialize
	 
	session := DataBaseSession for: (Array with: Address with: Customer with: Supplier).! !


!PersistentErpSystem methodsFor: 'private' stamp: 'eaam 11/23/2023 18:55:25'!
add: anObject 
	session persist: anObject.! !

!PersistentErpSystem methodsFor: 'private' stamp: 'eaam 11/19/2023 19:07:02'!
isEmpty
	^session isEmpty .! !

!PersistentErpSystem methodsFor: 'private' stamp: 'eaam 11/19/2023 19:02:33'!
select: aCondition ofType: aType
	^session select: aCondition ofType: aType.! !

!PersistentErpSystem methodsFor: 'private' stamp: 'eaam 11/19/2023 18:28:40'!
selectAllOfType: aType 
	^session selectAllOfType: aType.! !


!PersistentErpSystem methodsFor: 'transaction management' stamp: 'eaam 11/19/2023 19:16:11'!
close
	session commit.
	session close.! !

!PersistentErpSystem methodsFor: 'transaction management' stamp: 'eaam 11/19/2023 19:15:39'!
start
	session beginTransaction.! !


!classDefinition: #TransientErpSystem category: 'CustomerImporter'!
ErpSystem subclass: #TransientErpSystem
	instanceVariableNames: 'dataCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!TransientErpSystem methodsFor: 'transaction management' stamp: 'eaam 11/19/2023 19:25:25'!
close! !

!TransientErpSystem methodsFor: 'transaction management' stamp: 'eaam 11/19/2023 20:06:06'!
isEmpty
	^dataCollection isEmpty.! !

!TransientErpSystem methodsFor: 'transaction management' stamp: 'eaam 11/19/2023 19:20:19'!
start! !


!TransientErpSystem methodsFor: 'initialization' stamp: 'eaam 11/19/2023 20:06:06'!
initialize
	 
	dataCollection := OrderedCollection new.! !


!TransientErpSystem methodsFor: 'private' stamp: 'eaam 11/23/2023 18:55:25'!
add: anObject 
	dataCollection add: anObject.! !

!TransientErpSystem methodsFor: 'private' stamp: 'eaam 11/22/2023 18:57:49'!
select: aCondition ofType: aType
	^((self selectAllOfType: aType) select: aCondition )copy.! !

!TransientErpSystem methodsFor: 'private' stamp: 'eaam 11/22/2023 18:57:33'!
selectAllOfType: aType 
	^dataCollection select:[:anObject | anObject class = aType] copy.! !


!classDefinition: #Party category: 'CustomerImporter'!
Object subclass: #Party
	instanceVariableNames: 'id identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Party methodsFor: 'addresses' stamp: 'eaam 11/23/2023 19:17:07'!
addAddress: anAddress

	addresses add: anAddress ! !


!Party methodsFor: 'accessing' stamp: 'eaam 11/23/2023 21:04:50'!
hasAddressWithProvince: aProvinceToCheck andStreetName: aStreetNameToCheck andStreetNumber: aStreetNumberToCheck andZipCode: aZipCodeToCheck andTown: aTownToCheck
	^(addresses select: [ : anAddress | 
		anAddress hasProvince: aProvinceToCheck streetNumber: aStreetNumberToCheck streetName: aStreetNameToCheck  zipCode:  aZipCodeToCheck town: aTownToCheck . ]) isEmpty not.! !

!Party methodsFor: 'accessing' stamp: 'eaam 11/23/2023 21:05:24'!
numberOfAddresses
	^addresses size! !


!classDefinition: #Customer category: 'CustomerImporter'!
Party subclass: #Customer
	instanceVariableNames: 'firstName lastName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

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

!Customer methodsFor: 'testing' stamp: 'eaam 11/23/2023 20:07:01'!
hasFirstName: aFirstNameToCheck andLastName: aLastNameToCheck andIDType: anIDTypeToCheck andIDNumber: anIDNumberToCheck 
	^(aFirstNameToCheck = firstName) 
	and:	(aLastNameToCheck = lastName ) 
	and:	(anIDTypeToCheck = identificationType ) 
	and:	(anIDNumberToCheck = identificationNumber )! !

!Customer methodsFor: 'testing' stamp: 'eaam 11/23/2023 19:45:42'!
hasIDType: anIDTypeToCheck andIDNumber: anIDNumberToCheck
	^(identificationType = anIDTypeToCheck) and: (identificationNumber = anIDNumberToCheck)! !

!Customer methodsFor: 'testing' stamp: 'eaam 11/19/2023 19:35:30'!
hasIdentificationNumber: aIDNumber
	^aIDNumber = identificationNumber 
! !


!classDefinition: #Supplier category: 'CustomerImporter'!
Party subclass: #Supplier
	instanceVariableNames: 'name customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Supplier methodsFor: 'initialization' stamp: 'eaam 11/23/2023 19:58:21'!
initializeWithName: aName identificationType: aIdentificationType identificationNumber: aIdentificationNumber 
	name := aName.
	identificationType := aIdentificationType.
	identificationNumber := aIdentificationNumber.
	addresses := OrderedCollection new.
	customers := OrderedCollection new.! !


!Supplier methodsFor: 'testing' stamp: 'eaam 11/23/2023 20:07:39'!
hasCustomerWithIDType: anIDTypeToCheck andIDNumber: anIDNumberToCheck andFirstName: aFirstNameToCheck andLastName: aLastNameToCheck  
	^(customers select: [ : aCustomer | aCustomer hasFirstName: aFirstNameToCheck andLastName: aLastNameToCheck andIDType: anIDTypeToCheck andIDNumber: anIDNumberToCheck ]) isEmpty not
	! !

!Supplier methodsFor: 'testing' stamp: 'eaam 11/23/2023 21:05:15'!
hasName: aName andIDType: anIDTypeToCheck andIdNumber: aIdNumber
	^aName = name and: (aIdNumber = identificationNumber )! !

!Supplier methodsFor: 'testing' stamp: 'eaam 11/23/2023 18:50:09'!
idTypeIs: aIdType 
	^identificationType = aIdType .! !


!Supplier methodsFor: 'accessing' stamp: 'eaam 11/23/2023 19:59:07'!
numberOfCustomers
	^customers size! !


!Supplier methodsFor: 'customer management' stamp: 'eaam 11/23/2023 19:57:29'!
addCustomer: aCustomerToAdd
	customers add: aCustomerToAdd ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Supplier class' category: 'CustomerImporter'!
Supplier class
	instanceVariableNames: ''!

!Supplier class methodsFor: 'initialization' stamp: 'eaam 11/23/2023 18:40:47'!
name: aName identificationType: aIdentificationType identificationNumber: aIdentificationNumber 
	^self new initializeWithName: aName identificationType: aIdentificationType identificationNumber: aIdentificationNumber .! !
