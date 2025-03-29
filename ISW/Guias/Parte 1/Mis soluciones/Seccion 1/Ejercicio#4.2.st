!classDefinition: #I category: #'Ejercicio 4'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Ejercicio 4'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'next & previous' stamp: 'vm 3/24/2025 17:50:21'!
next
	^II.! !

!I class methodsFor: 'next & previous' stamp: 'vm 3/24/2025 18:59:40'!
previous
	self error: 'El uno es el primer numero natural'.! !


!I class methodsFor: 'error descriptions' stamp: 'vm 3/24/2025 20:45:34'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'.! !

!I class methodsFor: 'error descriptions' stamp: 'vm 3/24/2025 20:43:08'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'Numeros negativos no soportados'.! !


!I class methodsFor: 'aritmethic operations' stamp: 'vm 3/24/2025 17:56:29'!
* aMultiplicand
	^aMultiplicand.
	! !

!I class methodsFor: 'aritmethic operations' stamp: 'vm 3/24/2025 17:55:52'!
+ anAdder
	^anAdder next.! !

!I class methodsFor: 'aritmethic operations' stamp: 'vm 3/24/2025 20:43:40'!
- aSustrahend
	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.
	! !

!I class methodsFor: 'aritmethic operations' stamp: 'vm 3/24/2025 20:45:47'!
/ aDividend
	aDividend = I ifTrue: [^I] ifFalse: [self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].! !

!I class methodsFor: 'aritmethic operations' stamp: 'vm 3/24/2025 23:40:50'!
multiplication: aNumber
	^aNumber.! !

!I class methodsFor: 'aritmethic operations' stamp: 'vm 3/24/2025 23:42:03'!
multiplyBy: aNumber
	^aNumber.! !

!I class methodsFor: 'aritmethic operations' stamp: 'vm 3/24/2025 23:47:34'!
subtractTo: aNumber
	^aNumber previous.! !


!I class methodsFor: 'comparison' stamp: 'vm 3/24/2025 23:22:16'!
<= aNumber
	^true.! !


!classDefinition: #II category: #'Ejercicio 4'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Ejercicio 4'!
II class
	instanceVariableNames: 'previous next'!

