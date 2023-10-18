!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'eaam 10/9/2023 21:39:33'!
test01PortfolioHasZeroAsBalanceWhenCreated 

	| portfolio |
	
	portfolio := Portfolio new.

	self assert: 0 equals: portfolio balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 00:15:36'!
test02PortfolioBalanceChangesWhenAccountInItRegistersTransaction
	
	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	
	portfolio addReceptiveAccount: account.

	self assert: 50 equals: portfolio balance.
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 00:28:33'!
test03PortfolioBalanceIsCorrectAfterMultipleTransactionsFromAccountInIt
	
	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 520 on: account.
	Withdraw register: 20 on: account.
	portfolio addReceptiveAccount: account.
	
	self assert: 500 equals: portfolio balance.
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 00:28:22'!
test04PortfolioBalanceIsCorrectAfterChangesOnMultipleTransactionsFromDifferentAccountsInIt
	
	| portfolio firstAccount secondAccount |
	
	portfolio := Portfolio new.
	firstAccount := ReceptiveAccount new.
	Deposit register: 520 on: firstAccount.
	Withdraw register: 20 on: firstAccount.
	
	secondAccount := ReceptiveAccount new.
	Deposit register: 100 on: secondAccount.
	
	portfolio addReceptiveAccount: firstAccount.
	portfolio addReceptiveAccount: secondAccount.
	
	self assert: 600 equals: portfolio balance.
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 00:24:50'!
test05PortfolioHasTransactionFromAccountInItRegistered
	
	| portfolio  account deposit|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio addReceptiveAccount: account.
	deposit := Deposit register: 5 on: account .
	
	self assert: ( portfolio hasRegistered: deposit)
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 00:28:58'!
test06PortfolioBalanceIsCorrectAfterTransactionFromPortfolioInIt
	
	| portfolio portfolioToAdd aPortfolioInOtherPortfolio account|
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	account := ReceptiveAccount new.
	aPortfolioInOtherPortfolio := Portfolio new.
	
	Deposit register: 520 on: account.
	Withdraw register: 20 on: account.
	portfolioToAdd addReceptiveAccount: account.
	portfolio addPortfolio: portfolioToAdd.
	
	self assert: 500 equals: portfolio balance.
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 00:28:49'!
test07PortfolioBalanceIsCorrectAfterTransactionsFromMultiplePortfoliosInIt
	
	| portfolio firstPortfolioToAdd secondPortfolioToAdd firstAccount secondAccount|
	
	portfolio := Portfolio new.
	firstPortfolioToAdd := Portfolio new.
	firstAccount := ReceptiveAccount new.
	secondAccount := ReceptiveAccount new.
	secondPortfolioToAdd := Portfolio new.
	
	Deposit register: 450 on: firstAccount.
	Deposit register: 50 on: secondAccount.
	
	firstPortfolioToAdd addReceptiveAccount: firstAccount.
	secondPortfolioToAdd addReceptiveAccount: secondAccount.
	
	portfolio addPortfolio: firstPortfolioToAdd.
	portfolio addPortfolio: secondPortfolioToAdd.
	
	self assert: 500 equals: portfolio balance.
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 00:25:10'!
test08PortfolioHasTransactionFromPortfoliosInItRegistered
	
	| portfolio portfolioToAdd account transaction|
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	account := ReceptiveAccount new.
	transaction := Deposit register: 500 on: account. 
	
	portfolioToAdd addReceptiveAccount: account .
	portfolio addPortfolio: portfolioToAdd.
	
	self assert: (portfolio hasRegistered: transaction).
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 00:29:18'!
test09PortfolioHasNoTransactionsWhenCreated
	
	| portfolio anOrderedCollection|
	
	portfolio := Portfolio new.
	anOrderedCollection := OrderedCollection new.
	
	
	self assert: anOrderedCollection equals: portfolio transactions .
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 00:25:47'!
test10PortfolioKnowsTransactionsOfAccountInIt
	
	| portfolio anOrderedCollection account aTransaction|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	anOrderedCollection := OrderedCollection new.
	aTransaction := Deposit register: 10 on: account.
	
	
	anOrderedCollection add: aTransaction.
	portfolio addReceptiveAccount: account.
	
	
	self assert: anOrderedCollection equals: portfolio transactions .
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 00:27:03'!
test11PortfolioKnowsTransactionsOfPortfoliosInIt
	
	| portfolio anOrderedCollection aportfolioToAdd account aTransaction|
	
	portfolio := Portfolio new.
	aportfolioToAdd := Portfolio new.
	anOrderedCollection := OrderedCollection new.
	account := ReceptiveAccount new.
	aTransaction := Deposit register: 10 on: account.
	
	anOrderedCollection add: aTransaction.
	aportfolioToAdd addReceptiveAccount: account.
	portfolio addPortfolio: aportfolioToAdd.
	
	
	self assert: anOrderedCollection equals: portfolio transactions .
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 00:36:46'!
test12PortfolioCantAddAlreadyAddedAccount
	
	| portfolio anAccount|
	
	portfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	portfolio addReceptiveAccount: anAccount.
	
	
	self should: [portfolio addReceptiveAccount: anAccount]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 00:36:39'!
