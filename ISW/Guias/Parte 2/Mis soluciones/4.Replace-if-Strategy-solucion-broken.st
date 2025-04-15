!classDefinition: #VehicleTests category: #'4.Replace-if-Strategy'!
TestCase subclass: #VehicleTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:25:03'!
test01LandVehicleCannotAccelerateWhileTurnedOff

	| landVehicle |
	
	landVehicle := Vehicle electricMotorcycle.
	
	self should: [ landVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not run when turned off'.
		self assert: (landVehicle speedAt: (0 * kilometer / hour)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:27:17'!
test02AirVehicleCannotAccelerateWhileTurnedOff

	| airVehicle |
	
	airVehicle := Vehicle helicopter.
	
	self should: [ airVehicle accelerate ] 
	raise: Error 
	withExceptionDo: [ :error | error messageText = 'Can not fly when turned off'.
		self assert: (airVehicle speedAt: (0 * kilometer / hour)).
		self assert: (airVehicle altitudeAt: (0 * meter)) ]
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:20'!
test03ElectricVehicleAccelerateAsIntended

	| electricVehicle |
	
	electricVehicle := Vehicle electricMotorcycle.
	
	electricVehicle turnOn.
	self assert: (electricVehicle speedAt: 0 * kilometer / hour).
	
	electricVehicle accelerate.
	self assert: (electricVehicle speedAt: 10 * kilometer / hour).
	
	electricVehicle accelerate.
	self assert: (electricVehicle speedAt: 40 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:16'!
test04GasolineVehicleAccelerateAsIntended

	| gasolineVehicle |
	
	gasolineVehicle := Vehicle gasolineMotorcycle.
	
	gasolineVehicle turnOn.
	self assert: (gasolineVehicle speedAt: 0 * kilometer / hour).
	
	gasolineVehicle accelerate.
	self assert: (gasolineVehicle speedAt: 10 * kilometer / hour).
	
	gasolineVehicle accelerate.
	self assert: (gasolineVehicle speedAt: 20 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:11'!
test05JetFueledVehicleAccelerateAsIntended

	| jetFueledVehicle |
	
	jetFueledVehicle := Vehicle helicopter.
	
	jetFueledVehicle turnOn.
	self assert: (jetFueledVehicle speedAt: 0 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 1 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 5 * kilometer / hour).
	
	jetFueledVehicle accelerate.
	self assert: (jetFueledVehicle speedAt: 41 * kilometer / hour)
	
	
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:47:14'!
test06AirVehicleGoesUpAsItAcceleratesAsExpected

	| airVehicle |
	
	airVehicle := Vehicle helicopter.
	
	airVehicle turnOn.
	self assert: (airVehicle altitudeAt: 0 * meter).
	
	airVehicle accelerate.
	self assert: (airVehicle altitudeAt: 5 * meter).
	
	airVehicle accelerate.
	self assert: (airVehicle altitudeAt: 10 * meter)
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:52:05'!
test07SpeedLimiterForCityLimitsSpeedAt70Kmh

	| cityVehicle |
	
	cityVehicle := Vehicle electricMotorcycle.
	
	cityVehicle turnOn.
	self assert: (cityVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ cityVehicle accelerate ].
	
	self assert: (cityVehicle speedAt: 70 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:53:50'!
test08SpeedLimiterForOpenRoadLimitsSpeedAt130Kmh

	| openRoadVehicle |
	
	openRoadVehicle := Vehicle gasolineMotorcycle.
	
	openRoadVehicle turnOn.
	self assert: (openRoadVehicle speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ openRoadVehicle accelerate ].
	
	self assert: (openRoadVehicle speedAt: 130 * kilometer / hour)
	
	
	! !

!VehicleTests methodsFor: 'testing' stamp: 'NR 9/7/2024 18:55:32'!
test09SpeedLimiterForAirTrafficLimitsSpeedAt500Kmh

	| vehicleInAir |
	
	vehicleInAir := Vehicle helicopter.
	
	vehicleInAir turnOn.
	self assert: (vehicleInAir speedAt: 0 * kilometer / hour).
	
	20 timesRepeat: [ vehicleInAir accelerate ].
	
	self assert: (vehicleInAir speedAt: 500 * kilometer / hour)
	
	
	! !


!classDefinition: #EnginePowerStatus category: #'4.Replace-if-Strategy'!
Object subclass: #EnginePowerStatus
	instanceVariableNames: 'aVehicleToControlPowerOf'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!EnginePowerStatus methodsFor: 'nil' stamp: 'vm 4/10/2025 22:18:04'!
accelerate
	self subclassResponsibility.! !

!EnginePowerStatus methodsFor: 'nil' stamp: 'vm 4/10/2025 22:14:44'!
on: aVehicle
	aVehicleToControlPowerOf := aVehicle.! !


!classDefinition: #EngineOff category: #'4.Replace-if-Strategy'!
EnginePowerStatus subclass: #EngineOff
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!EngineOff methodsFor: 'nil' stamp: 'vm 4/10/2025 22:16:25'!
accelerate
	aVehicleToControlPowerOf accelerateWhenTurnedOff.! !


!classDefinition: #EngineOn category: #'4.Replace-if-Strategy'!
EnginePowerStatus subclass: #EngineOn
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!EngineOn methodsFor: 'nil' stamp: 'vm 4/10/2025 22:17:50'!
accelerate
	aVehicleToControlPowerOf accelerateWhenTurnedOn.! !


!classDefinition: #EngineType category: #'4.Replace-if-Strategy'!
Object subclass: #EngineType
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!EngineType methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 17:49:56'!
acceleration: currentSpeed
	self subclassResponsibility.! !


!classDefinition: #ElectricEngineType category: #'4.Replace-if-Strategy'!
EngineType subclass: #ElectricEngineType
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!ElectricEngineType methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 17:48:10'!
acceleration: currentSpeed
	^(currentSpeed + (5 * kilometer / hour)) * 2! !


!classDefinition: #GasolineEngineType category: #'4.Replace-if-Strategy'!
EngineType subclass: #GasolineEngineType
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!GasolineEngineType methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 17:48:30'!
acceleration: currentSpeed
	^(currentSpeed + (5 * kilometer / hour)) * 2! !


!classDefinition: #JetFueledEngineType category: #'4.Replace-if-Strategy'!
EngineType subclass: #JetFueledEngineType
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!JetFueledEngineType methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 17:49:34'!
acceleration: currentSpeed
	^((currentSpeed amount + 1) ^ 2) * kilometer / hour! !


!classDefinition: #SpeedLimiter category: #'4.Replace-if-Strategy'!
Object subclass: #SpeedLimiter
	instanceVariableNames: 'speedLimit'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!SpeedLimiter methodsFor: 'move' stamp: 'vm 4/13/2025 18:10:26'!
limitedSpeed: currentSpeed
	^currentSpeed min: speedLimit.
	! !


!SpeedLimiter methodsFor: 'initialization' stamp: 'vm 4/13/2025 18:14:35'!
withLimit: aSpeedLimit
	speedLimit := aSpeedLimit.
	^ self.! !


!classDefinition: #Vehicle category: #'4.Replace-if-Strategy'!
Object subclass: #Vehicle
	instanceVariableNames: 'state speed altitude engineType speedLimiter'
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Vehicle methodsFor: 'initialization' stamp: 'vm 4/13/2025 17:55:41'!
initializeWithEngine: anEngineType andSpeedLimiter: aSpeedLimiter
	self subclassResponsibility.! !


!Vehicle methodsFor: 'move' stamp: 'vm 4/13/2025 18:10:36'!
accelerate
	state accelerate.! !

!Vehicle methodsFor: 'move' stamp: 'vm 4/10/2025 22:16:37'!
accelerateWhenTurnedOff
	self error: self canNotAccelerateErrorMessage. ! !

!Vehicle methodsFor: 'move' stamp: 'vm 4/13/2025 17:51:50'!
accelerateWhenTurnedOn
	self subclassResponsibility.! !

!Vehicle methodsFor: 'move' stamp: 'NR 9/7/2024 18:24:00'!
altitudeAt: anAltitude

	^ altitude = anAltitude! !

!Vehicle methodsFor: 'move' stamp: 'NR 9/7/2024 18:23:27'!
speedAt: aSpeed

	^ speed = aSpeed! !


!Vehicle methodsFor: 'on/off' stamp: 'vm 4/10/2025 22:19:24'!
turnOff

	state := EngineOff on: self.
	speed := 0 * kilometer / hour! !

!Vehicle methodsFor: 'on/off' stamp: 'vm 4/10/2025 22:19:30'!
turnOn

	state := EngineOn on: self.! !


!Vehicle methodsFor: 'error messages' stamp: 'vm 4/10/2025 21:33:27'!
canNotAccelerateErrorMessage
	self subclassResponsibility.! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Vehicle class' category: #'4.Replace-if-Strategy'!
Vehicle class
	instanceVariableNames: ''!

!Vehicle class methodsFor: 'instance creation' stamp: 'vm 4/13/2025 18:13:42'!
electricMotorcycle

	^ self new initializeWithEngine: (ElectricEngineType new) andSpeedLimiter: (SpeedLimiter withLimit: (70 * kilometer / hour))

! !

!Vehicle class methodsFor: 'instance creation' stamp: 'vm 4/13/2025 18:13:47'!
gasolineMotorcycle

	^ self new initializeWithEngine: (GasolineEngineType new) andSpeedLimiter: (SpeedLimiter withLimit: (130 * kilometer / hour))! !

!Vehicle class methodsFor: 'instance creation' stamp: 'vm 4/13/2025 18:13:52'!
helicopter

	^ self new initializeWithEngine: (JetFueledEngineType new) andSpeedLimiter: (SpeedLimiter withLimit: (500 * kilometer / hour))! !


!classDefinition: #Helicopter category: #'4.Replace-if-Strategy'!
Vehicle subclass: #Helicopter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Helicopter methodsFor: 'move' stamp: 'vm 4/13/2025 18:08:35'!
accelerateWhenTurnedOn
	| acceleration acceleratedSpeed |
	acceleration := engineType acceleration: speed.
	acceleratedSpeed := speed + acceleration.
	speed := speedLimiter limitedSpeed: acceleratedSpeed.
	altitude := altitude + (5 * meter) ! !


!Helicopter methodsFor: 'initialization' stamp: 'vm 4/13/2025 18:17:00'!
initializeWithEngine: anEngineType andSpeedLimiter: aSpeedLimiter
	
	self turnOff.
	engineType := anEngineType.
	speedLimiter := aSpeedLimiter.
	speed := 0 * kilometer / hour.
	altitude := 0 * meter! !


!Helicopter methodsFor: 'error messages' stamp: 'vm 4/10/2025 21:32:51'!
canNotAccelerateErrorMessage
	^'Can not fly when turned off'! !


!classDefinition: #Motorcycle category: #'4.Replace-if-Strategy'!
Vehicle subclass: #Motorcycle
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '4.Replace-if-Strategy'!

!Motorcycle methodsFor: 'move' stamp: 'vm 4/13/2025 18:09:17'!
accelerateWhenTurnedOn
	| acceleration acceleratedSpeed |
	acceleration := engineType acceleration: speed.
	acceleratedSpeed := speed + acceleration.
	speed := speedLimiter limitedSpeed: acceleratedSpeed.! !


!Motorcycle methodsFor: 'error messages' stamp: 'vm 4/10/2025 21:33:16'!
canNotAccelerateErrorMessage
	^'Can not run when turned off'! !


!Motorcycle methodsFor: 'initialization' stamp: 'vm 4/13/2025 18:17:07'!
initializeWithEngine: anEngineType andSpeedLimiter: aSpeedLimiter
	
	self turnOff.
	engineType := anEngineType.
	speedLimiter := aSpeedLimiter.
	speed := 0 * kilometer / hour.! !
