!classDefinition: #CashierTest category: #'IRobot-Enunciado'!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'vm 4/13/2025 21:23:01'!
should: aBlock raise: anError withMessage: anErrorMessage

	| aRobot aTrailer aCashier |
	
	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aCashier := Cashier new.

	self
		should: [ aBlock
		]
		raise: anError
		withMessageText: anErrorMessage.

"esto no tiene mucho sentido y genera problemas para pasarle el bloque..."! !

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'vm 4/13/2025 21:14:02'!
test01ShouldNotAcceptEmptyTrailerFromNormalWorkingRobot

	| aRobot aTrailer aCashier |
	
	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aCashier := Cashier new.

	self
		should: [ 
			aCashier receiveOrder: aRobot 
		]
		raise: Error
		withMessageText: Cashier trailerIsEmptyErrorDescription.! !

!CashierTest methodsFor: 'receiving from empty trailer' stamp: 'F 5/21/2020 21:50:32'!
test02ShouldNotAcceptEmptyTrailerFromMechanicalFailureRobot

	| aRobot aTrailer aCashier |
	
	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aCashier := Cashier new.

	self
		should: [ 
			aRobot withMechanicalFailure.
			aCashier receiveOrder: aRobot 
		]
		raise: Error
		withMessageText: Cashier trailerIsEmptyErrorDescription.
! !


!CashierTest methodsFor: 'receiving from sensors failure robot' stamp: 'F 5/20/2020 23:18:54'!
test03ShouldNotAcceptSensorsFailureRobot

	| aRobot aTrailer aCashier |
	
	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aCashier := Cashier new.

	self
		should: [ 
			aRobot withSensorsFailure.
			aCashier receiveOrder: aRobot ]
		raise: Error
		withMessageText: Cashier robotSensorsFailureErrorDescription.
! !


