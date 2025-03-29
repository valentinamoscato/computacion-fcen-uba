!classDefinition: #Bill category: #'Ejercicio 2'!
DenotativeObject subclass: #Bill
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bill class' category: #'Ejercicio 2'!
Bill class
	instanceVariableNames: 'energia'!

!Bill class methodsFor: '-- all --' stamp: 'VM 3/20/2025 21:19:18'!
caminar: unaCantidadDeKilometros
	energia := energia - 3 - unaCantidadDeKilometros.! !

!Bill class methodsFor: '-- all --' stamp: 'VM 3/20/2025 21:18:19'!
comer: unaCantidadDeKilosDeCerebro
	energia := energia + (4*unaCantidadDeKilosDeCerebro).
	^energia.! !

!Bill class methodsFor: '-- all --' stamp: 'VM 3/20/2025 21:17:06'!
energia
	^energia.! !

!Bill class methodsFor: '--** private fileout/in **--' stamp: 'vm 3/29/2025 13:22:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	energia := 31.! !

!Bill class methodsFor: '-- all --' stamp: 'VM 3/20/2025 21:21:03'!
new
	energia := 28.! !


!Bill class methodsFor: '--** private fileout/in **--' stamp: 'vm 3/29/2025 13:22:10'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	energia := 31.! !

Bill initializeAfterFileIn!