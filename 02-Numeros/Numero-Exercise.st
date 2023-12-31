!classDefinition: #NumeroTest category: 'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 4/15/2021 16:45:35'!
test27EnteroSubstractsEnteroCorrectly

	self assert: four - one equals: three! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: 'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: 'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:02'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero!!!!!!'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/15/2021 16:42:09'!
invalidNumberTypeErrorDescription
	
	^ 'Tipo de número inválido!!!!!!'! !


!classDefinition: #Entero category: 'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations' stamp: 'Sof D 9/10/2023 01:33:27'!
* aMultiplier 
	
	^aMultiplier multiplyWithEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Sof D 9/10/2023 01:09:29'!
+ anAdder 
	
	^anAdder sumWithEntero: self
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Sof D 9/10/2023 01:58:42'!
- aSubtrahend 
	
	^ aSubtrahend subtractToEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Sof D 9/10/2023 01:51:09'!
/ aDivisor 
	
	^aDivisor divideEntero: self! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Sof D 9/11/2023 21:27:01'!
// aDivisor 
	
	^self class with: self integerValue // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Sof D 9/10/2023 00:53:52'!
fibonacci

	"| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	self isNegative ifTrue: [self error: Entero negativeFibonacciErrorDescription ].	
	(self isZero or: [self isOne]) ifTrue: [^one].
	
	^ (self - one) fibonacci + (self - two) fibonacci"
	^self subclassResponsibility 
		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Sof D 9/11/2023 21:27:25'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: ((self integerValue) gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'Sof D 9/11/2023 21:26:53'!