!CashierTest methodsFor: 'receiving from mechanical failure robot' stamp: 'F 5/20/2020 23:47:15'!
test04ShouldChangeRobotStatusToOutOfOrderWhenMechanicalFailureRobot

	| aRobot aTrailer aCashier |
	
	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aCashier := Cashier new.

	self
		should: [ 
			aRobot take: (ProductA with: 1  and: 1).
			aRobot withMechanicalFailure.
			
			aCashier receiveOrder: aRobot.
			
			aRobot take: (ProductA with: 1 and: 1) ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.

! !


!classDefinition: #ProductTest category: #'IRobot-Enunciado'!
TestCase subclass: #ProductTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 19:37:46'!
test01CanNotCreateProductWithCeroOrLessWeight

	self
		should: [ Product with: 0  and: 100 ]
		raise: Error
		withMessageText: Product invalidWeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 19:37:51'!
test02CanNotCreateProductWithCeroOrLessHeight

	self
		should: [ Product with: 100  and: 0 ]
		raise: Error
		withMessageText: Product invalidHeightErrorDescription 
! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:54:48'!
test03CanNotCreateProductWithNoIntegerWeight

	self
		should: [ Product with: 1.5  and: 100 ]
		raise: Error
		withMessageText: Product weightMustBeIntegerErrorDescription 

! !

!ProductTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:55:14'!
test04CanNotCreateProductWithNoIntegerHeight

	self
		should: [ Product with: 100  and: 1.5 ]
		raise: Error
		withMessageText: Product heightMustBeIntegerErrorDescription 

! !


!classDefinition: #RobotTest category: #'IRobot-Enunciado'!
TestCase subclass: #RobotTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!RobotTest methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 11:29:44'!
test01ShouldReceiveAnEmptyTrailer

	| aTrailer |

	aTrailer := Trailer with: 20 and: 100.
	aTrailer carry: (ProductA with: 1  and: 1).
	
	self
		should: [ Robot with: aTrailer ]
		raise: Error
		withMessageText: Robot notEmptyTrailerErrorDescription! !


!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:04:57'!
test02ShouldTakeProductsWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:07:49'!
test03ShouldTakeProductsWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot withSensorsFailure.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 11:08:34'!
test04ShouldTakeProductsWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot withMechanicalFailure.
	
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: 1 equals: aTrailer totalProductsAmount! !

!RobotTest methodsFor: 'taking products' stamp: 'FRT 5/4/2020 18:26:53'!
test05ShouldNotTakeProductsWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot outOfOrder.
	
	self
		should: [ aRobot take: (ProductA with: 1  and: 1) ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
	
	self assert: 0 equals: aTrailer totalProductsAmount! !


!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 12:46:40'!
test06CanCloseOrderWhenWorkingNormal

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	self assert: (aRobot closeOrderUsing: Cashier new)! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 11:28:16'!
test07CanNotCloseOrderWhenWorkingWithSensorsFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot withSensorsFailure.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Cashier robotSensorsFailureErrorDescription.
 
! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 12:47:10'!
test08CanCloseOrderWhenWorkingWithMechanicalFailures

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).

	aRobot withMechanicalFailure.	
		
	self assert: (aRobot closeOrderUsing: Cashier new).! !

!RobotTest methodsFor: 'closing order' stamp: 'FRT 5/4/2020 18:48:41'!
test09CanNotCloseOrderWhenOutOfOrder

	| aTrailer aRobot |

	aTrailer := Trailer with: 20 and: 100.
	aRobot := Robot with: aTrailer.
	aRobot take: (ProductA with: 1  and: 1).
	
	aRobot outOfOrder.

	self
		should: [ aRobot closeOrderUsing: Cashier new ]
		raise: Error
		withMessageText: Robot outOfOrderErrorDescription.
 
! !


!classDefinition: #TrailerTest category: #'IRobot-Enunciado'!
TestCase subclass: #TrailerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!TrailerTest methodsFor: 'weight capacity' stamp: 'vm 4/14/2025 11:22:34'!
test01CanNotCreateTrailerWithNoWeightCapacity

	self
		should: self createTrailerWithNoWeightCapacity
		raise: Error
		withMessageText: Trailer invalidWeightCapacityErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'vm 4/14/2025 11:23:01'!
test02CanNotCreateTrailerWithNoHeightCapacity

	self
		should: self createTrailerWithNoHeightCapacity
		raise: Error
		withMessageText: Trailer invalidHeightCapacityErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'vm 4/14/2025 11:23:35'!
test03CanNotCreateTrailerWithInvalidWeightCapacity

	self
		should: self createTrailerWithInvalidWeightCapacity
		raise: Error
		withMessageText: Trailer weightCapacityMustBeIntegerErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'vm 4/14/2025 11:23:47'!
test04CanNotCreateTrailerWithInvalidHeightCapacity

	self
		should: self createTrailerWithInvalidHeightCapacity
		raise: Error
		withMessageText: Trailer heightCapacityMustBeIntegerErrorDescription 
! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'vm 4/14/2025 11:32:33'!
test05ShouldRejectProductAIfWeightExceeded

	| aTrailer weightCapacity heightCapacity |
	weightCapacity := 20.
	heightCapacity := 100.
	aTrailer := Trailer with: weightCapacity  and: heightCapacity.
	
	self
		should: (self exceedTrailerWeightFor: aTrailer withCapacity: weightCapacity andProduct: ProductA)
		raise: Error
		withMessageText: Trailer maxWeightExceededErrorDescription.
		
	self assert: aTrailer isEmpty.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'vm 4/14/2025 11:33:42'!
test06ShouldRejectProductBIfWeightExceeded

	| aTrailer weightCapacity heightCapacity |
	weightCapacity := 20.
	heightCapacity := 100.
	aTrailer := Trailer with: weightCapacity  and: heightCapacity.
	
	self
		should: (self exceedTrailerWeightFor: aTrailer withCapacity: weightCapacity andProduct: ProductB)
		raise: Error
		withMessageText: Trailer maxWeightExceededErrorDescription.
		
	self assert: aTrailer isEmpty.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'vm 4/14/2025 21:01:02'!
test07ShouldAcceptProductsWithWeightUnderCapacity

	| aTrailer weightCapacity heightCapacity listOfProducts |
	weightCapacity := 11.
	heightCapacity := 100.
	aTrailer := Trailer with: weightCapacity  and: heightCapacity.
	
	listOfProducts := Array with: (ProductA with: 1 and: 1) with: (ProductA with: 2 and: 1) with: (ProductB with: 3 and: 1) with: (ProductB with: 4 and: 1).
	
	self loadTrailer: aTrailer withProducts: listOfProducts.
		
	self assert: aTrailer totalProductsAmount equals: (listOfProducts size).
	self assert: aTrailer totalProductsWeight equals: 10.! !

!TrailerTest methodsFor: 'weight capacity' stamp: 'vm 4/14/2025 21:03:02'!
test08ShouldAcceptProductsWithWeightAtCapacity

	| aTrailer weightCapacity heightCapacity listOfProducts |
	weightCapacity := 11.
	heightCapacity := 100.
	aTrailer := Trailer with: weightCapacity  and: heightCapacity.
	
	listOfProducts := Array with: (ProductA with: 1 and: 1) with: (ProductA with: 2 and: 1) with: (ProductB with: 3 and: 1) with: (ProductB with: 4 and: 1) with: (ProductB with: 1 and: 1).
	
	
	self loadTrailer: aTrailer withProducts: listOfProducts.
		
	self assert: aTrailer totalProductsAmount equals: (listOfProducts size).
	self assert: aTrailer totalProductsWeight equals: weightCapacity.! !


!TrailerTest methodsFor: 'height capacity' stamp: 'vm 4/14/2025 21:05:36'!
test09ShouldAcceptProductAIgnoringMaxTotalHeightOfBProducts

	| aTrailer weightCapacity heightCapacity exceededHeightCapacity halfExceededHeightCapacity halfWeightCapacity listOfProducts |
	weightCapacity := 20.
	heightCapacity := 100.
	aTrailer := Trailer with: weightCapacity  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	halfWeightCapacity := weightCapacity / 2.
	
	listOfProducts := Array with: (ProductA with: halfWeightCapacity and: halfExceededHeightCapacity) with: (ProductA with: halfWeightCapacity and: halfExceededHeightCapacity).
	
	self loadTrailer: aTrailer withProducts: listOfProducts.
	
	self assert: aTrailer totalProductsAmount equals: (listOfProducts size).
	self assert: aTrailer totalProductsHeight equals: 0.
	! !

!TrailerTest methodsFor: 'height capacity' stamp: 'vm 4/14/2025 21:16:00'!
test10ShouldIgnoreAProductsInMaxTotalHeightOfBProducts

	| aTrailer heightCapacity exceededHeightCapacity halfExceededHeightCapacity |

	heightCapacity := 100.
	aTrailer := Trailer with: 20  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	
	aTrailer carry: (ProductA with: 10 and: halfExceededHeightCapacity).
	aTrailer carry: (ProductB with: 10 and: halfExceededHeightCapacity).
	
	self assert: aTrailer totalProductsAmount equals: 2.
	self assert: aTrailer totalProductsHeight equals: halfExceededHeightCapacity.
	! !

!TrailerTest methodsFor: 'height capacity' stamp: 'FRT 5/5/2020 11:28:16'!
test11ShouldRejectProductBExceedingMaxTotalHeightOfBProducts

	| aTrailer heightCapacity exceededHeightCapacity halfExceededHeightCapacity |

	heightCapacity := 100.
	aTrailer := Trailer with: 20  and: heightCapacity.
	
	exceededHeightCapacity := heightCapacity + 2.
	halfExceededHeightCapacity := exceededHeightCapacity / 2.
	
	aTrailer carry: (ProductB with: 10 and: halfExceededHeightCapacity).

	self 
		should: [aTrailer carry: (ProductB with: 10 and: halfExceededHeightCapacity)] 
		raise: Error
		withMessageText: Trailer maxHeightExceededErrorDescription.
	
	self assert: aTrailer totalProductsAmount equals: 1.
	self assert: aTrailer totalProductsHeight equals: halfExceededHeightCapacity.
	! !


!TrailerTest methodsFor: 'as yet unclassified' stamp: 'vm 4/14/2025 11:23:21'!
createTrailerWithInvalidHeightCapacity
	^[Trailer with: 1 and: 1.5]! !

!TrailerTest methodsFor: 'as yet unclassified' stamp: 'vm 4/14/2025 11:23:15'!
createTrailerWithInvalidWeightCapacity
	^[Trailer with: 1.5 and: 100]! !

!TrailerTest methodsFor: 'as yet unclassified' stamp: 'vm 4/14/2025 11:22:46'!
createTrailerWithNoHeightCapacity
	^[Trailer with: 1 and: 0]! !

!TrailerTest methodsFor: 'as yet unclassified' stamp: 'vm 4/14/2025 11:22:20'!
createTrailerWithNoWeightCapacity
	^[Trailer with: 0 and: 100]! !

!TrailerTest methodsFor: 'as yet unclassified' stamp: 'vm 4/14/2025 11:27:51'!
exceedTrailerWeightFor: aTrailer withCapacity: aWeightCapacity andProduct: aProduct 
	^[ aTrailer carry: (aProduct with: (aWeightCapacity + 1) and: 1) ]! !

!TrailerTest methodsFor: 'as yet unclassified' stamp: 'vm 4/14/2025 21:14:09'!
loadTrailer: aTrailer withProducts: aListOfProducts
	aListOfProducts do: [:p | aTrailer carry: p.]! !


!classDefinition: #Cashier category: #'IRobot-Enunciado'!
Object subclass: #Cashier
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Cashier methodsFor: 'closing buy order' stamp: 'vm 4/13/2025 20:41:34'!
receiveOrder: aRobot

	aRobot status receiveOrderWith: self.
	
	"aRobot status = #WorkingNormal ifTrue: [ | aTrailer | 
		aTrailer := aRobot trailer.	
		self assertTrailerNotEmpty: aTrailer.
		
		Comentario: en este punto el cashier realizaría el checkout de los productos.
		
		^ true
	]."

	"aRobot status = #SensorsFailure ifTrue: [ 	
		aRobot outOfOrder.
		self signalRobotSensorsFailure
	]."
	
	"aRobot status = #MechanicalFailure ifTrue: [ | aTrailer |
		aRobot outOfOrder.
		
		aTrailer := aRobot trailer.	
		self assertTrailerNotEmpty: aTrailer.
		
		Comentario: en este punto el cashier realizaría el checkout de los productos.

		^ true
	]."
