Class {
	#name : 'ShipTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ShipTest >> test001WhenAShipIsCreatedThenItsHasItsRespectiveIdAndStartsAt1 [
	
	| aShip anId |
	anId:=1.
	aShip:= Ship knownBy: anId.
	self assert: (aShip id = anId and:(aShip position = 1)).
]

{ #category : 'tests' }
ShipTest >> test002WhenAShipMovesForwardThenItsPositionChangesAccordingly [
	
	| aShip anId |
	anId:=1.
	aShip:= Ship knownBy: anId.
	
	aShip moveForward: 5.
	self assert: aShip position equals: 6.
]

{ #category : 'tests' }
ShipTest >> test003WhenTheAmountOfSquaresToMoveForwardIsLessThan1ThenTheAmountOfSquaresIsInvalid [
	| aShip anId |
	anId:=1.
	aShip:= Ship knownBy: anId.
	
	self should: [aShip moveForward: 0]
	
	raise: Error
	withExceptionDo: [:anError | self assert: anError messageText equals:'A ship cannot move forward less than 1 square']
	
	
]
