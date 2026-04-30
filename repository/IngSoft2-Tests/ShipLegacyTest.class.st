Class {
	#name : 'ShipLegacyTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipLegacyTest >> test001WhenAShipIsCreatedThenItsHasItsRespectiveIdAndStartsAt1 [
	
	| aShip anId |
	anId:=1.
	aShip:= ShipLegacy knownBy: anId.
	self assert: (aShip id = anId and:(aShip position = 1)).
]

{ #category : 'tests' }
ShipLegacyTest >> test002WhenAShipMovesForwardThenItsPositionChangesAccordingly [
	
	| aShip anId |
	anId:=1.
	aShip:= ShipLegacy knownBy: anId.
	
	aShip moveForward: 5.
	self assert: aShip position equals: 6.
]

{ #category : 'tests' }
ShipLegacyTest >> test003WhenTheAmountOfSquaresToMoveForwardIsLessThan1ThenTheAmountOfSquaresIsInvalid [
	| aShip anId |
	anId:=1.
	aShip:= ShipLegacy knownBy: anId.
	
	self should: [aShip moveForward: 0]
	
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals:'A ship cannot move forward less than 1 square']
	
	
]
