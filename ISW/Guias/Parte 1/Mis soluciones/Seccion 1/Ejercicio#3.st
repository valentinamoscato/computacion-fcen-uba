!classDefinition: #Falso category: #'Ejercicio 3'!
DenotativeObject subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Falso class' category: #'Ejercicio 3'!
Falso class
	instanceVariableNames: ''!

!Falso class methodsFor: 'and & or' stamp: 'vm 3/24/2025 17:37:19'!
o: unBooleano
	^unBooleano.! !

!Falso class methodsFor: 'and & or' stamp: 'vm 3/24/2025 17:37:22'!
y: unBooleano
	^Falso.! !


!Falso class methodsFor: 'condicionales' stamp: 'vm 3/24/2025 17:37:33'!
siFalso: accionAIgnorar
	accionAIgnorar value.! !

!Falso class methodsFor: 'condicionales' stamp: 'vm 3/24/2025 17:37:37'!
siVerdadero: accionARealizar! !


!Falso class methodsFor: 'negacion' stamp: 'vm 3/24/2025 17:37:06'!
no
	^Verdadero.! !


!classDefinition: #Tests category: #'Ejercicio 3'!
DenotativeObject subclass: #Tests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Tests class' category: #'Ejercicio 3'!
Tests class
	instanceVariableNames: ''!

!Tests class methodsFor: 'and' stamp: 'vm 3/24/2025 17:40:08'!
test03VerdaderoYVerdaderoEsVerdadero
	Assert that: (Verdadero y: Verdadero) isEqualTo: Verdadero.! !

!Tests class methodsFor: 'and' stamp: 'vm 3/24/2025 17:40:43'!
test04VerdaderoYFalsoEsFalso
	Assert that: (Verdadero y: Falso) isEqualTo: Falso.! !

!Tests class methodsFor: 'and' stamp: 'vm 3/24/2025 17:41:29'!
test05FalsoYVerdaderoEsFalso
	Assert that: (Falso y: Verdadero) isEqualTo: Falso.! !

!Tests class methodsFor: 'and' stamp: 'vm 3/24/2025 17:41:50'!
test06FalsoYFalsoEsFalso
	Assert that: (Falso y: Falso) isEqualTo: Falso.! !


!Tests class methodsFor: 'negacion' stamp: 'vm 3/24/2025 17:38:20'!
test01NoVerdaderoEsFalso
	Assert that: Verdadero no isEqualTo: Falso.! !

!Tests class methodsFor: 'negacion' stamp: 'vm 3/24/2025 17:39:12'!
test02NoFalsoEsVerdadero
	Assert that: Falso no isEqualTo: Verdadero.! !


!Tests class methodsFor: 'condicionales' stamp: 'vm 3/24/2025 17:47:07'!
test11SiVerdaderoVerdaderoEjecuta
	| resultado |
	resultado := 'No ejecuta'.
	Verdadero siVerdadero: [ resultado := 'Ejecuta' ].
	Assert that: resultado isEqualTo: 'Ejecuta'.! !

!Tests class methodsFor: 'condicionales' stamp: 'vm 3/24/2025 17:47:39'!
test12SiFalsoVerdaderoIgnora
	| resultado |
	resultado := 'No ejecuta'.
	Verdadero siFalso: [ resultado := 'Ejecuta' ].
	Assert that: resultado isEqualTo: 'No ejecuta'.! !

!Tests class methodsFor: 'condicionales' stamp: 'vm 3/24/2025 17:48:11'!
test13SiVerdaderoFalsoIgnora
	| resultado |
	resultado := 'No ejecuta'.
	Falso siVerdadero: [ resultado := 'Ejecuta' ].
	Assert that: resultado isEqualTo: 'No ejecuta'.! !

!Tests class methodsFor: 'condicionales' stamp: 'vm 3/24/2025 17:48:38'!
test14SiFalsoFalsoEjecuta
	| resultado |
	resultado := 'No ejecuta'.
	Falso siFalso: [ resultado := 'Ejecuta' ].
	Assert that: resultado isEqualTo: 'Ejecuta'.! !


!Tests class methodsFor: 'or' stamp: 'vm 3/24/2025 17:44:00'!
test07VerdaderoOVerdaderoEsVerdadero
	Assert that: (Verdadero o: Verdadero) isEqualTo: Verdadero.! !

!Tests class methodsFor: 'or' stamp: 'vm 3/24/2025 17:44:23'!
test08VerdaderoOFalsoEsVerdadero
	Assert that: (Verdadero o: Falso) isEqualTo: Verdadero.! !

!Tests class methodsFor: 'or' stamp: 'vm 3/24/2025 17:43:31'!
test09FalsoOVerdaderoEsVerdadero
	Assert that: (Falso o: Verdadero) isEqualTo: Verdadero.! !

!Tests class methodsFor: 'or' stamp: 'vm 3/24/2025 17:43:49'!
test10FalsoOFalsoEsFalso
	Assert that: (Falso o: Falso) isEqualTo: Falso.! !


!classDefinition: #Verdadero category: #'Ejercicio 3'!
DenotativeObject subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: #'Ejercicio 3'!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: 'and & or' stamp: 'vm 3/24/2025 17:33:47'!
o: unBooleano
	^Verdadero.! !

!Verdadero class methodsFor: 'and & or' stamp: 'vm 3/24/2025 17:33:23'!
y: unBooleano
	^unBooleano.! !


!Verdadero class methodsFor: 'condicionales' stamp: 'vm 3/24/2025 17:36:29'!
siFalso: accionAIgnorar! !

!Verdadero class methodsFor: 'condicionales' stamp: 'vm 3/24/2025 17:36:12'!
siVerdadero: accionARealizar
	accionARealizar value.! !


!Verdadero class methodsFor: 'negacion' stamp: 'vm 3/24/2025 17:37:12'!
no
	^Falso.! !
