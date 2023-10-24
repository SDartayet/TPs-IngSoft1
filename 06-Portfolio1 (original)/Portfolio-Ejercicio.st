!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: 'portfolio1 portfolio2 portfolio3 portfolio4 portfolio5 account1 account2 transaction orderedCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:00:33'!
test01PortfolioHasZeroAsBalanceWhenCreated 

	
	portfolio1 := Portfolio new.

	self assert: 0 equals: portfolio1 balance.
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:01:21'!
test02PortfolioBalanceChangesWhenAccountInItRegistersTransaction
	
	
	
	portfolio1 := Portfolio new.
	account1 := ReceptiveAccount new.
	Deposit register: 50 on: account1.
	
	portfolio1 addReceptiveAccount: account1.

	self assert: 50 equals: portfolio1 balance.
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:01:21'!
test03PortfolioBalanceIsCorrectAfterMultipleTransactionsFromAccountInIt
	
	
	portfolio1 := Portfolio new.
	account1 := ReceptiveAccount new.
	Deposit register: 520 on: account1.
	Withdraw register: 20 on: account1.
	portfolio1 addReceptiveAccount: account1.
	
	self assert: 500 equals: portfolio1 balance.
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:01:28'!
test04PortfolioBalanceIsCorrectAfterChangesOnMultipleTransactionsFromDifferentAccountsInIt
	
	
	
	portfolio1 := Portfolio new.
	account1 := ReceptiveAccount new.
	Deposit register: 520 on: account1.
	Withdraw register: 20 on: account1.
	
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account2.
	
	portfolio1 addReceptiveAccount: account1.
	portfolio1 addReceptiveAccount: account2.
	
	self assert: 600 equals: portfolio1 balance.
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:02:26'!
test05PortfolioHasTransactionFromAccountInItRegistered
	
	
	
	portfolio1 := Portfolio new.
	account1 := ReceptiveAccount new.
	
	portfolio1 addReceptiveAccount: account1.
	transaction := Deposit register: 5 on: account1 .
	
	self assert: ( portfolio1 hasRegistered: transaction)
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 17:31:20'!
test06PortfolioBalanceIsCorrectAfterTransactionFromPortfolioInIt
	
	| portfolio anotherPortfolio yetAnotherPortfolio account|
	
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	yetAnotherPortfolio := Portfolio new.
	
	Deposit register: 520 on: account.
	Withdraw register: 20 on: account.
	anotherPortfolio addReceptiveAccount: account.
	portfolio addPortfolio: anotherPortfolio.
	
	self assert: 500 equals: portfolio balance.
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:01:28'!
test07PortfolioBalanceIsCorrectAfterTransactionsFromMultiplePortfoliosInIt
	
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	portfolio3 := Portfolio new.
	
	Deposit register: 450 on: account1.
	Deposit register: 50 on: account2.
	
	portfolio2 addReceptiveAccount: account1.
	portfolio3 addReceptiveAccount: account2.
	
	portfolio1 addPortfolio: portfolio2.
	portfolio1 addPortfolio: portfolio3.
	
	self assert: 500 equals: portfolio1 balance.
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:02:26'!
test08PortfolioHasTransactionFromPortfoliosInItRegistered
	
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount new.
	transaction := Deposit register: 500 on: account1. 
	
	portfolio2 addReceptiveAccount: account1 .
	portfolio1 addPortfolio: portfolio2.
	
	self assert: (portfolio1 hasRegistered: transaction).
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:01:40'!
test09PortfolioHasNoTransactionsWhenCreated
	
	
	
	portfolio1 := Portfolio new.
	orderedCollection := OrderedCollection new.
	
	
	self assert: orderedCollection equals: portfolio1 transactions .
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:02:26'!
test10PortfolioKnowsTransactionsOfAccountInIt
	
	
	
	portfolio1 := Portfolio new.
	account1 := ReceptiveAccount new.
	orderedCollection := OrderedCollection new.
	transaction := Deposit register: 10 on: account1.
	
	
	orderedCollection add: transaction.
	portfolio1 addReceptiveAccount: account1.
	
	
	self assert: orderedCollection equals: portfolio1 transactions .
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:02:26'!
test11PortfolioKnowsTransactionsOfPortfoliosInIt
	
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	orderedCollection := OrderedCollection new.
	account1 := ReceptiveAccount new.
	transaction := Deposit register: 10 on: account1.
	
	orderedCollection add: transaction.
	portfolio2 addReceptiveAccount: account1.
	portfolio1 addPortfolio: portfolio2.
	
	
	self assert: orderedCollection equals: portfolio1 transactions .
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:01:21'!
test12PortfolioCantAddAlreadyAddedAccount
	
	
	
	portfolio1 := Portfolio new.
	account1 := ReceptiveAccount new.
	
	portfolio1 addReceptiveAccount: account1.
	
	
	self should: [portfolio1 addReceptiveAccount: account1]
	raise: Error
	withMessageText: FinancialAsset alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:01:21'!