! !


!Cashier methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:17:52'!
assertTrailerNotEmpty: aTrailer
	
	aTrailer isEmpty ifTrue: [self signalTrailerIsEmpty]! !

!Cashier methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:28:31'!
signalTrailerIsEmpty
	
	self error: self class trailerIsEmptyErrorDescription! !


!Cashier methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:28:03'!
signalRobotSensorsFailure
	
	self error: self class robotSensorsFailureErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'IRobot-Enunciado'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:03'!
robotSensorsFailureErrorDescription
	
	^ 'This robot presents sensors failures!!'! !

!Cashier class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:28:31'!
trailerIsEmptyErrorDescription
	
	^ 'This robots trailer is empty!!'! !


!classDefinition: #Product category: #'IRobot-Enunciado'!
Object subclass: #Product
	instanceVariableNames: 'weight height'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Product methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 10:39:55'!
initializeWith: aWeight and: aHeight
	
	weight := aWeight.
	height := aHeight.! !


!Product methodsFor: 'action' stamp: 'FRT 5/4/2020 10:38:22'!
carryBy: aTrailer	
	
	self subclassResponsibility! !


!Product methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:39:06'!
isStackable
	
	self subclassResponsibility! !


!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:30'!
height
	
	^ height! !

!Product methodsFor: 'accessing' stamp: 'FRT 5/4/2020 10:43:24'!
weight
	
	^ weight! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Product class' category: #'IRobot-Enunciado'!
