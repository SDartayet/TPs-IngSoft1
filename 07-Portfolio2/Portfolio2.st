!classDefinition: #AccountNetTransferTests category: 'Portfolio2-Tests'!
TestCase subclass: #AccountNetTransferTests
	instanceVariableNames: 'zeroNetTransferReport report account sendingAccount receivingAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Tests'!

!AccountNetTransferTests methodsFor: 'tests' stamp: 'Sof D 10/25/2023 02:01:19'!
test01NetTransferReportStartsReportingZero

	self assert: report content equals: zeroNetTransferReport ! !

!AccountNetTransferTests methodsFor: 'tests' stamp: 'Sof D 10/25/2023 02:00:23'!
test02NetTransferReportChangesForIncomingTransfer
	| netTransfer reportForReceivingAccount|
	sendingAccount := ReceptiveAccount new.
	receivingAccount := ReceptiveAccount new.
	netTransfer := 'Neto de transferencias: 1'.
	Transfer from: sendingAccount to: receivingAccount amount: 1.
	reportForReceivingAccount := AccountNetTransferReport for: receivingAccount .
	self assert: reportForReceivingAccount content equals: netTransfer! !

!AccountNetTransferTests methodsFor: 'tests' stamp: 'Sof D 10/25/2023 02:00:37'!
test03NetTransferReportChangesForOutgoingTransfer
	| netTransfer reportForSendingAccount|
	sendingAccount := ReceptiveAccount new.
	receivingAccount := ReceptiveAccount new.
	netTransfer := 'Neto de transferencias: -1'.
	Transfer from: sendingAccount to: receivingAccount amount: 1.
	reportForSendingAccount := AccountNetTransferReport for: sendingAccount .
	self assert: reportForSendingAccount content equals: netTransfer! !

!AccountNetTransferTests methodsFor: 'tests' stamp: 'Sof D 10/25/2023 02:01:19'!
test04NetTransferReportDoesntChangeForDeposit

	Deposit register: 1 on: account .
	self assert: report content equals: zeroNetTransferReport ! !

!AccountNetTransferTests methodsFor: 'tests' stamp: 'Sof D 10/25/2023 02:01:19'!
test05NetTransferReportDoesntChangeForWithdraw

	Withdraw register: 1 on: account .
	report := AccountNetTransferReport for: account .
	self assert: report content equals: zeroNetTransferReport ! !

!AccountNetTransferTests methodsFor: 'tests' stamp: 'Sof D 10/25/2023 02:01:13'!
test06NetTransferReportIsCorrectOnAccountWithMultipleTransactions
	| account1 account2 netTransfer reportForAccount2|
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	netTransfer := 'Neto de transferencias: 1'.
	Transfer from: account1 to: account2 amount: 2.
	Transfer from: account2 to: account1 amount: 1.
	Withdraw register: 100 on: account2 .
	Deposit register: 500 on: account2 .
	reportForAccount2 := AccountNetTransferReport for: account2 .
	self assert: reportForAccount2 content equals: netTransfer! !


!AccountNetTransferTests methodsFor: 'as yet unclassified' stamp: 'Sof D 10/25/2023 02:01:19'!
setUp

	account := ReceptiveAccount new.
	sendingAccount := ReceptiveAccount new.
	receivingAccount := ReceptiveAccount new.
	
	report := AccountNetTransferReport for: account	.
	
	zeroNetTransferReport := 'Neto de transferencias: 0'.
! !


!classDefinition: #AccountSummaryTests category: 'Portfolio2-Tests'!
TestCase subclass: #AccountSummaryTests
	instanceVariableNames: 'account sendingAccount receivingAccount summary report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Tests'!

!AccountSummaryTests methodsFor: 'tests' stamp: 'Sof D 10/25/2023 01:52:51'!
test01SummaryOfNewAccountReportsZeroBalance
	
	
	summary add: 'Balance = 0'.
	report summary.
	self assert: report content equals: summary! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'Sof D 10/25/2023 01:53:16'!
