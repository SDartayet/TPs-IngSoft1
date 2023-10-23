!classDefinition: #AccountSummaryTests category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTests methodsFor: 'tests' stamp: 'eaam 10/23/2023 01:56:36'!
test01
	| account resumen report|
	account := ReceptiveAccount new.
	resumen := OrderedCollection new.
	report := AccountSummaryReport sumaryOf: account.
	resumen add: 'Balance = 0'.
	report summary.
	self assert: report content equals: resumen! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'eaam 10/23/2023 01:56:30'!
test02
	| account resumen report|
	account := ReceptiveAccount new.
	resumen := OrderedCollection new.
	Deposit register: 10 on: account.
	report := AccountSummaryReport sumaryOf: account. 
	resumen add: 'Depósito por 10'.
	resumen add: 'Balance = 10'.
	report summary.
	self assert: report content equals: resumen! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'eaam 10/23/2023 02:06:35'!
test03
	| account resumen report|
	account := ReceptiveAccount new.
	resumen := OrderedCollection new.
	Withdraw register: 10 on: account. 
	report := AccountSummaryReport sumaryOf: account.
	resumen add: 'Extracción por 10'.
	resumen add: 'Balance = -10'.
	report summary.
	self assert: report content equals: resumen! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'eaam 10/23/2023 02:20:27'!
test04
	| accounttoExtractFrom accountToDeposit resumen report|
	accounttoExtractFrom := ReceptiveAccount new.
	accountToDeposit := ReceptiveAccount new.
	resumen := OrderedCollection new.
	Transfer from: accounttoExtractFrom to: accountToDeposit amount: 1.
	report := AccountSummaryReport sumaryOf: accounttoExtractFrom.
	resumen add: 'Salida por transferencia de 1'.
	resumen add: 'Balance = -1'.
	report summary.
	self assert: report content equals: resumen! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'eaam 10/23/2023 02:20:48'!
test05
	| accounttoExtractFrom accountToDeposit resumen report|
	accounttoExtractFrom := ReceptiveAccount new.
	accountToDeposit := ReceptiveAccount new.
	resumen := OrderedCollection new.
	Transfer from: accounttoExtractFrom to: accountToDeposit amount: 1.
	report := AccountSummaryReport sumaryOf: accountToDeposit.
	resumen add: 'Entrada por transferencia de 1'.
	resumen add: 'Balance = 1'.
	report summary.
	self assert: report content equals: resumen! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'eaam 10/23/2023 02:27:59'!
test06
	| account resumen report|
	account := ReceptiveAccount new.
	resumen := OrderedCollection new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account. 
	report := AccountSummaryReport sumaryOf: account.
	resumen add: 'Depósito por 100'.
	resumen add: 'Extracción por 50'.
	resumen add: 'Balance = 50'.
	report summary.
	self assert: report content equals: resumen! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'eaam 10/19/2023 21:52:59'!
test08TransferChangesBalance

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new..
	
	Transfer from: account1 to: account2 amount: 1.
		
	self assert: -1 equals: account1 balance .
	self assert: 1 equals: account2 balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'eaam 10/20/2023 01:29:33'!
test09transferIsRegistered

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	transfer := Transfer from: account1 to: account2 amount: 1.
		
	self assert: (account1 hasRegistered: transfer).
	self assert:  (account2 hasRegistered: transfer) .
! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'value from to'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'eaam 10/22/2023 23:48:08'!
test01

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	transfer := Transfer from: account1 to: account2 amount: 1.
	
		
	self assert: (transfer to) equals: account2 transactions first .
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'eaam 10/22/2023 23:48:05'!
test02

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	transfer := Transfer from: account1 to: account2 amount: 1.
		
	self assert: (transfer from) equals: account1 transactions first.
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'eaam 10/22/2023 23:48:01'!
test03

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	transfer := Transfer from: account1 to: account2 amount: 1.
		
	self assert: (transfer from) transfer equals: transfer.
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'eaam 10/22/2023 23:50:02'!
test04

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	transfer := Transfer from: account1 to: account2 amount: 1.
		
	self assert: (transfer to) transfer equals: transfer.
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'eaam 10/22/2023 23:51:29'!
test05

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	transfer := Transfer from: account1 to: account2 amount: 1.
		
	self assert: (transfer to) from equals: (transfer from).
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'eaam 10/22/2023 23:52:15'!
test06

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	transfer := Transfer from: account1 to: account2 amount: 1.
		
	self assert: (transfer from) to equals: (transfer to).
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'eaam 10/22/2023 23:47:58'!
test07

	| account1 account2|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	
	self should: [Transfer from: account1 to: account2 amount: 0. ]

	raise: Error

	withMessageText: Transfer cantTransferZeroErrorDescription.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'eaam 10/22/2023 23:50:56'!
test08

	| account1 |
	
	account1 := ReceptiveAccount new.
	
	
	self should: [Transfer from: account1 to: account1 amount: 1. . ]

	raise: Error

	withMessageText: Transfer cantTransferToItselfErrorDescription.! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'sumaryReport' stamp: 'eaam 10/23/2023 02:29:33'!
summary: aReport
	transactions do: [:aTransaction | aTransaction dataPrintIn: aReport]
	! !



!classDefinition: #AccountSummaryReport category: 'Portfolio-Solucion'!
Object subclass: #AccountSummaryReport
	instanceVariableNames: 'account accountSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryReport methodsFor: 'initialization' stamp: 'eaam 10/23/2023 01:57:39'!
initializeSumary: aAccount
	account := aAccount.
	accountSummary := OrderedCollection new.! !


!AccountSummaryReport methodsFor: 'evaluating' stamp: 'eaam 10/23/2023 01:57:39'!
content
	^accountSummary! !

!AccountSummaryReport methodsFor: 'evaluating' stamp: 'eaam 10/23/2023 02:02:40'!
printDepositWithValue: aValue 
	accountSummary add: ('Depósito por ', aValue asString).! !

!AccountSummaryReport methodsFor: 'evaluating' stamp: 'eaam 10/23/2023 02:21:31'!
printIncomingTransferWithValue: aValue 
	accountSummary add: ('Entrada por transferencia de ', aValue asString).! !

!AccountSummaryReport methodsFor: 'evaluating' stamp: 'eaam 10/23/2023 02:18:30'!
printOutgoingTransferWithValue: aValue 
	accountSummary add: ('Salida por transferencia de ', aValue asString).! !

!AccountSummaryReport methodsFor: 'evaluating' stamp: 'eaam 10/23/2023 02:03:31'!
printWithdrawWithValue: aValue 
	accountSummary add: ('Extracción por ', aValue asString).! !

!AccountSummaryReport methodsFor: 'evaluating' stamp: 'eaam 10/23/2023 02:01:15'!
summary
	account summary: self.
	accountSummary add: ('Balance = ', account balance asString).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryReport class' category: 'Portfolio-Solucion'!
AccountSummaryReport class
	instanceVariableNames: ''!

!AccountSummaryReport class methodsFor: 'instance creation' stamp: 'eaam 10/23/2023 00:03:51'!
sumaryOf: aAccount
	^self new initializeSumary: aAccount! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'balance' stamp: 'eaam 10/23/2023 02:19:24'!
dataPrintIn: aReport

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'print' stamp: 'eaam 10/23/2023 01:52:51'!
dataPrintIn: aReport
	aReport printDepositWithValue: value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #IncomingTransfer category: 'Portfolio-Solucion'!
AccountTransaction subclass: #IncomingTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!IncomingTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/20/2023 13:50:22'!
affectBalance: aBalance

	^aBalance + transfer value ! !

!IncomingTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/23/2023 02:20:03'!
dataPrintIn: aReport 
	aReport printIncomingTransferWithValue: self value! !

!IncomingTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/20/2023 13:52:42'!
initializeFor: aTransfer

	transfer := aTransfer ! !

!IncomingTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/21/2023 00:52:13'!
transfer
	^transfer! !

!IncomingTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/20/2023 13:52:19'!
value 

	^transfer value! !


!IncomingTransfer methodsFor: 'category-name' stamp: 'eaam 10/22/2023 23:51:55'!
from
	^transfer from.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IncomingTransfer class' category: 'Portfolio-Solucion'!
IncomingTransfer class
	instanceVariableNames: ''!

!IncomingTransfer class methodsFor: 'nil' stamp: 'eaam 10/20/2023 13:51:41'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !


!classDefinition: #OutgoingTransfer category: 'Portfolio-Solucion'!
AccountTransaction subclass: #OutgoingTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/20/2023 13:52:52'!
affectBalance: aBalance

	^aBalance - transfer value ! !

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/23/2023 02:17:27'!
dataPrintIn: aReport 
	aReport printOutgoingTransferWithValue: self value! !

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/20/2023 13:52:46'!
initializeFor: aTransfer

	transfer := aTransfer ! !

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/22/2023 23:52:32'!
to
	^transfer to.! !

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/22/2023 23:50:45'!
transfer
	^transfer ! !

!OutgoingTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/20/2023 13:52:26'!
value 

	^transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OutgoingTransfer class' category: 'Portfolio-Solucion'!
OutgoingTransfer class
	instanceVariableNames: ''!

!OutgoingTransfer class methodsFor: 'as yet unclassified' stamp: 'eaam 10/20/2023 13:51:45'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'print' stamp: 'eaam 10/23/2023 01:54:06'!
dataPrintIn: aReport
	aReport printWithdrawWithValue: value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value from to'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/20/2023 03:17:23'!
affectBalance: aBalance
	^aBalance.	! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/19/2023 22:01:17'!
initializeFrom: aAccountToTransferFrom to: aAccountToTransferTo forAmount: aAmmount
	value :=  aAmmount.
	from := aAccountToTransferFrom.
	to := aAccountToTransferTo.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/20/2023 14:00:10'!
to
	^to! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/20/2023 01:50:09'!
value

	^value! !


!Transfer methodsFor: 'category-name' stamp: 'eaam 10/23/2023 02:11:02'!
dataPrintIn: aReport! !

!Transfer methodsFor: 'category-name' stamp: 'eaam 10/20/2023 14:35:18'!
from
	
	^from! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'initialize' stamp: 'eaam 10/21/2023 01:05:28'!
from: aAccountToTransferFrom to: aAccountToTransferTo amount: aAmountToTransfer
	| transfer outgoingTransfer incomingTransfer |
	
	self shouldTransfer: aAmountToTransfer to: aAccountToTransferTo from: aAccountToTransferFrom.
	
	transfer := self new.
	
	outgoingTransfer := OutgoingTransfer register: transfer on: aAccountToTransferFrom.
	incomingTransfer := IncomingTransfer register: transfer on: aAccountToTransferTo.
	
	transfer initializeFrom: outgoingTransfer to: incomingTransfer forAmount: aAmountToTransfer.
	
	aAccountToTransferFrom register: transfer.
	aAccountToTransferTo register: transfer.
	^transfer.
	! !

!Transfer class methodsFor: 'initialize' stamp: 'eaam 10/21/2023 01:05:28'!
shouldTransfer: aAmountToTransfer to: aAccountToTransferTo from: aAccountToTransferFrom

	(aAccountToTransferFrom = aAccountToTransferTo) ifTrue: [self error: self cantTransferToItselfErrorDescription].
	(aAmountToTransfer=0) ifTrue: [self error: self cantTransferZeroErrorDescription]! !


!Transfer class methodsFor: 'error' stamp: 'eaam 10/21/2023 00:59:49'!
cantTransferToItselfErrorDescription
	^'lol claramente no podes hacer esto'! !

!Transfer class methodsFor: 'error' stamp: 'eaam 10/21/2023 01:03:16'!
cantTransferZeroErrorDescription
	^'no podes ser tan rata hermano'.! !