Product class
	instanceVariableNames: ''!

!Product class methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:47:40'!
with: aWeight and: aHeight
	
	aWeight strictlyPositive ifFalse: [ self signalInvalidWeight ].
	aHeight strictlyPositive ifFalse: [ self signalInvalidHeight ].

	aWeight isInteger ifFalse: [ self signalWeightMustBeInteger ].
	aHeight isInteger ifFalse: [ self signalHeightMustBeInteger ].
	
	^ self new initializeWith: aWeight and: aHeight! !


!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:48:22'!
signalHeightMustBeInteger

	self error: self heightMustBeIntegerErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:29:08'!
signalInvalidHeight

	self error: self invalidHeightErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:29:18'!
signalInvalidWeight

	self error: self invalidWeightErrorDescription! !

!Product class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:48:12'!
signalWeightMustBeInteger

	self error: self weightMustBeIntegerErrorDescription! !


!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:16'!
heightMustBeIntegerErrorDescription

	^ 'Height must be integer'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:08'!
invalidHeightErrorDescription

	^ 'Height must be positive'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:18'!
invalidWeightErrorDescription

	^ 'Weight must be positive'! !

!Product class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:08'!
weightMustBeIntegerErrorDescription

	^ 'Weight must be integer'! !


!classDefinition: #ProductA category: #'IRobot-Enunciado'!
Product subclass: #ProductA
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!ProductA methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:41:29'!
isStackable

	^ false! !