test02SummaryReportsDepositCorrectly
	
	Deposit register: 10 on: account.
	summary add: 'Depósito por 10'.
	summary add: 'Balance = 10'.
	report summary.
	self assert: report content equals: summary! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'Sof D 10/25/2023 01:53:16'!
test03SummaryReportsWithdrawalCorrectly
	
	Withdraw register: 10 on: account. 
	summary add: 'Extracción por 10'.
	summary add: 'Balance = -10'.
	report summary.
	self assert: report content equals: summary! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'Sof D 10/25/2023 02:08:35'!
test04SummaryReportsOutgoingTransferCorrectly
	
	
	Transfer from: sendingAccount to: receivingAccount amount: 1.
	report := AccountSummaryReport for: sendingAccount.
	summary add: 'Salida por transferencia de 1'.
	summary add: 'Balance = -1'.
	report summary.
	self assert: report content equals: summary! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'Sof D 10/25/2023 02:08:35'!
test05SummaryReportsIncomingTransferCorrectly
	
	Transfer from: sendingAccount to: receivingAccount amount: 1.
	report := AccountSummaryReport for: receivingAccount.
	summary add: 'Entrada por transferencia de 1'.
	summary add: 'Balance = 1'.
	report summary.
	self assert: report content equals: summary! !

!AccountSummaryTests methodsFor: 'tests' stamp: 'Sof D 10/25/2023 01:53:16'!
test06SummaryReportsMultipleTransactionsCorrectly
	
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account. 
	summary add: 'Depósito por 100'.
	summary add: 'Extracción por 50'.
	summary add: 'Balance = 50'.
	report summary.
	self assert: report content equals: summary! !


!AccountSummaryTests methodsFor: 'setup' stamp: 'Sof D 10/25/2023 02:08:35'!
setUp 
	account := ReceptiveAccount new.
	sendingAccount := ReceptiveAccount new.
	receivingAccount := ReceptiveAccount new.
	
	summary := OrderedCollection new.
	report := AccountSummaryReport for: account.! !


!classDefinition: #PortfolioReportTest category: 'Portfolio2-Tests'!
TestCase subclass: #PortfolioReportTest
	instanceVariableNames: 'report portfolio aChildPortfolio aComposedChildPotfolio expectedReport account anotherAccount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Tests'!

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'eaam 10/25/2023 14:28:26'!
setUp
	portfolio := Portfolio named: 'Portfolio de Hernan'.
	aChildPortfolio := Portfolio named: 'Portfolio de Kent'.
	
	report := PortfolioReport for: portfolio .
	
	expectedReport := OrderedCollection new.
	
	account := ReceptiveAccount named: 'Cuenta de Nico'.
	anotherAccount := ReceptiveAccount named: 'Cuenta de Chris'.
	
	aComposedChildPotfolio := Portfolio named: 'Portfolio de ferrari' with: account with: anotherAccount.! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'Sof D 10/25/2023 02:14:15'!
test01PortfolioReportPrintsPortfoliosName
	
	expectedReport add: 'Portfolio de Hernan'.
	
	self assert: report content equals: expectedReport ! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'Sof D 10/25/2023 02:14:38'!
test02PortfolioReportPrintsItsAccountsName
	
	expectedReport add: 'Portfolio de Hernan'.
	expectedReport add: '   Cuenta de Nico'.
	
	portfolio add: account.
	
	
	self assert: report content equals: expectedReport ! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'Sof D 10/25/2023 02:27:45'!
test03PortfolioReportPrintsMultipleAccountsName
	
	expectedReport add: 'Portfolio de Hernan'.
	expectedReport add: '   Cuenta de Nico'.
	expectedReport add: '   Cuenta de Chris'.
	
	portfolio add: account.
	portfolio add: anotherAccount .
	
	
	self assert: report content equals: expectedReport ! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'eaam 10/25/2023 14:27:21'!
test04PortfolioReportPrintsItsPortfoliosNames
	
	expectedReport add: 'Portfolio de Hernan'.
	expectedReport add: '   Portfolio de Kent'.
	
	portfolio add: aChildPortfolio .
	
	
	self assert: report content equals: expectedReport ! !