= anObject

	^(anObject isKindOf: self class) and: [ self integerValue = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'Sof D 9/11/2023 21:25:30'!
hash

	^self integerValue hash! !



!Entero methodsFor: 'value' stamp: 'Sof D 9/11/2023 21:30:48'!
integerValue
	^self subclassResponsibility ! !


!Entero methodsFor: 'printing' stamp: 'Sof D 9/11/2023 21:25:00'!
printOn: aStream

	aStream print: self integerValue ! !


!Entero methodsFor: 'testing' stamp: 'Sof D 9/11/2023 21:11:23'!
canBeValidDenominator
! !

!Entero methodsFor: 'testing' stamp: 'Sof D 9/11/2023 21:11:29'!
canBeValidNumerator
! !

!Entero methodsFor: 'testing' stamp: 'Sof D 9/11/2023 21:22:00'!
isOne
	
	^false! !

!Entero methodsFor: 'testing' stamp: 'Sof D 9/11/2023 21:22:05'!
isZero
	
	^false! !


!Entero methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/11/2023 20:36:28'!
divideEntero: anEnteroDividend
	^Fraccion with: anEnteroDividend over: self
! !

!Entero methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/11/2023 20:36:22'!
divideFraccion: aFraccionDividend
	^aFraccionDividend numerator / (self * aFraccionDividend denominator )
! !

!Entero methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/11/2023 21:25:11'!
multiplyWithEntero: anEnteroMultiplier
	^self class with: self integerValue * anEnteroMultiplier integerValue! !

!Entero methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/10/2023 01:31:34'!
multiplyWithFraccion: aFraccionMultiplier
	
	
	^aFraccionMultiplier multiplyWithEntero: self! !

!Entero methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/11/2023 21:55:41'!
subtractToEntero: anEnteroMinuend
	^self class with:  (anEnteroMinuend integerValue - self integerValue)! !

!Entero methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/11/2023 21:55:50'!
subtractToFraccion: aFraccionMinuend
	| newNumerator newDenominator|
	
	newNumerator := aFraccionMinuend numerator - aFraccionMinuend denominator * self.
	newDenominator  := aFraccionMinuend denominator * self.
	
	^newNumerator / newDenominator 
! !

!Entero methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/11/2023 21:24:30'!
sumWithEntero: anAdderEntero
	^self class with: self integerValue + anAdderEntero integerValue ! !

!Entero methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/10/2023 01:23:17'!
sumWithFraccion: anAdderFraccion
	^anAdderFraccion sumWithEntero: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: 'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/15/2021 16:42:24'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos!!!!!!'! !

!Entero class methodsFor: 'instance creation' stamp: 'Sof D 9/11/2023 21:28:43'!
with: aValue 
	
	"Esta verificacion esta puesta por si se equivocan y quieren crear un Entero pasando otra cosa que un Integer - Hernan"
	aValue isInteger ifFalse: [  self error: 'aValue debe ser anInteger' ].
	
	aValue = 0 ifTrue: [ ^Cero new ].
	aValue = 1 ifTrue: [ ^Uno new ].
	aValue < 0 ifTrue: [ ^Negativo new initializeWith: aValue ].
	
	^MayorAUno new initalizeWith: aValue! !


!classDefinition: #Natural category: 'Numero-Exercise'!
Entero subclass: #Natural
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Natural methodsFor: 'aritmetic operations' stamp: 'Sof D 9/11/2023 20:24:58'!
fibonacci
	^self subclassResponsibility ! !


!Natural methodsFor: 'testing' stamp: 'Sof D 9/11/2023 21:23:14'!
isNegative
	^false! !


!classDefinition: #Cero category: 'Numero-Exercise'!
Natural subclass: #Cero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Cero methodsFor: 'arithmetic operations' stamp: 'Sof D 9/11/2023 20:24:21'!
fibonacci
	^Entero with: 1! !


!Cero methodsFor: 'value' stamp: 'Sof D 9/11/2023 21:15:13'!
integerValue
	^0! !


!Cero methodsFor: 'testing' stamp: 'Sof D 9/11/2023 21:04:24'!
canBeValidNumerator
	^self error: self class zeroCantBeAValidNumeratorError! !

!Cero methodsFor: 'testing' stamp: 'Sof D 9/11/2023 21:21:48'!
isZero
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cero class' category: 'Numero-Exercise'!
Cero class
	instanceVariableNames: ''!

!Cero class methodsFor: 'as yet unclassified' stamp: 'Sof D 9/11/2023 21:05:17'!
zeroCantBeAValidNumeratorError
	^'una fraccion no puede ser cero'! !


!classDefinition: #MayorAUno category: 'Numero-Exercise'!
Natural subclass: #MayorAUno
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!MayorAUno methodsFor: 'arithmetic operations' stamp: 'Sof D 9/11/2023 20:25:11'!
fibonacci
	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci! !


!MayorAUno methodsFor: 'value' stamp: 'Sof D 9/11/2023 21:29:17'!
integerValue
	^value! !


!MayorAUno methodsFor: 'initialization' stamp: 'Sof D 9/11/2023 21:31:27'!
initalizeWith: aValue
	value := aValue ! !

!MayorAUno methodsFor: 'initialization' stamp: 'Sof D 9/11/2023 21:29:31'!
initializeWith: aValue
	value := aValue ! !


!classDefinition: #Uno category: 'Numero-Exercise'!
Natural subclass: #Uno
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Uno methodsFor: 'value' stamp: 'Sof D 9/11/2023 21:15:21'!
integerValue
	^1! !


!Uno methodsFor: 'arithmetic operations' stamp: 'Sof D 9/11/2023 20:34:32'!
fibonacci
	^Entero with: 1! !


!Uno methodsFor: 'testing' stamp: 'Sof D 9/11/2023 21:13:43'!
canBeValidDenominator
	^self error: self class fraccionWithUnoIsAnEnteroError! !

!Uno methodsFor: 'testing' stamp: 'Sof D 9/11/2023 21:21:41'!
isOne
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Uno class' category: 'Numero-Exercise'!
Uno class
	instanceVariableNames: ''!

!Uno class methodsFor: 'as yet unclassified' stamp: 'Sof D 9/11/2023 21:14:18'!
fraccionWithUnoIsAnEnteroError

	^'una fraccion no puede tener denominador 1 porque sino es un entero'! !


!classDefinition: #Negativo category: 'Numero-Exercise'!
Entero subclass: #Negativo
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negativo methodsFor: 'testing' stamp: 'Sof D 9/11/2023 21:03:17'!
canBeValidDenominator
	! !

!Negativo methodsFor: 'testing' stamp: 'Sof D 9/11/2023 21:03:10'!
canBeValidNumerator
	! !

!Negativo methodsFor: 'testing' stamp: 'Sof D 9/11/2023 21:23:03'!
isNegative
	^true! !


!Negativo methodsFor: 'initialization' stamp: 'Sof D 9/11/2023 21:31:32'!
initalizeWith: aValue
	value := aValue ! !

!Negativo methodsFor: 'initialization' stamp: 'Sof D 9/11/2023 21:29:57'!
initializeWith: aValue
	value := aValue ! !


!Negativo methodsFor: 'value' stamp: 'Sof D 9/11/2023 21:29:43'!
integerValue
	^value! !


!Negativo methodsFor: 'arithmetic operations' stamp: 'Sof D 9/11/2023 21:11:44'!
fibonacci
	^self error: super class negativeFibonacciErrorDescription ! !


!classDefinition: #Fraccion category: 'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Sof D 9/10/2023 01:33:37'!
* aMultiplier 
	
	^aMultiplier multiplyWithFraccion: self
	! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Sof D 9/10/2023 01:09:13'!
+ anAdder 
	
	^anAdder sumWithFraccion: self! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Sof D 9/10/2023 02:03:15'!
- aSubtrahend 
	
	^aSubtrahend subtractToFraccion: self
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'Sof D 9/10/2023 01:49:59'!
/ aDivisor 
	
	^aDivisor divideFraccion: self! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'Sof D 9/11/2023 21:20:00'!
initializeWith: aNumerator over: aDenominator

	"Estas precondiciones estan por si se comenten errores en la implementacion - Hernan"
	aNumerator canBeValidNumerator .
	aDenominator canBeValidDenominator .
	
	numerator := aNumerator.
	denominator := aDenominator ! !


!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !


!Fraccion methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/11/2023 20:36:48'!
divideEntero: anEnteroDividend
	^(anEnteroDividend * denominator) / numerator! !

!Fraccion methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/11/2023 20:16:58'!
divideFraccion: aFraccionDividend
	^(denominator * aFraccionDividend numerator ) / (numerator * aFraccionDividend denominator )! !

!Fraccion methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/10/2023 01:36:07'!
multiplyWithEntero: anEnteroMultiplier
	^((numerator * anEnteroMultiplier ) / denominator)! !

!Fraccion methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/10/2023 01:31:22'!
multiplyWithFraccion: aFraccionMultiplier
		^(numerator * aFraccionMultiplier numerator) / (denominator * aFraccionMultiplier denominator)! !

!Fraccion methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/11/2023 21:56:17'!
subtractToEntero: anEnteroMinuend
	| newNumerator newDenominator|
	
	newNumerator := denominator * anEnteroMinuend - numerator.
	newDenominator  := denominator * anEnteroMinuend.
	
	^newNumerator / newDenominator 

! !

!Fraccion methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/11/2023 21:56:26'!
subtractToFraccion: aFraccionMinuend
	| newNumerator newDenominator |
	
	newNumerator :=(denominator * aFraccionMinuend numerator)- (numerator * aFraccionMinuend denominator).
	newDenominator := denominator * aFraccionMinuend denominator.
	
	^newNumerator / newDenominator 
! !

!Fraccion methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/10/2023 01:22:59'!
sumWithEntero: anAdderEntero
	
	| newNumerador |
	
	newNumerador := numerator +  denominator * anAdderEntero.

	
	^newNumerador /  denominator ! !

!Fraccion methodsFor: 'arithmetic auxiliaries' stamp: 'Sof D 9/10/2023 01:06:41'!
sumWithFraccion: anAdderFraccion	
	| newNumerator newDenominator |
	
	newNumerator := (numerator * anAdderFraccion denominator) + (denominator * anAdderFraccion numerator).
	newDenominator := denominator * anAdderFraccion denominator.
	
	^newNumerator / newDenominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: 'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'NR 9/23/2018 23:45:19'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator |
	
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].

	^self new initializeWith: numerator over: denominator
	! !