!ProductA methodsFor: 'action' stamp: 'FRT 5/4/2020 10:41:12'!
carryBy: aTrailer

	aTrailer carryProductA: self! !


!classDefinition: #ProductB category: #'IRobot-Enunciado'!
Product subclass: #ProductB
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!ProductB methodsFor: 'testing' stamp: 'FRT 5/4/2020 10:42:28'!
isStackable

	^ true! !


!ProductB methodsFor: 'action' stamp: 'FRT 5/4/2020 10:42:16'!
carryBy: aTrailer

	aTrailer carryProductB: self! !


!classDefinition: #Robot category: #'IRobot-Enunciado'!
Object subclass: #Robot
	instanceVariableNames: 'status trailer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Robot methodsFor: 'actions' stamp: 'vm 4/13/2025 20:27:36'!
closeOrderUsing: aCashier
	status closeOrderUsing: aCashier.
	
	"status = #WorkingNormal ifTrue: [ ^ aCashier receiveOrder: self ].
	status = #SensorsFailure ifTrue: [ ^ aCashier receiveOrder: self ].
	status = #MechanicalFailure ifTrue: [ ^ aCashier receiveOrder: self ].
	status = #OutOfOrder ifTrue: [ ^ self class signalOutOfOrder ]."
! !

!Robot methodsFor: 'actions' stamp: 'vm 4/13/2025 20:26:56'!
closeOrderWhileFunctioningUsing: aCashier
	
	^ aCashier receiveOrder: self
! !

!Robot methodsFor: 'actions' stamp: 'vm 4/13/2025 20:31:10'!
closeOrderWhileOutOfOrder
	
	^ self class signalOutOfOrder.
	
	"status = #OutOfOrder ifTrue: [ ^ self class signalOutOfOrder ]."
! !