!PortfolioReportTest methodsFor: 'as yet unclassified' stamp: 'eaam 10/25/2023 14:28:39'!
test05PortfolioReportPrintsAComposedPortfolio

	expectedReport add: 'Portfolio de Hernan'.
	expectedReport add: '   Portfolio para ferrari'.
	expectedReport add: '      Cuenta de Nico'.
	expectedReport add: '      Cuenta de Chris'.
	portfolio add: aComposedChildPotfolio.
	
	
	self assert: report content equals: expectedReport ! !


!classDefinition: #PortfolioTest category: 'Portfolio2-Tests'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Tests'!

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

!PortfolioTest methodsFor: 'tests' stamp: 'eaam 10/24/2023 16:10:24'!
test16PortfolioCanBeInitializedWithName

	| portfolioToName |
	
	portfolioToName := Portfolio named: 'Porfolio de Robute'.
	
	self assert: portfolioToName accountName equals: 'Porfolio de Robute'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'eaam 10/24/2023 17:00:25'!
test17PortfolioCanBeInitializedWithANameAndTwoAccounts

	| portfolioToName accountToAdd anotherAccountToAdd|
	
	accountToAdd := ReceptiveAccount named: 'Cuenta de Trazyn'.
	anotherAccountToAdd := ReceptiveAccount named: 'Cuenta de Krispekh'.
	portfolioToName := Portfolio named: 'Porfolio de Trazyn' with: accountToAdd with: anotherAccountToAdd.
	
	self assert: (portfolioToName isComposedBy: accountToAdd).
	self assert: (portfolioToName isComposedBy: anotherAccountToAdd).! !

!PortfolioTest methodsFor: 'tests' stamp: 'eaam 10/24/2023 17:01:11'!
test18PortfolioCanBeInitializedWithANameAndTwoAccounts

	| portfolioToName accountToAdd anotherAccountToAdd|
	
	accountToAdd := ReceptiveAccount named: 'Cuenta de Trazyn'.
	anotherAccountToAdd := ReceptiveAccount named: 'Cuenta de Krispekh'.
	portfolioToName := Portfolio named: 'Porfolio de Trazyn' with: accountToAdd with: anotherAccountToAdd.
	
	self assert: portfolioToName accountName equals: 'Porfolio de Trazyn'.! !

!PortfolioTest methodsFor: 'tests' stamp: 'eaam 10/24/2023 17:02:16'!
test19PortfolioCanBeInitializedWithANameAAccountAndAPortfolio

	| portfolioToName accountToAdd portfolioToAdd|
	
	accountToAdd := ReceptiveAccount named: 'Cuenta de Trazyn'.
	portfolioToAdd := Portfolio named: 'Portfolio de Krispekh'.
	portfolioToName := Portfolio named: 'Porfolio de Trazyn' with: accountToAdd with: portfolioToAdd.
	
	self assert: (portfolioToName isComposedBy: portfolioToAdd).! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio2-Tests'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Tests'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'eaam 10/24/2023 15:59:33'!
test08AccountCanInitializeWithName

	| account1 |
	
	account1 := ReceptiveAccount named: 'Cuenta de leo'.
		
	self assert: account1 accountName equals: 'Cuenta de leo'.! !


!classDefinition: #TransferTest category: 'Portfolio2-Tests'!
TestCase subclass: #TransferTest
	instanceVariableNames: 'account1 account2 transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Tests'!

!TransferTest methodsFor: 'setup' stamp: 'Sof D 10/24/2023 02:27:18'!
setUp

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer from: account1 to: account2 amount: 1! !


!TransferTest methodsFor: 'tests' stamp: 'Sof D 10/24/2023 02:27:18'!
test01TransferToLegHasReceivingAccount
	
		
	self assert: (transfer to) equals: account2 transactions first .
! !

!TransferTest methodsFor: 'tests' stamp: 'Sof D 10/24/2023 02:27:18'!
test02TransferFromLegHasSendingAccount
		
	self assert: (transfer from) equals: account1 transactions first.
! !

!TransferTest methodsFor: 'tests' stamp: 'Sof D 10/24/2023 02:27:18'!
test03FromLegCanAccessItsTransfer

		
	self assert: (transfer from) transfer equals: transfer.
