Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> test001WhenShipIsCreatedThenPositionIsOne [
	| aShip |
	
	aShip := Ship new.
	
	self assert: aShip position = 1.
]

{ #category : 'tests' }
ShipTest >> test002WhenShipMovesThenPositionIncreases [
	| aShip |
	
	aShip := Ship new.
	aShip moveBy: 3.
	
	self assert: aShip position equals: 4.
]

{ #category : 'tests' }
ShipTest >> test003WhenAShipTriesToMoveBy0orLowerThenTheShipsMovementIsInvalid [
	| aShip |
	
	aShip := Ship new.
	self should:[aShip moveBy: 0]
	raise: Error 
	withExceptionDo: [:anError| self assert: anError messageText equals:'The Ship must move by at least 1 square'  ]

]
