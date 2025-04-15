!classDefinition: #Vehicle category: #'1.Replace-if-Type'!
Object subclass: #Vehicle
	instanceVariableNames: 'speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Vehicle methodsFor: 'initialization' stamp: 'vm 4/10/2025 20:41:35'!
initialize

	speed := 0 * kilometer / hour.! !


!Vehicle methodsFor: 'move' stamp: 'vm 4/10/2025 20:38:50'!
accelerate

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'1.Replace-if-Type'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'vm 4/10/2025 20:41:04'!
helicopter

	^self new initialize! !

!Vehicle class methodsFor: 'instance creation' stamp: 'vm 4/10/2025 20:41:04'!
motorcycle

	^self new initialize! !


!classDefinition: #Helicopter category: #'1.Replace-if-Type'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Helicopter methodsFor: 'move' stamp: 'vm 4/10/2025 20:37:53'!
accelerate
	speed := speed + (10 * kilometer / hour).
	altitude := altitude + (5 * meter).! !


!Helicopter methodsFor: 'initialization' stamp: 'vm 4/10/2025 20:42:16'!
initialize
	speed := 0 * kilometer / hour.
	altitude := 0 * meter! !


!classDefinition: #Motorcycle category: #'1.Replace-if-Type'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '1.Replace-if-Type'!

!Motorcycle methodsFor: 'move' stamp: 'vm 4/10/2025 20:37:47'!
accelerate
	speed := speed + (20 * kilometer / hour).! !