!II class methodsFor: 'next & previous' stamp: 'vm 3/24/2025 20:34:26'!
nameOfNext
"	(self name endsWith: 'CMXCIX') ifTrue:[^(self name withoutSuffix: 'CMXCIX'), 'M'].
	(self name endsWith: 'DCCCXCIX') ifTrue:[^(self name withoutSuffix: 'DCCCXCIX'), 'CM'].
	(self name endsWith: 'CDXCIX') ifTrue:[^(self name withoutSuffix: 'CDXCIX'), 'D'].
	(self name endsWith: 'CCCXCIX') ifTrue:[^(self name withoutSuffix: 'CCCXCIX'), 'CD'].
	(self name endsWith: 'XCIX') ifTrue:[^(self name withoutSuffix: 'XCIX'), 'C'].
	(self name endsWith: 'LXXXIX') ifTrue:[^(self name withoutSuffix: 'LXXXIX'), 'XC'].
	(self name endsWith: 'XLIX') ifTrue:[^(self name withoutSuffix: 'XLIX'), 'L'].
	(self name endsWith: 'XXXIX') ifTrue:[^(self name withoutSuffix: 'XXXIX'), 'XL'].
	(self name endsWith: 'IX') ifTrue:[^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue:[^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'III') ifTrue:[^(self name withoutSuffix: 'III'), 'IV'].
	(self name endsWith: 'IV') ifTrue:[^(self name withoutSuffix: 'IV'), 'V']."
	^self name, 'I'.! !

!II class methodsFor: 'next & previous' stamp: 'vm 3/24/2025 19:05:38'!
next
	next := II createChildNamed: self nameOfNext.
	next previous: self.
	^next.! !

!II class methodsFor: 'next & previous' stamp: 'vm 3/24/2025 19:03:36'!
previous
	^previous.! !

!II class methodsFor: 'next & previous' stamp: 'vm 3/24/2025 19:03:43'!
previous: aNumber
	previous := aNumber.! !


!II class methodsFor: 'error descriptions' stamp: 'vm 3/24/2025 20:44:44'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'.! !


!II class methodsFor: 'alt aritmethic operations' stamp: 'vm 3/24/2025 23:38:07'!
multiplication: aMultiplicand
	^aMultiplicand multiplyBy: self.
	! !

!II class methodsFor: 'alt aritmethic operations' stamp: 'vm 3/24/2025 23:40:05'!
multiplyBy: aNumber
	^aNumber + (aNumber multiplication: self previous).! !

!II class methodsFor: 'alt aritmethic operations' stamp: 'vm 3/24/2025 23:47:18'!
subtractTo: aNumber
	^aNumber previous - self previous.! !

!II class methodsFor: 'alt aritmethic operations' stamp: 'vm 3/24/2025 23:46:46'!
subtraction: aNumber
	^aNumber subtractTo: self.! !

!II class methodsFor: 'alt aritmethic operations' stamp: 'vm 3/24/2025 23:44:31'!
sum: aNumber
	^self previous + aNumber next.! !


!II class methodsFor: 'aritmethic operations' stamp: 'vm 3/24/2025 20:38:37'!
* aMultiplicand
	(aMultiplicand isEqualTo: I)
	ifTrue: [^self]
	ifFalse: [^self + (self * (aMultiplicand previous))].
	! !

!II class methodsFor: 'aritmethic operations' stamp: 'vm 3/24/2025 20:33:01'!
+ anAdder
	(anAdder isEqualTo: I)
	ifTrue: [^self next]
	ifFalse: [^I + self + anAdder previous].! !

!II class methodsFor: 'aritmethic operations' stamp: 'vm 3/24/2025 19:40:00'!
- aSubtrahend
	(aSubtrahend isEqualTo: I)
	ifTrue: [^self previous]
	ifFalse: [^self previous - aSubtrahend previous]! !

!II class methodsFor: 'aritmethic operations' stamp: 'vm 3/24/2025 23:28:37'!
/ aDividend
	aDividend <= self
		ifFalse:[
			self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
		].
	aDividend = self ifTrue:[^I].
	aDividend <= (self - aDividend) ifFalse: [^I].
	^I + ((self - aDividend) / aDividend).
	! !


!II class methodsFor: 'aritmethic operations' stamp: 'vm 3/24/2025 20:38:37'!
* aMultiplicand
	(aMultiplicand isEqualTo: I)
	ifTrue: [^self]
	ifFalse: [^self + (self * (aMultiplicand previous))].
	! !

!II class methodsFor: 'aritmethic operations' stamp: 'vm 3/24/2025 20:33:01'!
+ anAdder
	(anAdder isEqualTo: I)
	ifTrue: [^self next]
	ifFalse: [^I + self + anAdder previous].! !

!II class methodsFor: 'aritmethic operations' stamp: 'vm 3/24/2025 19:40:00'!
- aSubtrahend
	(aSubtrahend isEqualTo: I)
	ifTrue: [^self previous]
	ifFalse: [^self previous - aSubtrahend previous]! !

!II class methodsFor: 'aritmethic operations' stamp: 'vm 3/24/2025 23:28:37'!
/ aDividend
	aDividend <= self
		ifFalse:[
			self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
		].
	aDividend = self ifTrue:[^I].
	aDividend <= (self - aDividend) ifFalse: [^I].
	^I + ((self - aDividend) / aDividend).
	! !

!II class methodsFor: 'comparison' stamp: 'vm 3/24/2025 23:20:48'!
< aNumber
	aNumber = I
	ifTrue: [^false].
	^self previous < aNumber previous.! !

!II class methodsFor: 'comparison' stamp: 'vm 3/24/2025 23:22:44'!
<= aNumber
	aNumber = I
	ifTrue: [^false].
	^self previous <= aNumber previous.! !

!II class methodsFor: 'error descriptions' stamp: 'vm 3/24/2025 20:44:44'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No se puede dividir por un numero mayor'.! !

!II class methodsFor: '--** private fileout/in **--' stamp: 'vm 3/24/2025 23:49:51'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.
	next := III.! !

!II class methodsFor: 'alt aritmethic operations' stamp: 'vm 3/24/2025 23:38:07'!
multiplication: aMultiplicand
	^aMultiplicand multiplyBy: self.
	! !

!II class methodsFor: 'alt aritmethic operations' stamp: 'vm 3/24/2025 23:40:05'!
multiplyBy: aNumber
	^aNumber + (aNumber multiplication: self previous).! !

!II class methodsFor: 'next & previous' stamp: 'vm 3/24/2025 20:34:26'!
nameOfNext
"	(self name endsWith: 'CMXCIX') ifTrue:[^(self name withoutSuffix: 'CMXCIX'), 'M'].
	(self name endsWith: 'DCCCXCIX') ifTrue:[^(self name withoutSuffix: 'DCCCXCIX'), 'CM'].
	(self name endsWith: 'CDXCIX') ifTrue:[^(self name withoutSuffix: 'CDXCIX'), 'D'].
	(self name endsWith: 'CCCXCIX') ifTrue:[^(self name withoutSuffix: 'CCCXCIX'), 'CD'].
	(self name endsWith: 'XCIX') ifTrue:[^(self name withoutSuffix: 'XCIX'), 'C'].
	(self name endsWith: 'LXXXIX') ifTrue:[^(self name withoutSuffix: 'LXXXIX'), 'XC'].
	(self name endsWith: 'XLIX') ifTrue:[^(self name withoutSuffix: 'XLIX'), 'L'].
	(self name endsWith: 'XXXIX') ifTrue:[^(self name withoutSuffix: 'XXXIX'), 'XL'].
	(self name endsWith: 'IX') ifTrue:[^(self name withoutSuffix: 'IX'), 'X'].
	(self name endsWith: 'VIII') ifTrue:[^(self name withoutSuffix: 'VIII'), 'IX'].
	(self name endsWith: 'III') ifTrue:[^(self name withoutSuffix: 'III'), 'IV'].
	(self name endsWith: 'IV') ifTrue:[^(self name withoutSuffix: 'IV'), 'V']."
	^self name, 'I'.! !

!II class methodsFor: 'next & previous' stamp: 'vm 3/24/2025 19:05:38'!
next
	next := II createChildNamed: self nameOfNext.
	next previous: self.
	^next.! !

!II class methodsFor: 'next & previous' stamp: 'vm 3/24/2025 19:03:36'!
previous
	^previous.! !

!II class methodsFor: 'next & previous' stamp: 'vm 3/24/2025 19:03:43'!
previous: aNumber
	previous := aNumber.! !

!II class methodsFor: 'alt aritmethic operations' stamp: 'vm 3/24/2025 23:47:18'!
subtractTo: aNumber
	^aNumber previous - self previous.! !

!II class methodsFor: 'alt aritmethic operations' stamp: 'vm 3/24/2025 23:46:46'!
subtraction: aNumber
	^aNumber subtractTo: self.! !

!II class methodsFor: 'alt aritmethic operations' stamp: 'vm 3/24/2025 23:44:31'!
sum: aNumber
	^self previous + aNumber next.! !


!II class methodsFor: 'comparison' stamp: 'vm 3/24/2025 23:20:48'!
< aNumber
	aNumber = I
	ifTrue: [^false].
	^self previous < aNumber previous.! !

!II class methodsFor: 'comparison' stamp: 'vm 3/24/2025 23:22:44'!
<= aNumber
	aNumber = I
	ifTrue: [^false].
	^self previous <= aNumber previous.! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'vm 3/24/2025 23:49:51'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := I.
	next := III.! !


!classDefinition: #III category: #'Ejercicio 4'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: #'Ejercicio 4'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'vm 3/24/2025 23:49:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := II.
	next := IIII.! !


!classDefinition: #IIII category: #'Ejercicio 4'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: #'Ejercicio 4'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'vm 3/24/2025 23:49:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := III.
	next := IIIII.! !


!classDefinition: #IIIII category: #'Ejercicio 4'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: #'Ejercicio 4'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: '--** private fileout/in **--' stamp: 'vm 3/24/2025 23:49:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIII.
	next := IIIIII.! !


!classDefinition: #IIIIII category: #'Ejercicio 4'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 4'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: #'Ejercicio 4'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: '--** private fileout/in **--' stamp: 'vm 3/24/2025 23:49:52'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	previous := IIIII.
	next := nil.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!