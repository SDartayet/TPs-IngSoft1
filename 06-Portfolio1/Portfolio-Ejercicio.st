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

!PortfolioTest methodsFor: 'tests' stamp: 'eaam 10/10/2023 12:56:32'!
test02
	
	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 50 on: account.
	
	portfolio addReceptiveAccount: account.

	self assert: 50 equals: portfolio balance.
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'eaam 10/10/2023 12:48:45'!
test03
	
	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	Deposit register: 520 on: account.
	Withdraw register: 20 on: account.
	portfolio addReceptiveAccount: account.
	
	self assert: 500 equals: portfolio balance.
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'eaam 10/10/2023 12:57:00'!
test04
	
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

!PortfolioTest methodsFor: 'tests' stamp: 'eaam 10/10/2023 13:11:09'!
test05
	
	| portfolio  account deposit|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio addReceptiveAccount: account.
	deposit := Deposit register: 5 on: account .
	
	self assert: ( portfolio hasRegistered: deposit)
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'eaam 10/10/2023 14:00:51'!
test07
	
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

!PortfolioTest methodsFor: 'tests' stamp: 'eaam 10/10/2023 14:06:22'!
test08
	
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

!PortfolioTest methodsFor: 'tests' stamp: 'eaam 10/10/2023 15:54:55'!
test09
	
	| portfolio portfolioToAdd account transaction|
	
	portfolio := Portfolio new.
	portfolioToAdd := Portfolio new.
	account := ReceptiveAccount new.
	transaction := Deposit register: 500 on: account. 
	
	portfolioToAdd addReceptiveAccount: account .
	portfolio addPortfolio: portfolioToAdd.
	
	self assert: (portfolio hasRegistered: transaction).
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'eaam 10/10/2023 15:46:16'!
test11
	
	| portfolio anOrderedCollection|
	
	portfolio := Portfolio new.
	anOrderedCollection := OrderedCollection new.
	
	
	self assert: anOrderedCollection equals: portfolio transactions .
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'eaam 10/10/2023 15:59:08'!
test12
	
	| portfolio anOrderedCollection account aTransaction|
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	anOrderedCollection := OrderedCollection new.
	aTransaction := Deposit register: 10 on: account.
	
	
	anOrderedCollection add: aTransaction.
	portfolio addReceptiveAccount: account.
	
	
	self assert: anOrderedCollection equals: portfolio transactions .
	
! !

!PortfolioTest methodsFor: 'tests' stamp: 'eaam 10/10/2023 16:05:45'!
test13
	
	| portfolio anOrderedCollection aportfolioToAdd account aTransaction|
	
	portfolio := Portfolio new.
	aportfolioToAdd := Portfolio new.
	anOrderedCollection := OrderedCollection new.
	account := ReceptiveAccount new.
	aTransaction := Deposit register: 10 on: account.
	
	anOrderedCollection add: aTransaction.
	aportfolioToAdd addPortfolio: account.
	portfolio addPortfolio: aportfolioToAdd.
	
	
	self assert: anOrderedCollection equals: portfolio transactions .
	
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


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'eaam 10/11/2023 14:31:07'!
balance
	^  (self totalBalanceOf: accounts )  + (self totalBalanceOf: portfolios).! !

!Portfolio methodsFor: 'balance' stamp: 'eaam 10/11/2023 14:26:58'!
totalBalanceOf: aCollectionOfFinancialAssets

	^ aCollectionOfFinancialAssets sum: [:aFinancialAsset | aFinancialAsset balance] ifEmpty: [0]! !


!Portfolio methodsFor: 'transactions' stamp: 'eaam 10/10/2023 15:03:15'!
addPortfolio: portfolioToAdd
	^portfolios add: portfolioToAdd.! !

!Portfolio methodsFor: 'transactions' stamp: 'eaam 10/10/2023 14:54:24'!
addReceptiveAccount: aReceptiveAccountToRegister
	accounts add: aReceptiveAccountToRegister.! !

!Portfolio methodsFor: 'transactions' stamp: 'eaam 10/11/2023 14:29:24'!
allTheTransactionsOf: aCollectionOfFinancialAssets

	^ aCollectionOfFinancialAssets inject: OrderedCollection new into: [:anCollection :aChild | anCollection addAll: (aChild transactions)]! !

!Portfolio methodsFor: 'transactions' stamp: 'eaam 10/10/2023 16:23:25'!
transactions
	| allTransactions |
	allTransactions := OrderedCollection new.
	allTransactions addAll: (self allTheTransactionsOf: portfolios).
	allTransactions addAll: (self allTheTransactionsOf: accounts).
	^allTransactions ! !


!Portfolio methodsFor: 'initialize' stamp: 'eaam 10/10/2023 15:03:44'!
initialize 
	accounts := OrderedCollection new.
	portfolios := OrderedCollection new.! !


!Portfolio methodsFor: 'testing' stamp: 'eaam 10/11/2023 14:30:33'!
hasRegistered: aDeposit 
	^(self hasRegistered: aDeposit in: accounts) or: (self hasRegistered: aDeposit in: portfolios ).! !

!Portfolio methodsFor: 'testing' stamp: 'eaam 10/11/2023 14:29:49'!
hasRegistered: aDeposit in: aCollectionOfFinancialAssets
	^(aCollectionOfFinancialAssets anySatisfy: [:aReceptiveAccount | aReceptiveAccount hasRegistered: aDeposit])! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
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