test13PortfolioCantAddPortfolioThatHasAnAccountItAlreadyHas
	
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount new.
	
	portfolio1 addReceptiveAccount: account1.
	portfolio2 addPortfolio: portfolio1.
	
	
	self should: [portfolio2 addReceptiveAccount: account1]
	raise: Error
	withMessageText: FinancialAsset alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:01:22'!
test14PortfolioCantAddAPortfolioThatHasAnAccountItAlreadyHas
	
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	account1 := ReceptiveAccount new.
	
	portfolio1 addReceptiveAccount: account1.
	portfolio3 addPortfolio: portfolio2.
	portfolio3 addPortfolio: portfolio1.
	
	
	self should: [portfolio3 addReceptiveAccount: account1]
	raise: Error
	withMessageText: FinancialAsset alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:01:21'!
test15PortfolioCantAddAccountThatsAlreadyInPortfolioItsIn
	
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	account1 := ReceptiveAccount new.
	
	portfolio2 addReceptiveAccount: account1.
	portfolio2 addPortfolio: portfolio1.
	portfolio3 addPortfolio: portfolio1.
	
	
	self should: [portfolio1 addReceptiveAccount: account1]
	raise: Error
	withMessageText: FinancialAsset alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:01:22'!
test16PortfolioCantAddAccountThatsIncludedInParentPortfolio
	
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	account1 := ReceptiveAccount new.
	
	portfolio3 addReceptiveAccount: account1.
	portfolio2 addPortfolio: portfolio1.
	portfolio3 addPortfolio: portfolio2.
	
	
	self should: [portfolio1 addReceptiveAccount: account1]
	raise: Error
	withMessageText: FinancialAsset alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:00:33'!
test17PortfolioCantAddItselfToItsPortfolios
	
	
	
	portfolio1 := Portfolio new.
	
	self should: [ portfolio1 addPortfolio: portfolio1 . ]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:00:47'!
test18PortfolioCantAddRepeatedPortfolio
	
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio1 addPortfolio: portfolio2 .
	
	self should: [ portfolio1 addPortfolio: portfolio2 . ]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:00:56'!
test19PortfolioCantAddPortfolioAlreadyInItsPortfolios
	
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	portfolio1 addPortfolio: portfolio2 .
	portfolio2 addPortfolio: portfolio3 .
	
	self should: [ portfolio1 addPortfolio: portfolio3 . ]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:00:56'!
test20PortfolioCantAddPortfolioThatsInItsParentPortfolio
	
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	portfolio1 addPortfolio: portfolio2 .
	portfolio1 addPortfolio: portfolio3 .
	
	self should: [ portfolio2 addPortfolio: portfolio3 . ]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:01:21'!
test21PortfolioWithAccountCantAddPortfolioWithTheSameAccount
	
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	account1 := ReceptiveAccount new.
	
	portfolio1 addReceptiveAccount: account1 .
	portfolio2 addReceptiveAccount: account1 .
	
	self should: [ portfolio1 addPortfolio: portfolio2 . ]
	raise: Error
	withMessageText: FinancialAsset alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:00:56'!
test22PortfolioWithPortfolioCantAddPortfolioWithOnlyTheSamePortfolio
	
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	
	portfolio1 addPortfolio: portfolio3 .
	portfolio2 addPortfolio: portfolio3 .
	
	self should: [ portfolio1 addPortfolio: portfolio2 . ]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 18:01:12'!
test23PortfolioWithPortfoliosCantAddPortfolioWithTheSamePortfolios
	
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	portfolio5 := Portfolio new.
	
	portfolio1 addPortfolio: portfolio5 .
	portfolio1 addPortfolio: portfolio3 .
	portfolio2 addPortfolio: portfolio3 .
	portfolio2 addPortfolio: portfolio4 .
	
	
	self should: [ portfolio1 addPortfolio: portfolio2 . ]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'Sof D 10/18/2023 22:47:37'!