!Robot methodsFor: 'actions' stamp: 'vm 4/13/2025 20:23:08'!
take: aProduct
	status take: aProduct.

	"status = #WorkingNormal ifTrue: [ ^ trailer carry: aProduct ].
	status = #SensorsFailure ifTrue: [ ^ trailer carry: aProduct ].
	status = #MechanicalFailure ifTrue: [ ^ trailer carry: aProduct ].
	status = #OutOfOrder ifTrue: [ ^ self class signalOutOfOrder ]."
! !

!Robot methodsFor: 'actions' stamp: 'vm 4/13/2025 20:25:43'!
takeWhileFunctioning: aProduct

	^ trailer carry: aProduct
! !

!Robot methodsFor: 'actions' stamp: 'vm 4/13/2025 20:25:07'!
takeWhileOutOfOrder
	^ self class signalOutOfOrder.

	"status = #OutOfOrder ifTrue: [ ^ self class signalOutOfOrder ]."
! !


!Robot methodsFor: 'status' stamp: 'vm 4/13/2025 20:30:30'!
outOfOrder

	status := OutOfOrder robot: self.
! !

!Robot methodsFor: 'status' stamp: 'vm 4/13/2025 20:30:36'!
withMechanicalFailure

	status := MechanicalFailure robot: self.
! !

!Robot methodsFor: 'status' stamp: 'vm 4/13/2025 20:30:40'!
withSensorsFailure

	status := SensorsFailure robot: self.
! !


!Robot methodsFor: 'accessing' stamp: 'FRT 5/4/2020 18:35:21'!
status

	^ status
! !

!Robot methodsFor: 'accessing' stamp: 'FRT 5/3/2020 21:27:04'!
trailer

	^ trailer
! !


!Robot methodsFor: 'initialization' stamp: 'vm 4/13/2025 20:42:40'!
initializeWith: aTrailer

	trailer := aTrailer.
	status := (WorkingNormal robot: self).
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Robot class' category: #'IRobot-Enunciado'!
Robot class
	instanceVariableNames: ''!

!Robot class methodsFor: 'instance creation' stamp: 'FRT 5/3/2020 22:36:52'!
with: aTrailer

	self assertIsEmpty: aTrailer.

	^ self new initializeWith: aTrailer! !


!Robot class methodsFor: 'assertions' stamp: 'FRT 5/3/2020 22:35:35'!
assertIsEmpty: aTrailer

	^ aTrailer isEmpty ifFalse: [ self signalNotEmptyTrailer ]! !

!Robot class methodsFor: 'assertions' stamp: 'FRT 5/4/2020 11:29:32'!
signalNotEmptyTrailer

	self error: self notEmptyTrailerErrorDescription! !

!Robot class methodsFor: 'assertions' stamp: 'FRT 5/4/2020 18:26:04'!
signalOutOfOrder
	
	self error: self outOfOrderErrorDescription! !


!Robot class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:29:32'!
notEmptyTrailerErrorDescription

	^ 'The robot was assigned a non empty trailer'! !

!Robot class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 18:26:32'!
outOfOrderErrorDescription
	
	^ 'Robot out of order :('! !


!classDefinition: #RobotStatus category: #'IRobot-Enunciado'!
Object subclass: #RobotStatus
	instanceVariableNames: 'robot'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!RobotStatus methodsFor: 'nil' stamp: 'vm 4/13/2025 20:16:59'!
robot: aRobot
	robot := aRobot.! !


!RobotStatus methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 20:37:56'!
receiveOrderWith: aCashier
	self subclassResponsibility.! !

!RobotStatus methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 20:22:38'!
take: aProduct
	self subclassResponsibility.! !


!classDefinition: #MechanicalFailure category: #'IRobot-Enunciado'!
RobotStatus subclass: #MechanicalFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!


!MechanicalFailure methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 20:28:25'!
closeOrderUsing: aCashier
	robot closeOrderWhileFunctioningUsing: aCashier.! !