! !

!TransferTest methodsFor: 'tests' stamp: 'Sof D 10/24/2023 02:27:18'!
test04ToLegCanAccessItsTransfer
		
	self assert: (transfer to) transfer equals: transfer.
! !

!TransferTest methodsFor: 'tests' stamp: 'Sof D 10/24/2023 02:27:18'!
test05ToLegCanAccessFromLegOfItsTransfer
		
	self assert: (transfer to) from equals: (transfer from).
! !

!TransferTest methodsFor: 'tests' stamp: 'Sof D 10/24/2023 02:27:18'!
test06FromLegCanAccessToLegOfItsTransfer
		
	self assert: (transfer from) to equals: (transfer to).
! !

!TransferTest methodsFor: 'tests' stamp: 'Sof D 10/24/2023 02:27:11'!
test07TransferOfAmountZeroIsntAllowed
	
	self should: [Transfer from: account1 to: account2 amount: 0. ]

	raise: Error

	withMessageText: Transfer cantTransferZeroErrorDescription.! !

!TransferTest methodsFor: 'tests' stamp: 'Sof D 10/24/2023 02:27:06'!
test08TransferFromAccountToItselfIsntAllowed

	self should: [Transfer from: account1 to: account1 amount: 1. . ]

	raise: Error

	withMessageText: Transfer cantTransferToItselfErrorDescription.! !

!TransferTest methodsFor: 'tests' stamp: 'eaam 10/24/2023 15:43:55'!
test09TransferChangesAccountsBalance

	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new..
	
	Transfer from: account1 to: account2 amount: 1.
		
	self assert: -1 equals: account1 balance .
	self assert: 1 equals: account2 balance .
! !

!TransferTest methodsFor: 'tests' stamp: 'eaam 10/24/2023 15:44:40'!
test10transferIsRegistered

	
	account1 := ReceptiveAccount new.
	
	account2 := ReceptiveAccount new.
	
	transfer := Transfer from: account1 to: account2 amount: 1.
		
	self assert: (account1 hasRegistered: transfer from).
	self assert:  (account2 hasRegistered: transfer to).
! !
!classDefinition: #Account category: 'Portfolio2-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

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


!classDefinition: #Portfolio category: 'Portfolio2-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents accountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

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

!Portfolio methodsFor: 'initialization' stamp: 'eaam 10/24/2023 16:26:59'!
setName: aAccountName 
	accountName := aAccountName.! !


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


!Portfolio methodsFor: 'testing' stamp: 'eaam 10/24/2023 16:38:02'!
accountName
	^accountName ! !

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