test24PortfolioCantAddPortfolioThatHasPortfolioThatIsInOneOfItsPortfolios
	
	
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	portfolio5 := Portfolio new.
	
	portfolio1 addPortfolio: portfolio5 .
	portfolio5 addPortfolio: portfolio3 .
	portfolio2 addPortfolio: portfolio3 .
	portfolio2 addPortfolio: portfolio4 .
	
	
	self should: [ portfolio1 addPortfolio: portfolio2 . ]
	raise: Error
	withMessageText: Portfolio alreadyInPortfolioErrorDescription 
	
! !


!PortfolioTest methodsFor: 'setup' stamp: 'Sof D 10/18/2023 18:01:40'!
setUp

	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	portfolio3 := Portfolio new.
	portfolio4 := Portfolio new.
	portfolio5 := Portfolio new.
	
	account1 := 	ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	orderedCollection := 	OrderedCollection new.! !

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

!FinancialAsset methodsFor: 'transactions' stamp: 'Sof D 10/18/2023 22:49:34'!
addTransactionsInto: aListOfTransactions
	self subclassResponsibility ! !

!FinancialAsset methodsFor: 'transactions' stamp: 'eaam 10/15/2023 11:14:16'!
transactions
	^self subclassResponsibility.! !


!FinancialAsset methodsFor: 'asset maangement' stamp: 'Sof D 10/18/2023 18:05:36'!
assetIsIncludedInPortfolioCollection: aFinancialAssetToRegister
	self subclassResponsibility ! !

!FinancialAsset methodsFor: 'asset maangement' stamp: 'Sof D 10/18/2023 21:55:48'!
isAssetOrItsAssetsAlreadyInPortfolio: aPortfolioToAddTheAssetTo

	self subclassResponsibility 
	! !


!FinancialAsset methodsFor: 'testing' stamp: 'eaam 10/15/2023 12:42:41'!
hasRegistered: aTransaction
	^self subclassResponsibility.! !


!FinancialAsset methodsFor: 'balance' stamp: 'eaam 10/15/2023 11:13:27'!
balance
	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'FinancialAsset class' category: 'Portfolio-Ejercicio'!
FinancialAsset class
	instanceVariableNames: ''!

!FinancialAsset class methodsFor: 'as yet unclassified' stamp: 'Sof D 10/18/2023 17:25:09'!
alreadyInPortfolioErrorDescription
	^'Asset is already in portfolio or its portfolios'! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
FinancialAsset subclass: #Portfolio
	instanceVariableNames: 'financialAssets parentPortfolios portfolioState'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'eaam 10/18/2023 14:02:18'!
balance
	^  (self totalBalanceOf: financialAssets )! !

!Portfolio methodsFor: 'balance' stamp: 'eaam 10/11/2023 14:26:58'!
totalBalanceOf: aCollectionOfFinancialAssets

	^ aCollectionOfFinancialAssets sum: [:aFinancialAsset | aFinancialAsset balance] ifEmpty: [0]! !