!MechanicalFailure methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 20:40:11'!
receiveOrderWith: aCashier
	 | aTrailer |
		robot outOfOrder.
		
		aTrailer := robot trailer.	
		aCashier assertTrailerNotEmpty: aTrailer.
		
		"Comentario: en este punto el cashier realizaría el checkout de los productos."

		^ true! !

!MechanicalFailure methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 20:26:01'!
take: aProduct
	robot takeWhileFunctioning: aProduct.! !


!classDefinition: #OutOfOrder category: #'IRobot-Enunciado'!
RobotStatus subclass: #OutOfOrder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!


!OutOfOrder methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 20:28:52'!
closeOrderUsing: aCashier
	robot closeOrderWhileOutOfOrder.! !

!OutOfOrder methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 20:38:55'!
receiveOrderWith: aCashier! !

!OutOfOrder methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 20:24:39'!
take: aProduct
	robot takeWhileOutOfOrder.! !


!classDefinition: #SensorsFailure category: #'IRobot-Enunciado'!
RobotStatus subclass: #SensorsFailure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!


!SensorsFailure methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 20:28:30'!
closeOrderUsing: aCashier
	robot closeOrderWhileFunctioningUsing: aCashier.! !

!SensorsFailure methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 20:39:59'!
receiveOrderWith: aCashier
	robot outOfOrder.
	aCashier signalRobotSensorsFailure.! !

!SensorsFailure methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 20:26:09'!
take: aProduct
	robot takeWhileFunctioning: aProduct.! !


!classDefinition: #WorkingNormal category: #'IRobot-Enunciado'!
RobotStatus subclass: #WorkingNormal
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!


!WorkingNormal methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 20:28:34'!
closeOrderUsing: aCashier
	robot closeOrderWhileFunctioningUsing: aCashier.! !

!WorkingNormal methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 20:39:51'!
receiveOrderWith: aCashier
	 | aTrailer | 
		aTrailer := robot trailer.	
		aCashier assertTrailerNotEmpty: aTrailer.
		
		^ true! !

!WorkingNormal methodsFor: 'as yet unclassified' stamp: 'vm 4/13/2025 20:26:15'!
take: aProduct
	robot takeWhileFunctioning: aProduct.! !


!classDefinition: #Trailer category: #'IRobot-Enunciado'!
Object subclass: #Trailer
	instanceVariableNames: 'weightCapacity heightCapacity container'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IRobot-Enunciado'!

!Trailer methodsFor: 'initialization' stamp: 'FRT 5/3/2020 23:27:42'!
initializeWith: aWeightCapacity and: aHeightCapacity

	weightCapacity := aWeightCapacity.
	heightCapacity := aHeightCapacity.
	
	container := OrderedCollection new.! !


!Trailer methodsFor: 'accessing' stamp: 'FRT 5/3/2020 23:34:36'!
totalProductsAmount
	
	^ container size.! !

!Trailer methodsFor: 'accessing' stamp: 'F 5/14/2020 10:35:03'!
totalProductsHeight
	"Solo importa la altura de los productos apilables"

	| total index |

	total := 0.
	index := 1.
	
	[index <= container size] whileTrue: [ | product |
		product := (container at: index).
		(product isStackable) ifTrue: [ total := total +  product height ].
		index := index + 1.	
	].

	^ total.! !

!Trailer methodsFor: 'accessing' stamp: 'F 5/14/2020 10:34:38'!
totalProductsWeight
	
	| total index |

	total := 0.
	index := 1.
	
	[index <= container size] whileTrue: [
		total := total + (container at: index) weight.
		index := index + 1.	
	].

	^ total.! !


!Trailer methodsFor: 'testing' stamp: 'FRT 5/3/2020 23:33:33'!
isEmpty
	
	^ container isEmpty! !