test13PortfolioCantAddPortfolioThatHasAnAccountItAlreadyHas
	
	| portfolio anAccount aParentPortfolio|
	
	portfolio := Portfolio new.
	aParentPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	portfolio addReceptiveAccount: anAccount.
	aParentPortfolio addPortfolio: portfolio.
	
	
	self should: [aParentPortfolio addReceptiveAccount: anAccount]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 00:47:19'!
test14PortfolioCantAddAPortfolioThatHasAnAccountItAlreadyHas
	
	| portfolio1 portfolio2 anAccount aParentPortfolio|
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	aParentPortfolio := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	portfolio1 addReceptiveAccount: anAccount.
	aParentPortfolio addPortfolio: portfolio2.
	aParentPortfolio addPortfolio: portfolio1.
	
	
	self should: [aParentPortfolio addReceptiveAccount: anAccount]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 00:47:29'!
test15PortfolioCantAddAccountThatsAlreadyInPortfolioItsIn
	
	| portfolio anAccount aParentPortfolio1 aParentPortfolio2|
	
	portfolio := Portfolio new.
	aParentPortfolio1 := Portfolio new.
	aParentPortfolio2 := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	aParentPortfolio1 addReceptiveAccount: anAccount.
	aParentPortfolio1 addPortfolio: portfolio.
	aParentPortfolio2 addPortfolio: portfolio.
	
	
	self should: [portfolio addReceptiveAccount: anAccount]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 01:12:27'!
test16PortfolioCantAddAccountThatsIncludedInParentPortfolio
	
	| portfolio anAccount aParentPortfolio1 aParentPortfolio2|
	
	portfolio := Portfolio new.
	aParentPortfolio1 := Portfolio new.
	aParentPortfolio2 := Portfolio new.
	anAccount := ReceptiveAccount new.
	
	aParentPortfolio2 addReceptiveAccount: anAccount.
	aParentPortfolio1 addPortfolio: portfolio.
	aParentPortfolio2 addPortfolio: aParentPortfolio1.
	
	
	self should: [portfolio addReceptiveAccount: anAccount]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 02:39:08'!
test17PortfolioCantAddItselfToItsPortfolios
	
	| portfolio  |
	
	portfolio := Portfolio new.
	
	self should: [ portfolio addPortfolio: portfolio . ]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 01:45:55'!
test18PortfolioCantAddRepeatedPortfolio
	
	| portfolio  anotherPortfolio |
	
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	portfolio addPortfolio: anotherPortfolio .
	
	self should: [ portfolio addPortfolio: anotherPortfolio . ]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 01:56:12'!
test19PortfolioCantAddPortfolioAlreadyInItsPortfolios
	
	| portfolio  anotherPortfolio yetAnotherPortfolio |
	
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	yetAnotherPortfolio := Portfolio new.
	
	portfolio addPortfolio: anotherPortfolio .
	anotherPortfolio addPortfolio: yetAnotherPortfolio .
	
	self should: [ portfolio addPortfolio: yetAnotherPortfolio . ]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 02:02:12'!
