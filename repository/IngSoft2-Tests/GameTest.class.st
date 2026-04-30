Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test001WhenAGameIsCreatedThenItCanBePlayed [
	
	| aGame |
	aGame:= Game new.
	self deny: (aGame ended )
]

{ #category : 'tests' }
GameTest >> test002WhenAGameIsCreatedWithXNumberSquaresThenItsNumberOfSquaresIsX [
	
	| aGame aSize aDice aDiceCollection aNumberOfShips |
	aSize:=10.
	aDice := HardcodedDice with: 1.
	aNumberOfShips:=1.
	aDiceCollection:=(OrderedCollection with: aDice).
	aGame:= Game with:aSize and: aNumberOfShips and: aDiceCollection.
	self assert: aGame numberOfSquares equals: aSize 
]

{ #category : 'tests' }
GameTest >> test003WhenAGameWithOnePlayerIsCreatedThenThePlayerStartsAt1 [
	
	| aGame aSize aNumberOfShips aDice aDiceCollection |
	aNumberOfShips := 1.
	aSize:=10.
	aDice := HardcodedDice with: 1.
	aDiceCollection:=(OrderedCollection with: aDice).
	aGame:= Game with:aSize and: aNumberOfShips and: aDiceCollection.
	self assert: aGame standings first equals: 1.
]

{ #category : 'tests' }
GameTest >> test004WhenATurnIsPlayedThenTheFirstShipMovesAccordingly [
	
	| aGame aSize aNumberOfShips aDice aDiceCollection |
	aNumberOfShips := 1.
	aSize:=10.
	aDice := HardcodedDice with: 1.
	aDiceCollection:=(OrderedCollection with: aDice).
	aGame:= Game with:aSize and: aNumberOfShips and: aDiceCollection.
	aGame playTurn.
	self deny: aGame standings first equals: 1
]

{ #category : 'tests' }
GameTest >> test005WhenThePlayerRollsThreeThenHisShipsMovesForwardThreeSquares [
	
	| aGame aSize aNumberOfShips aDice aDiceCollection |
	aNumberOfShips := 1.
	aSize:=10.
	aDice := HardcodedDice with: 3.
	aDiceCollection:=(OrderedCollection with: aDice).
	aGame:= Game with:aSize and: aNumberOfShips and: aDiceCollection.
	aGame playTurn.
	self assert: aGame standings first equals: 4
]

{ #category : 'tests' }
GameTest >> test006WhenThePlayerRollsFourThenHisShipMovesForwardFourSquares [
	
	| aGame aSize aNumberOfShips aDice aDiceCollection |
	aNumberOfShips := 1.
	aSize:=10.
	aDice := HardcodedDice with: 4.
	aDiceCollection:=(OrderedCollection with: aDice).
	aGame:= Game with:aSize and: aNumberOfShips and: aDiceCollection.
	aGame playTurn.
	self assert: aGame standings first equals: 5
]

{ #category : 'tests' }
GameTest >> test007WhenGameIsCreatedWithMultipleShipsThenAllShipsStartAtPositionOne [
	
	| aGame aSize aNumberOfShips aDice aDiceCollection |
	aNumberOfShips := 2.
	aSize:=10.
	aDice := HardcodedDice with: 1.
	aDiceCollection:=(OrderedCollection with: aDice).
	aGame:= Game with:aSize and: aNumberOfShips and: aDiceCollection.
	self assert: ((aGame standings select:[:shipPosition| shipPosition ~=1]) isEmpty)
]

{ #category : 'tests' }
GameTest >> test008WhenGameIsCreatedWithMultipleShipsAndPlayTurnThenOnlyFirstShipMovesAccordingly [
	
	| aGame aSize aNumberOfShips aDice aDiceCollection |
	aNumberOfShips := 2.
	aSize:=10.
	aDice := HardcodedDice with: 3.
	aDiceCollection:=(OrderedCollection with: aDice).
	aGame:= Game with:aSize and: aNumberOfShips and: aDiceCollection.
	aGame playTurn.
	self assert:(( aGame standings first = 4) and: ((aGame standings select:[:aShipPosition|aShipPosition ~=1] )size = 1)).
	
]

{ #category : 'tests' }
GameTest >> test009WhenGameHasMultipleShipsAndPlayTurnTwiceThenSecondShipMoves [
	
	| aGame aSize aNumberOfShips aDice aDiceCollection |
	aNumberOfShips := 2.
	aSize:=10.
	aDice := HardcodedDice with: 3.
	aDiceCollection:=(OrderedCollection with: aDice).
	aGame:= Game with:aSize and: aNumberOfShips and: aDiceCollection.
	aGame playTurn.
	aGame playTurn.
	self assert: aGame standings second equals: 4
]

{ #category : 'tests' }
GameTest >> test010WhenGamePlaysTurnThenShipMovesByDiceRoll [
	
	| aGame aSize aNumberOfShips aDice aDiceCollection |
	aNumberOfShips := 1.
	aSize:=10.
	aDice := HardcodedDice with: 3.
	aDiceCollection:=(OrderedCollection with: aDice).
	aGame:= Game with:aSize and: aNumberOfShips and: aDiceCollection.
	aGame playTurn.

	self assert: aGame standings first equals: 4
]

{ #category : 'tests' }
GameTest >> test011WhenAllShipsHavePlayedThenTurnStartsAgainFromFirstShip [
	
	| aGame aSize aNumberOfShips aDice aDiceCollection |
	aNumberOfShips := 2.
	aSize:=10.
	aDice := HardcodedDice with: 3.
	aDiceCollection:=(OrderedCollection with: aDice).
	aGame:= Game with:aSize and: aNumberOfShips and: aDiceCollection.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: aGame standings first equals: 7.
	self assert: aGame standings second equals: 4.
]

{ #category : 'tests' }
GameTest >> test012WhenTheGameIsPlayedWithMultipleDicesThenThePlayerRollsAllOfThemAndTheShipMovesByTheTotalAmount [
	
	| aGame aSize aNumberOfShips aCollectionOfDices |
	aNumberOfShips := 1.
	aSize:=20.
	aCollectionOfDices:=OrderedCollection
	with: (HardcodedDice with: 3)
	with: (HardcodedDice with: 8)
	with: (HardcodedDice with: 2).
	aGame:= Game with:aSize and: aNumberOfShips and: aCollectionOfDices.
	aGame playTurn.
	self assert: aGame standings first equals: 14.

]