!Trailer methodsFor: 'action' stamp: 'FRT 5/3/2020 23:35:19'!
carry: aProduct
	
	^ aProduct carryBy: self.! !

!Trailer methodsFor: 'action' stamp: 'FRT 5/4/2020 19:08:17'!
carryProductA: aProduct
	
	self assertWeightAdding: aProduct.
	container add: aProduct.! !

!Trailer methodsFor: 'action' stamp: 'FRT 5/4/2020 19:08:09'!
carryProductB: aProduct

	self assertWeightAdding: aProduct.
	self assertHeightAdding: aProduct.
	
	container add: aProduct.! !


!Trailer methodsFor: 'assertions' stamp: 'vm 4/13/2025 20:59:56'!
assertHeightAdding: aProduct
	
	self assertThat: (self totalProductsHeight + aProduct height) isGreaterThan: heightCapacity andSignal: [self signalMaxHeightCapacityExceeded].
	! !

!Trailer methodsFor: 'assertions' stamp: 'vm 4/13/2025 21:00:27'!
assertWeightAdding: aProduct

	self assertThat: (self totalProductsWeight + aProduct weight) isGreaterThan: weightCapacity andSignal: [self signalMaxWeightCapacityExceeded].! !


!Trailer methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:31'!
signalMaxHeightCapacityExceeded

	self error: self class maxHeightExceededErrorDescription
! !

!Trailer methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:38'!
signalMaxWeightCapacityExceeded

	self error: self class maxWeightExceededErrorDescription
! !


!Trailer methodsFor: 'private' stamp: 'vm 4/13/2025 20:59:33'!
assertThat: aMeasuredAmount isGreaterThan: aCapacity andSignal: anExceededCapacitySignal
	aMeasuredAmount > aCapacity ifTrue: anExceededCapacitySignal.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Trailer class' category: #'IRobot-Enunciado'!
Trailer class
	instanceVariableNames: ''!

!Trailer class methodsFor: 'instance creation' stamp: 'FRT 5/4/2020 17:33:58'!
with: aWeightCapacity and: aHeightCapacity

	aWeightCapacity strictlyPositive ifFalse: [ self signalInvalidWeightCapacity ].
	aHeightCapacity strictlyPositive ifFalse: [ self signalInvalidHeightCapacity ].
	
	aWeightCapacity isInteger ifFalse: [ self signalWeightCapacityMustBeInteger ].
	aHeightCapacity isInteger ifFalse: [ self signalHeightCapacityMustBeInteger ].
		
	^ self new initializeWith: aWeightCapacity and: aHeightCapacity.

! !


!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:37:41'!
signalHeightCapacityMustBeInteger

	self error: self heightCapacityMustBeIntegerErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:12'!
signalInvalidHeightCapacity

	self error: self invalidHeightCapacityErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 11:30:21'!
signalInvalidWeightCapacity

	self error: self invalidWeightCapacityErrorDescription
! !

!Trailer class methodsFor: 'exceptions' stamp: 'FRT 5/4/2020 17:37:29'!
signalWeightCapacityMustBeInteger

	self error: self weightCapacityMustBeIntegerErrorDescription
! !


!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:38'!
heightCapacityMustBeIntegerErrorDescription

	^ 'Height capacity must be integer'! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:12'!
invalidHeightCapacityErrorDescription

	^ 'The trailers height capacity must be positive.'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:21'!
invalidWeightCapacityErrorDescription

	^ 'The trailers weight capacity must be positive.'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:31'!
maxHeightExceededErrorDescription

	^ 'Maximum height has been exceeded'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 11:30:38'!
maxWeightExceededErrorDescription

	^ 'Maximum weight has been exceeded'
! !

!Trailer class methodsFor: 'error messages' stamp: 'FRT 5/4/2020 17:49:32'!
weightCapacityMustBeIntegerErrorDescription

	^ 'Weight capacity must be integer'! !