test20PortfolioCantAddPortfolioThatsInItsParentPortfolio
	
	| portfolio  anotherPortfolio yetAnotherPortfolio |
	
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	yetAnotherPortfolio := Portfolio new.
	
	portfolio addPortfolio: anotherPortfolio .
	portfolio addPortfolio: yetAnotherPortfolio .
	
	self should: [ anotherPortfolio addPortfolio: yetAnotherPortfolio . ]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 01:56:32'!
xxx
	
	| portfolio anotherPortfolio yetAnotherPortfolio  anAccount |
	
	"portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	yetAnotherPortfolio := Portfolio new.
	
	anAccount := ReceptiveAccount new.
	anotherPortfolio addReceptiveAccount: anAccount .
	
	portfolio addPortfolio: yetAnotherPortfolio.
	portfolio addPortfolio: anotherPortfolio .
	
	self should: [ yetAnotherPortfolio addReceptiveAccount: anAccount . ]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	"
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTest class' category: 'Portfolio-Ejercicio'!
PortfolioTest class
	instanceVariableNames: ''!

!PortfolioTest class methodsFor: 'as yet unclassified' stamp: 'eaam 10/17/2023 11:31:05'!
DoIt

| portfolio aAccount aParentPortfolio1 aParentPortfolio2|
	
	portfolio := Portfolio new.
	aParentPortfolio1 := Portfolio new.
	aParentPortfolio2 := Portfolio new.
	aAccount := ReceptiveAccount new.
	
	aParentPortfolio1 addReceptiveAccount: aAccount.
	aParentPortfolio1 addPortfolio: portfolio.
	aParentPortfolio2 addPortfolio: portfolio.
	
	
	self should: [aParentPortfolio2 addReceptiveAccount: aAccount]
	raise: Error
	withMessageText:'XXXX PLACEHOLDER ERROR XXX'.
	! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'eaam 10/9/2023 21:33:26'!
updateBalance: aBalanceToUpdate

	^ aBalanceToUpdate + value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'eaam 10/9/2023 20:38:09'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'eaam 10/9/2023 21:33:21'!
updateBalance: aBalanceToUpdate

	^ aBalanceToUpdate + value negated! !

!Withdraw methodsFor: 'value' stamp: 'eaam 10/9/2023 20:55:48'!
value

	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialAsset category: 'Portfolio-Ejercicio'!
Object subclass: #FinancialAsset
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialAsset methodsFor: 'as yet unclassified' stamp: 'eaam 10/15/2023 11:13:27'!
balance
	^self subclassResponsibility.! !

!FinancialAsset methodsFor: 'as yet unclassified' stamp: 'eaam 10/15/2023 12:42:41'!
hasRegistered: aTransaction
	^self subclassResponsibility.! !

!FinancialAsset methodsFor: 'as yet unclassified' stamp: 'eaam 10/15/2023 11:14:16'!
transactions
	^self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'receptiveAccounts portfolios parentPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'eaam 10/16/2023 13:41:49'!
balance
	^  (self totalBalanceOf: receptiveAccounts ) +(self totalBalanceOf: portfolios )! !

!Portfolio methodsFor: 'balance' stamp: 'eaam 10/11/2023 14:26:58'!
totalBalanceOf: aCollectionOfFinancialAssets

	^ aCollectionOfFinancialAssets sum: [:aFinancialAsset | aFinancialAsset balance] ifEmpty: [0]! !


!Portfolio methodsFor: 'transactions' stamp: 'Sof D 10/18/2023 00:41:22'!
accountIsIncludedInPortfolioOrItsPortfolios: aReceptiveAccountToRegister

	^(receptiveAccounts includes: aReceptiveAccountToRegister) or: (portfolios anySatisfy: [:aPortfolio | aPortfolio accountIsIncludedInPortfolioOrItsPortfolios: aReceptiveAccountToRegister])
			! !

!Portfolio methodsFor: 'transactions' stamp: 'Sof D 10/18/2023 02:15:18'!
addPortfolio: portfolioToAdd

	self canAddPortfolioToPortfolio: portfolioToAdd .
	portfolioToAdd setAsParentPortfolio: self.
	
	portfolios add: portfolioToAdd.! !