!Portfolio methodsFor: 'transactions' stamp: 'Sof D 10/18/2023 22:49:17'!
addTransactionsInto: aListOfTransactions
	financialAssets do: [ : aFinancialAsset | aFinancialAsset addTransactionsInto: aListOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'Sof D 10/18/2023 23:09:51'!
transactions
	| allTransactions |
	allTransactions := OrderedCollection new.
	
	self addTransactionsInto: allTransactions .
	^allTransactions ! !


!Portfolio methodsFor: 'initialize' stamp: 'Sof D 10/18/2023 23:02:04'!
initialize 
	financialAssets := OrderedCollection new.
	
	parentPortfolios := OrderedCollection new.
	
	portfolioState := RootPortfolio new.! !


!Portfolio methodsFor: 'testing' stamp: 'eaam 10/18/2023 14:03:49'!
hasRegistered: aDeposit 
	^(self hasRegistered: aDeposit in: financialAssets )! !

!Portfolio methodsFor: 'testing' stamp: 'eaam 10/11/2023 14:29:49'!
hasRegistered: aDeposit in: aCollectionOfFinancialAssets
	^(aCollectionOfFinancialAssets anySatisfy: [:aReceptiveAccount | aReceptiveAccount hasRegistered: aDeposit])! !


!Portfolio methodsFor: 'asset management' stamp: 'Sof D 10/18/2023 23:19:45'!
addPortfolio: aPortfolioToAdd

	
	
	self canAddFinancialAssetToPortfolio: aPortfolioToAdd .
	aPortfolioToAdd setAsParentPortfolio: self.
	financialAssets add: aPortfolioToAdd ! !

!Portfolio methodsFor: 'asset management' stamp: 'Sof D 10/18/2023 23:20:08'!
addReceptiveAccount: aReceptiveAccountToRegister
	self canAddFinancialAssetToPortfolio: aReceptiveAccountToRegister.
	financialAssets add: aReceptiveAccountToRegister.
	
! !

!Portfolio methodsFor: 'asset management' stamp: 'Sof D 10/18/2023 17:28:20'!
assetIsIncludedInPortfolioCollection: aFinancialAssetToRegister
	
	(aFinancialAssetToRegister = self) ifTrue: [ self error: self class alreadyInPortfolioErrorDescription ].

	(financialAssets do: [:aPortfolio | aPortfolio assetIsIncludedInPortfolioCollection: aFinancialAssetToRegister])! !

!Portfolio methodsFor: 'asset management' stamp: 'Sof D 10/18/2023 18:27:35'!
canAddFinancialAssetToPortfolio: aFinancialAssetToRegister

	portfolioState canAddAsset: aFinancialAssetToRegister toPortfolio: self! !

!Portfolio methodsFor: 'asset management' stamp: 'Sof D 10/18/2023 21:55:49'!
isAssetOrItsAssetsAlreadyInPortfolio: aPortfolioToAddTheAssetTo

	aPortfolioToAddTheAssetTo assetIsIncludedInPortfolioCollection: self.
	financialAssets do: [ : aFinancialAsset | aFinancialAsset isAssetOrItsAssetsAlreadyInPortfolio: aPortfolioToAddTheAssetTo ]! !

!Portfolio methodsFor: 'asset management' stamp: 'Sof D 10/18/2023 23:02:04'!
isFinancialAssetInAParentPortfolio: aFinancialAssetToRegister
	parentPortfolios do: [:aParentPortfolio | aParentPortfolio canAddFinancialAssetToPortfolio: aFinancialAssetToRegister ]! !

!Portfolio methodsFor: 'asset management' stamp: 'Sof D 10/18/2023 23:02:04'!
setAsParentPortfolio: aParentPortfolio 
	parentPortfolios add: aParentPortfolio.
	
	portfolioState := NonRootPortfolio new.! !

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


!ReceptiveAccount methodsFor: 'transactions' stamp: 'Sof D 10/18/2023 22:49:50'!
addTransactionsInto: aListOfTransactions
	aListOfTransactions addAll: transactions ! !

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


!ReceptiveAccount methodsFor: 'asset management' stamp: 'Sof D 10/18/2023 17:28:20'!
assetIsIncludedInPortfolioCollection: aFinancialAssetToRegister
	
	(aFinancialAssetToRegister = self) ifTrue: [ self error: self class alreadyInPortfolioErrorDescription ].

	! !

!ReceptiveAccount methodsFor: 'asset management' stamp: 'Sof D 10/18/2023 21:55:49'!
isAssetOrItsAssetsAlreadyInPortfolio: aPortfolioToAddTheAssetTo

	aPortfolioToAddTheAssetTo assetIsIncludedInPortfolioCollection: self
	! !


!classDefinition: #PortfolioState category: 'Portfolio-Ejercicio'!
Object subclass: #PortfolioState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioState methodsFor: 'asset registration' stamp: 'Sof D 10/18/2023 18:27:58'!
canAddAsset: aFinancialAssetToRegister toPortfolio: aPortfolioToAddTheAssetTo
	self subclassResponsibility ! !


!classDefinition: #NonRootPortfolio category: 'Portfolio-Ejercicio'!
PortfolioState subclass: #NonRootPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!NonRootPortfolio methodsFor: 'asset registration' stamp: 'Sof D 10/18/2023 21:36:32'!
canAddAsset: aFinancialAssetToRegister toPortfolio: aPortfolioToAddTheAssetTo

	aPortfolioToAddTheAssetTo isFinancialAssetInAParentPortfolio: aFinancialAssetToRegister ! !


!classDefinition: #RootPortfolio category: 'Portfolio-Ejercicio'!
PortfolioState subclass: #RootPortfolio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!RootPortfolio methodsFor: 'asset registration' stamp: 'Sof D 10/18/2023 21:55:49'!
canAddAsset: aFinancialAssetToRegister toPortfolio: aPortfolioToAddTheAssetTo

	
	aFinancialAssetToRegister isAssetOrItsAssetsAlreadyInPortfolio: aPortfolioToAddTheAssetTo ! !
