Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> test001WhenShipIsCreatedThenPositionIsOne [
	| aShip |
	
	aShip := Ship named: 'Walter' using: CardProvider new.
	
	self assert: aShip position equals: 1.
]

{ #category : 'tests' }
ShipTest >> test002WhenShipMovesThenPositionIncreases [
	| aShip |
	
	aShip := Ship named: 'Walter' using: CardProvider new.
	aShip moveBy: 3.
	
	self assert: aShip position equals: 4.
]

{ #category : 'tests' }
ShipTest >> test003WhenAShipTriesToMoveBy0orLowerThenTheShipsMovementIsInvalid [
	| aShip |
	
	aShip := Ship named: 'Walter' using: CardProvider new.
	self should:[aShip moveBy: 0]
	raise: Error 
	withExceptionDo: [:anError| self assert: anError messageText equals:'The Ship must move by at least 1 square'  ]

]

{ #category : 'tests' }
ShipTest >> test004WhenAShipIsCreatedThenItsStartsAtLap0 [
	| aShip |
	
	aShip := Ship named: 'Walter' using: CardProvider new.
	self assert: aShip lap equals: 0.
]

{ #category : 'tests' }
ShipTest >> test005WhenAShipTriesToMoveBackBy0orLowerThenTheShipsMovementIsInvalid [
	| aShip |
	
	aShip := Ship named: 'Walter' using: CardProvider new.
	self should:[aShip moveBack: 0]
	raise: Error 
	withExceptionDo: [:anError| self assert: anError messageText equals:'The Ship must move by at least 1 square back'  ]

]

{ #category : 'tests' }
ShipTest >> test006WhenAShipIsCreatedThenItHasTwoRandomCards [
	| aShip provider|
	provider := CardProvider new.
	aShip := Ship named: 'Walter' using: provider .
	self assert: aShip cardsSize equals: 2.
	
]

{ #category : 'tests' }
ShipTest >> test007WhenTwoShipsHaveTheSameNameThenTheyHaveTheSameHash [ 
	| ship1 ship2 |
	ship1 := Ship named: 'Walter' using: CardProvider new.
	ship2 := Ship named: 'Walter' using: CardProvider new.
	self assert: ship1 hash equals: ship2 hash.

]