!Portfolio methodsFor: 'transactions' stamp: 'Sof D 10/18/2023 00:38:24'!
addReceptiveAccount: aReceptiveAccountToRegister
	self canAddAccountToPortfolio: aReceptiveAccountToRegister.
	receptiveAccounts add: aReceptiveAccountToRegister.! !

!Portfolio methodsFor: 'transactions' stamp: 'eaam 10/11/2023 14:29:24'!
allTheTransactionsOf: aCollectionOfFinancialAssets

	^ aCollectionOfFinancialAssets inject: OrderedCollection new into: [:anCollection :aChild | anCollection addAll: (aChild transactions)]! !

!Portfolio methodsFor: 'transactions' stamp: 'Sof D 10/18/2023 00:41:22'!
canAddAccountToPortfolio: aReceptiveAccountToRegister

	^(parentPortfolio isEmpty) 
		ifTrue: 
		[
			(self accountIsIncludedInPortfolioOrItsPortfolios: aReceptiveAccountToRegister) ifTrue: [self error: self class alreadyInPortfolioErrorDescription]
			]
		ifFalse: 
		[
			(parentPortfolio anySatisfy: [:aParentPortfolio | aParentPortfolio canAddAccountToPortfolio: aReceptiveAccountToRegister ]) ifTrue: [self error: self class alreadyInPortfolioErrorDescription].
			]! !

!Portfolio methodsFor: 'transactions' stamp: 'Sof D 10/18/2023 02:38:55'!
portfolioIsIncludedInPortfolioOrItsPortfolios: aPortfolioToRegister

	(aPortfolioToRegister = self) ifTrue: [ self error: self class alreadyInPortfolioErrorDescription ].
	
	(portfolios do: [:aPortfolio | aPortfolio portfolioIsIncludedInPortfolioOrItsPortfolios: aPortfolioToRegister])
			! !

!Portfolio methodsFor: 'transactions' stamp: 'eaam 10/16/2023 13:42:27'!
transactions
	| allTransactions |
	allTransactions := OrderedCollection new.
	allTransactions addAll: (self allTheTransactionsOf: receptiveAccounts).
	allTransactions addAll: (self allTheTransactionsOf: portfolios).
	^allTransactions ! !


!Portfolio methodsFor: 'initialize' stamp: 'eaam 10/17/2023 11:31:52'!
initialize 
	receptiveAccounts := OrderedCollection new.
	portfolios := OrderedCollection new.
	parentPortfolio := OrderedCollection new.! !

!Portfolio methodsFor: 'initialize' stamp: 'eaam 10/17/2023 11:31:59'!
setAsParentPortfolio: aParentPortfolio 
	parentPortfolio add: aParentPortfolio.! !


!Portfolio methodsFor: 'testing' stamp: 'eaam 10/16/2023 13:47:29'!
hasRegistered: aDeposit 
	^(self hasRegistered: aDeposit in: receptiveAccounts) or: (self hasRegistered: aDeposit in: portfolios )! !

!Portfolio methodsFor: 'testing' stamp: 'eaam 10/11/2023 14:29:49'!
hasRegistered: aDeposit in: aCollectionOfFinancialAssets
	^(aCollectionOfFinancialAssets anySatisfy: [:aReceptiveAccount | aReceptiveAccount hasRegistered: aDeposit])! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'Sof D 10/18/2023 02:38:01'!
canAddPortfolioToPortfolio: aPortfolioToRegister


	
	(parentPortfolio isEmpty) 
		ifTrue:[ self portfolioIsIncludedInPortfolioOrItsPortfolios: aPortfolioToRegister ]
		ifFalse: [ parentPortfolio do: [ : aPortfolio | aPortfolio canAddPortfolioToPortfolio: aPortfolioToRegister ]]
		

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'Sof D 10/18/2023 00:35:55'!
alreadyInPortfolioErrorDescription
	^'The financial asset is already in the portfolio or its parents'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'Sof D 10/18/2023 01:43:31'!
portfolioCantAddItselfErrorDescription
	^'A portfolio cant add itself to its portfolios!!'! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'eaam 10/9/2023 21:32:29'!
balance
	
	^transactions inject: 0 into: [ :acumulatedBalance :aTransaction |  aTransaction updateBalance: acumulatedBalance ].! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