!Portfolio methodsFor: 'report generation' stamp: 'Sof D 10/25/2023 02:28:20'!
processAccountsForReport: aReportToGenerate
	aReportToGenerate reportProcessPortfolio: self.
	accounts do: [ : anAccount | aReportToGenerate reportProcessAccount: anAccount ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio2-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error description' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !


!Portfolio class methodsFor: 'initialize' stamp: 'eaam 10/24/2023 16:26:39'!
named: aAccountName 
	^self new setName: aAccountName.! !

!Portfolio class methodsFor: 'initialize' stamp: 'eaam 10/24/2023 16:26:30'!
named: aAccountName with: anAccount with: anotherAccount
	^self new 
		setName: aAccountName;
		add: anAccount;
		add: anotherAccount;
		yourself! !

!Portfolio class methodsFor: 'initialize' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'initialize' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio2-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions accountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'eaam 10/24/2023 16:25:08'!
setName: aAccountName
	accountName := aAccountName.! !


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


!ReceptiveAccount methodsFor: 'testing' stamp: 'eaam 10/24/2023 15:56:23'!
accountName
	^accountName! !

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


!ReceptiveAccount methodsFor: 'sumaryReport' stamp: 'Sof D 10/25/2023 01:24:43'!
processTransactionsForReport: aReportToGenerate
	transactions do: [:aTransaction | aTransaction sendToReport: aReportToGenerate]
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio2-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'initialize' stamp: 'eaam 10/24/2023 16:24:54'!
named: aAccountName
	^self new setName: aAccountName.! !


!classDefinition: #AccountReport category: 'Portfolio2-Ejercicio'!
Object subclass: #AccountReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountReport methodsFor: 'content' stamp: 'Sof D 10/25/2023 01:26:10'!
content
	self subclassResponsibility ! !


!AccountReport methodsFor: 'transaction reporting' stamp: 'Sof D 10/25/2023 01:26:55'!
reportProcessesDeposit: aDepositToReportOn 
	self subclassResponsibility ! !

!AccountReport methodsFor: 'transaction reporting' stamp: 'Sof D 10/25/2023 01:31:20'!
reportProcessesIncomingTransfer: anIncomingTransferToReportOn
	self subclassResponsibility ! !

!AccountReport methodsFor: 'transaction reporting' stamp: 'Sof D 10/25/2023 01:29:04'!
reportProcessesOutgoingTransfer: anOutgoingTransferToReportOn 
	self subclassResponsibility ! !

!AccountReport methodsFor: 'transaction reporting' stamp: 'Sof D 10/25/2023 01:28:23'!
reportProcessesWithdraw: aWithdrawToReportOn
	self subclassResponsibility ! !


!classDefinition: #AccountNetTransferReport category: 'Portfolio2-Ejercicio'!
AccountReport subclass: #AccountNetTransferReport
	instanceVariableNames: 'account amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountNetTransferReport methodsFor: 'content' stamp: 'Sof D 10/25/2023 01:27:45'!
content
	
	account processTransactionsForReport: self.
	
	^'Neto de transferencias: ', amount asString! !


!AccountNetTransferReport methodsFor: 'transaction reporting' stamp: 'Sof D 10/25/2023 01:27:05'!
reportProcessesDeposit: aDepositToReportOn 
	! !

!AccountNetTransferReport methodsFor: 'transaction reporting' stamp: 'Sof D 10/25/2023 01:30:23'!
reportProcessesIncomingTransfer: anIncomingTransferToReportOn
	amount := amount + anIncomingTransferToReportOn value! !

!AccountNetTransferReport methodsFor: 'transaction reporting' stamp: 'Sof D 10/25/2023 01:29:16'!
reportProcessesOutgoingTransfer: anOutgoingTransferToReportOn 
	amount := amount - anOutgoingTransferToReportOn value! !

!AccountNetTransferReport methodsFor: 'transaction reporting' stamp: 'Sof D 10/25/2023 01:28:16'!
reportProcessesWithdraw: aWithdrawToReportOn
! !


!AccountNetTransferReport methodsFor: 'initialization' stamp: 'Sof D 10/25/2023 01:27:13'!
with: anAccountToReportOn
	
	account := anAccountToReportOn .
	amount := 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountNetTransferReport class' category: 'Portfolio2-Ejercicio'!
AccountNetTransferReport class
	instanceVariableNames: ''!

!AccountNetTransferReport class methodsFor: 'instance creation' stamp: 'Sof D 10/25/2023 02:09:02'!
for: anAccountToReportOn

	^self new with: anAccountToReportOn ! !


!classDefinition: #AccountSummaryReport category: 'Portfolio2-Ejercicio'!
AccountReport subclass: #AccountSummaryReport
	instanceVariableNames: 'account accountSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountSummaryReport methodsFor: 'initialization' stamp: 'Sof D 10/25/2023 02:08:54'!
with: aAccount
	account := aAccount.
	accountSummary := OrderedCollection new.! !


!AccountSummaryReport methodsFor: 'contents' stamp: 'eaam 10/23/2023 01:57:39'!
content
	^accountSummary! !

!AccountSummaryReport methodsFor: 'contents' stamp: 'Sof D 10/25/2023 01:24:38'!
summary
	account processTransactionsForReport: self.
	accountSummary add: ('Balance = ', account balance asString).! !


!AccountSummaryReport methodsFor: 'transaction reporting' stamp: 'Sof D 10/25/2023 01:26:47'!
reportProcessesDeposit: aDepositToReportOn 
	accountSummary add: ('Depósito por ', aDepositToReportOn value asString).! !

!AccountSummaryReport methodsFor: 'transaction reporting' stamp: 'Sof D 10/25/2023 01:29:44'!
reportProcessesIncomingTransfer: anIncomingTransferToReportOn 
	accountSummary add: ('Entrada por transferencia de ', anIncomingTransferToReportOn value asString).! !

!AccountSummaryReport methodsFor: 'transaction reporting' stamp: 'Sof D 10/25/2023 01:28:56'!
reportProcessesOutgoingTransfer: anOutgoingTransferToReportOn 
	accountSummary add: ('Salida por transferencia de ', anOutgoingTransferToReportOn value asString).! !

!AccountSummaryReport methodsFor: 'transaction reporting' stamp: 'Sof D 10/25/2023 01:28:12'!
reportProcessesWithdraw: aWithdrawToReportOn 
	accountSummary add: ('Extracción por ', aWithdrawToReportOn value asString).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryReport class' category: 'Portfolio2-Ejercicio'!
AccountSummaryReport class
	instanceVariableNames: ''!

!AccountSummaryReport class methodsFor: 'instance creation' stamp: 'Sof D 10/25/2023 02:08:54'!
for: aAccount
	^self new with: aAccount! !


!classDefinition: #AccountTransaction category: 'Portfolio2-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'balance' stamp: 'Sof D 10/25/2023 01:24:18'!
sendToReport: aReport

	self subclassResponsibility! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'Sof D 10/24/2023 15:13:55'!
affectNetTransferAmount: anAmountToAddTo
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio2-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio2-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'Sof D 10/25/2023 01:32:57'!
value

	^ value copy! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'print' stamp: 'Sof D 10/25/2023 01:26:36'!
sendToReport: aReport
	aReport reportProcessesDeposit: value! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'Sof D 10/24/2023 15:14:12'!
affectNetTransferAmount: anAmountToAddTo
	^anAmountToAddTo ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio2-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #IncomingLegTransfer category: 'Portfolio2-Ejercicio'!
AccountTransaction subclass: #IncomingLegTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!IncomingLegTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/20/2023 13:50:22'!
affectBalance: aBalance

	^aBalance + transfer value ! !

!IncomingLegTransfer methodsFor: 'as yet unclassified' stamp: 'Sof D 10/24/2023 15:14:47'!
affectNetTransferAmount: anAmountToAddTo
	^anAmountToAddTo + transfer value! !

!IncomingLegTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/20/2023 13:52:42'!
initializeFor: aTransfer

	transfer := aTransfer ! !

!IncomingLegTransfer methodsFor: 'as yet unclassified' stamp: 'Sof D 10/25/2023 01:29:31'!
sendToReport: aReport 
	aReport reportProcessesIncomingTransfer: self value! !

!IncomingLegTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/21/2023 00:52:13'!
transfer
	^transfer! !

!IncomingLegTransfer methodsFor: 'as yet unclassified' stamp: 'Sof D 10/25/2023 01:33:02'!
value 

	^transfer value copy! !


!IncomingLegTransfer methodsFor: 'category-name' stamp: 'eaam 10/22/2023 23:51:55'!
from
	^transfer from.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IncomingLegTransfer class' category: 'Portfolio2-Ejercicio'!
IncomingLegTransfer class
	instanceVariableNames: ''!

!IncomingLegTransfer class methodsFor: 'nil' stamp: 'eaam 10/20/2023 13:51:41'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !


!classDefinition: #OutgoingLegTransfer category: 'Portfolio2-Ejercicio'!
AccountTransaction subclass: #OutgoingLegTransfer
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!OutgoingLegTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/20/2023 13:52:52'!
affectBalance: aBalance

	^aBalance - transfer value ! !

!OutgoingLegTransfer methodsFor: 'as yet unclassified' stamp: 'Sof D 10/24/2023 15:14:57'!
affectNetTransferAmount: anAmountToAddTo
	^anAmountToAddTo - transfer value! !

!OutgoingLegTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/20/2023 13:52:46'!
initializeFor: aTransfer

	transfer := aTransfer ! !

!OutgoingLegTransfer methodsFor: 'as yet unclassified' stamp: 'Sof D 10/25/2023 01:28:42'!
sendToReport: aReport 
	aReport reportProcessesOutgoingTransfer: self value! !

!OutgoingLegTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/22/2023 23:52:32'!
to
	^transfer to.! !

!OutgoingLegTransfer methodsFor: 'as yet unclassified' stamp: 'eaam 10/22/2023 23:50:45'!
transfer
	^transfer ! !

!OutgoingLegTransfer methodsFor: 'as yet unclassified' stamp: 'Sof D 10/25/2023 01:33:08'!
value 

	^transfer value copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OutgoingLegTransfer class' category: 'Portfolio2-Ejercicio'!
OutgoingLegTransfer class
	instanceVariableNames: ''!

!OutgoingLegTransfer class methodsFor: 'as yet unclassified' stamp: 'eaam 10/20/2023 13:51:45'!
for: aTransfer

	^ self new initializeFor: aTransfer ! !


!classDefinition: #Withdraw category: 'Portfolio2-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'Sof D 10/25/2023 01:33:20'!
value

	^ value copy! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'print' stamp: 'Sof D 10/25/2023 01:28:00'!
sendToReport: aReport
	aReport reportProcessesWithdraw: value! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio2-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #PortfolioReport category: 'Portfolio2-Ejercicio'!
Object subclass: #PortfolioReport
	instanceVariableNames: 'portfolio content timesToTab'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

!PortfolioReport methodsFor: 'initialization' stamp: 'Sof D 10/25/2023 02:22:12'!
with: aPortfolioToReportAbout 
	portfolio := aPortfolioToReportAbout .
	content := OrderedCollection new.! !


!PortfolioReport methodsFor: 'content' stamp: 'Sof D 10/25/2023 02:22:46'!
content
	portfolio processAccountsForReport: self.
	^content ! !


!PortfolioReport methodsFor: 'as yet unclassified' stamp: 'Sof D 10/25/2023 02:25:03'!
reportProcessAccount: anAccountToReportOn

	content add: ('   ', (anAccountToReportOn accountName) asString )! !

!PortfolioReport methodsFor: 'as yet unclassified' stamp: 'Sof D 10/25/2023 02:20:24'!
reportProcessPortfolio: aPortfolioToReportOn

	content add: aPortfolioToReportOn accountName ! !

!PortfolioReport methodsFor: 'as yet unclassified' stamp: 'eaam 10/25/2023 15:33:49'!
tabulation
	| tabulation |
	tabulation := ''.
	timesToTab timesRepeat: [tabulation := tabulation, String tab].
	^tabulation! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioReport class' category: 'Portfolio2-Ejercicio'!
PortfolioReport class
	instanceVariableNames: ''!

!PortfolioReport class methodsFor: 'instance creation' stamp: 'Sof D 10/25/2023 02:06:17'!
for: aPortfolioToReportAbout 

	^self new with: aPortfolioToReportAbout ! !


!classDefinition: #Transfer category: 'Portfolio2-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value from to'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio2-Ejercicio'!

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


!Transfer methodsFor: 'category-name' stamp: 'eaam 10/20/2023 14:35:18'!
from
	
	^from! !

!Transfer methodsFor: 'category-name' stamp: 'Sof D 10/25/2023 01:24:18'!
sendToReport: aReport! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio2-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'initialize' stamp: 'eaam 10/23/2023 21:45:25'!
from: aAccountToTransferFrom to: aAccountToTransferTo amount: aAmountToTransfer
	| transfer outgoingTransfer incomingTransfer |
	
	self shouldTransfer: aAmountToTransfer to: aAccountToTransferTo from: aAccountToTransferFrom.
	
	transfer := self new.
	
	outgoingTransfer := OutgoingLegTransfer register: transfer on: aAccountToTransferFrom.
	incomingTransfer := IncomingLegTransfer register: transfer on: aAccountToTransferTo.
	
	transfer initializeFrom: outgoingTransfer to: incomingTransfer forAmount: aAmountToTransfer.

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
