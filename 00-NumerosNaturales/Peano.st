!classDefinition: #I category: 'Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Peano'!
I class
	instanceVariableNames: 'siguiente'!

!I class methodsFor: 'as yet unclassified' stamp: 'eaam 8/28/2023 20:40:23'!
* unNumeroNatural
	^unNumeroNatural! !

!I class methodsFor: 'as yet unclassified' stamp: 'em 8/24/2023 21:06:40'!
+ unSumandoNatural
	^unSumandoNatural next! !

!I class methodsFor: 'as yet unclassified' stamp: 'Sof D 8/31/2023 17:48:08'!
- unNumeroNatural 
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados! !

!I class methodsFor: 'as yet unclassified' stamp: 'Sof D 8/31/2023 18:21:08'!
/ divisor
	(self isEqualTo: divisor) ifTrue: [^I] ifFalse: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]! !

!I class methodsFor: 'as yet unclassified' stamp: 'Sof D 8/31/2023 18:21:24'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'Los naturales no soportan la division de un numero mayor por uno menor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'Sof D 8/31/2023 17:49:25'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'La resta de naturales no incluye soporte para numeros negativos'! !

!I class methodsFor: 'as yet unclassified' stamp: 'Sof D 8/31/2023 18:08:36'!
esMenorA: unNumeroNatural
	unNumeroNatural = I ifTrue:[^false].
	^true! !

!I class methodsFor: 'as yet unclassified' stamp: 'em 8/24/2023 21:22:48'!
next
	siguiente ifNil: [siguiente := self cloneNamed: self name, 'I'. 
	siguiente previous: self].
	^siguiente! !

!I class methodsFor: 'as yet unclassified' stamp: 'Sof D 8/31/2023 18:25:40'!
restateA: unNumeroNatural 
	^unNumeroNatural previous ! !

!I class methodsFor: 'as yet unclassified' stamp: 'eaam 8/28/2023 20:58:58'!
timesToDivide: numeroNatural
	^numeroNatural! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'Sof D 8/31/2023 18:26:38'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	siguiente := II.! !


!classDefinition: #II category: 'Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Peano'!
II class
	instanceVariableNames: 'siguiente anterior'!

!II class methodsFor: 'as yet unclassified' stamp: 'eaam 8/28/2023 20:40:37'!
* unMultiplicando
	^unMultiplicando + (self previous * unMultiplicando)! !

!II class methodsFor: 'as yet unclassified' stamp: 'em 8/24/2023 21:23:24'!
+ unSumandoNatural
	^self previous + unSumandoNatural next! !

!II class methodsFor: 'as yet unclassified' stamp: 'em 8/24/2023 21:57:38'!
- unRestandoNatural
	^unRestandoNatural restateA: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'Sof D 8/31/2023 18:16:13'!
/ unNumeroNatural
	unNumeroNatural = self ifTrue: [^I].
	(self esMenorA: unNumeroNatural) ifTrue: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
	((self - unNumeroNatural) esMenorA: unNumeroNatural ) ifTrue: [^I].
	^I + ((self - unNumeroNatural) / unNumeroNatural )! !

!II class methodsFor: 'as yet unclassified' stamp: 'Sof D 8/31/2023 18:15:33'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'Los naturales no soportan la division de un numero mayor por uno menor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'Sof D 8/31/2023 18:17:08'!
esMenorA: unNumeroNatural
	unNumeroNatural = I ifTrue: [^false].
	^(self previous esMenorA: unNumeroNatural previous)
! !

!II class methodsFor: 'as yet unclassified' stamp: 'eaam 8/28/2023 21:11:41'!
next
	siguiente ifNotNil: [^siguiente].
	siguiente := II createChildNamed: self name, 'I'. 
	siguiente previous: self.
	^siguiente! !

!II class methodsFor: 'as yet unclassified' stamp: 'em 8/24/2023 21:22:20'!
previous
	^anterior! !

!II class methodsFor: 'as yet unclassified' stamp: 'em 8/24/2023 21:49:13'!
previous: elAnterior
	anterior := elAnterior! !

!II class methodsFor: 'as yet unclassified' stamp: 'em 8/24/2023 21:59:17'!
restateA: unNumeroNatural
	^unNumeroNatural previous - self previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'Sof D 8/31/2023 18:26:21'!
solucionCatedraDeDividir: unDivisor
	^ unDivisor timesToDivide: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'Sof D 8/31/2023 18:26:21'!
timesToDivide: unDivisor
	(self isEqualTo: unDivisor) ifTrue: [^I] ifFalse: [^ I + ((self - unDivisor) solucionCatedraDeDividir: unDivisor)]
	! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'Sof D 8/31/2023 18:26:38'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	siguiente := III.
	anterior := I.! !


!classDefinition: #III category: 'Peano'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Peano'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'Sof D 8/31/2023 18:26:38'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	siguiente := IIII.
	anterior := II.! !


!classDefinition: #IIII category: 'Peano'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Peano'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'Sof D 8/31/2023 18:26:38'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	siguiente := nil.
	anterior := III.! !

I initializeAfterFileIn!
II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!