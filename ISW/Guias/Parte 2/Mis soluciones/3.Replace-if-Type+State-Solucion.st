!classDefinition: #EnginePowerState category: #'3.Replace-if-Type+State'!
Object subclass: #EnginePowerState
	instanceVariableNames: 'aVehicleToPower'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!EnginePowerState methodsFor: 'initialization' stamp: 'vm 4/10/2025 21:01:45'!
on: aVehicle
	aVehicleToPower:= aVehicle.! !


!EnginePowerState methodsFor: 'move' stamp: 'vm 4/10/2025 21:02:11'!
accelerate
	self subclassResponsibility.! !


!classDefinition: #EngineOff category: #'3.Replace-if-Type+State'!
EnginePowerState subclass: #EngineOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!EngineOff methodsFor: 'move' stamp: 'vm 4/10/2025 21:02:28'!
accelerate
	aVehicleToPower accelerateWhenTurnedOff.! !


!classDefinition: #EngineOn category: #'3.Replace-if-Type+State'!
EnginePowerState subclass: #EngineOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!EngineOn methodsFor: 'move' stamp: 'vm 4/10/2025 21:02:45'!
accelerate
	aVehicleToPower accelerateWhenTurnedOn.! !


!classDefinition: #Vehicle category: #'3.Replace-if-Type+State'!
Object subclass: #Vehicle
	instanceVariableNames: 'state speed'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Vehicle methodsFor: 'initialization' stamp: 'vm 4/10/2025 21:16:09'!
initialize
	self turnOff.
	speed := 0 * kilometer / hour.! !


!Vehicle methodsFor: 'move' stamp: 'vm 4/10/2025 21:12:28'!
accelerate
	state accelerate.! !

!Vehicle methodsFor: 'move' stamp: 'vm 4/10/2025 21:07:20'!
accelerateWhenTurnedOff
	self error: self canNotAccelerateErrorMessage.! !

!Vehicle methodsFor: 'move' stamp: 'vm 4/10/2025 21:03:20'!
accelerateWhenTurnedOn
	self subclassResponsibility.! !


!Vehicle methodsFor: 'on/off' stamp: 'vm 4/10/2025 21:13:00'!
turnOff
	state := EngineOff on: self.! !

!Vehicle methodsFor: 'on/off' stamp: 'vm 4/10/2025 21:12:57'!
turnOn
	state := EngineOn on: self.! !


!Vehicle methodsFor: 'error messages' stamp: 'vm 4/10/2025 21:12:41'!
canNotAccelerateErrorMessage
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'3.Replace-if-Type+State'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'ARM 4/29/2024 11:00:51'!
helicopter

	^self new initializeWithType: #Helicopter! !

!Vehicle class methodsFor: 'instance creation' stamp: 'ARM 4/29/2024 11:00:51'!
motorcycle

	^self new initializeWithType: #Motorcycle! !


!classDefinition: #Helicopter category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Helicopter
	instanceVariableNames: 'altitude'
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Helicopter methodsFor: 'move' stamp: 'vm 4/10/2025 21:09:53'!
accelerateWhenTurnedOn
	speed := speed + (10 * kilometer / hour).
	altitude := altitude + (5 * meter)! !


!Helicopter methodsFor: 'error messages' stamp: 'vm 4/10/2025 21:08:02'!
canNotAccelerateErrorMessage
	^'Can not fly when turned off'! !


!Helicopter methodsFor: 'initialization' stamp: 'vm 4/10/2025 21:16:28'!
initialize
	self turnOff.
	speed := 0 * kilometer / hour.
	altitude := 0 * meter! !


!classDefinition: #Motorcycle category: #'3.Replace-if-Type+State'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '3.Replace-if-Type+State'!

!Motorcycle methodsFor: 'error messages' stamp: 'vm 4/10/2025 21:08:13'!
canNotAccelerateErrorMessage
	^'Can not run when turned off'! !


!Motorcycle methodsFor: 'move' stamp: 'vm 4/10/2025 21:10:23'!
accelerateWhenTurnedOn
	speed := speed + (20 * kilometer / hour).! !
