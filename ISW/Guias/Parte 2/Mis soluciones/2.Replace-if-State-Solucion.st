!classDefinition: #Automobile category: #'2.Replace-if-State'!
Object subclass: #Automobile
	instanceVariableNames: 'state speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!Automobile methodsFor: 'initialization' stamp: 'vm 4/10/2025 20:51:45'!
initialize

	self turnOff.
	speed := 0 * kilometer / hour! !


!Automobile methodsFor: 'move' stamp: 'vm 4/10/2025 20:56:01'!
accelerate

	state accelerate.! !

!Automobile methodsFor: 'move' stamp: 'vm 4/10/2025 20:50:26'!
accelerateWhenTurnedOff
	self error: 'Can not accelerate when turned off'! !

!Automobile methodsFor: 'move' stamp: 'vm 4/10/2025 20:49:43'!
accelerateWhenTurnedOn
	speed := speed + (10 * kilometer / hour)! !


!Automobile methodsFor: 'on/off' stamp: 'vm 4/10/2025 21:18:02'!
turnOff

	state := EngineOff on: self.! !

!Automobile methodsFor: 'on/off' stamp: 'vm 4/10/2025 21:18:06'!
turnOn

	state := EngineOn on: self.! !


!classDefinition: #EnginePowerState category: #'2.Replace-if-State'!
Object subclass: #EnginePowerState
	instanceVariableNames: 'aVehicleToPower'
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!EnginePowerState methodsFor: 'move' stamp: 'vm 4/10/2025 20:54:26'!
accelerate
	self subclassResponsibility.! !


!EnginePowerState methodsFor: 'initialization' stamp: 'vm 4/10/2025 20:54:17'!
on: aVehicle
	aVehicleToPower:= aVehicle.! !


!classDefinition: #EngineOff category: #'2.Replace-if-State'!
EnginePowerState subclass: #EngineOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!EngineOff methodsFor: 'as yet unclassified' stamp: 'vm 4/10/2025 20:55:10'!
accelerate
	aVehicleToPower accelerateWhenTurnedOff.! !


!classDefinition: #EngineOn category: #'2.Replace-if-State'!
EnginePowerState subclass: #EngineOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '2.Replace-if-State'!

!EngineOn methodsFor: 'as yet unclassified' stamp: 'vm 4/10/2025 20:55:48'!
accelerate
	aVehicleToPower accelerateWhenTurnedOn.! !
