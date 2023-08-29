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

!I class methodsFor: 'as yet unclassified' stamp: 'eaam 8/28/2023 20:23:02'!
\ divisor
	(self isEqualTo: divisor) ifTrue: [^I] ifFalse: [self - self]! !

!I class methodsFor: 'as yet unclassified' stamp: 'eaam 8/28/2023 20:46:23'!
dividiA: numeroNatural
	^numeroNatural! !

!I class methodsFor: 'as yet unclassified' stamp: 'em 8/24/2023 21:22:48'!
next
	siguiente ifNil: [siguiente := self cloneNamed: self name, 'I'. 
	siguiente previous: self].
	^siguiente! !

!I class methodsFor: 'as yet unclassified' stamp: 'em 8/24/2023 21:55:53'!
restateA: numeroNatural
	^numeroNatural previous! !

!I class methodsFor: 'as yet unclassified' stamp: 'eaam 8/28/2023 20:58:58'!
timesToDivide: numeroNatural
	^numeroNatural! !


!I class methodsFor: '--** private fileout/in **--' stamp: 'eaam 8/28/2023 21:52:31'!
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

!II class methodsFor: 'as yet unclassified' stamp: 'eaam 8/28/2023 21:02:59'!
\ unDivisor
	(self isEqualTo: unDivisor)
		ifTrue: [^I]
		ifFalse: [^ I + ((self - unDivisor) \ unDivisor)] ! !

!II class methodsFor: 'as yet unclassified' stamp: 'eaam 8/28/2023 21:50:20'!
divisionMala: divisor
	(self isEqualTo: divisor) 
		ifTrue: [^ I]
		ifFalse: [
			(((self - divisor) - divisor) )
				ifTrue: [^I]
				ifFalse: [^ I + ((self - divisor) divisionMala: divisor)]
			]! !

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

!II class methodsFor: 'as yet unclassified' stamp: 'em 8/24/2023 21:56:50'!
restandoMalo: unRestandoNatural
	(unRestandoNatural isEqualTo: I) 
	ifTrue: [^self previous.] 
	ifFalse: [^self previous restandoMalo: unRestandoNatural previous]! !

!II class methodsFor: 'as yet unclassified' stamp: 'em 8/24/2023 21:59:17'!
restateA: unNumeroNatural
	^unNumeroNatural previous - self previous! !

!II class methodsFor: 'as yet unclassified' stamp: 'eaam 8/28/2023 21:02:34'!
solucioonCatedraDeDividir: unDivisor
	^ unDivisor timesToDivide: self! !

!II class methodsFor: 'as yet unclassified' stamp: 'eaam 8/28/2023 21:04:43'!
timesToDivide: unDivisor
	(self isEqualTo: unDivisor) ifTrue: [^I] ifFalse: [^ I + ((self - unDivisor) solucioonCatedraDeDividir: unDivisor)]
	! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'eaam 8/28/2023 21:52:31'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	siguiente := nil.
	anterior := I.! !

I initializeAfterFileIn!
II initializeAfterFileIn!