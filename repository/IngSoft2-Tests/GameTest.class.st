Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test001WhenAGameIsCreatedThenItCanBePlayed [
	
	| aGame aSize aDice aDiceCollection aNumberOfShips |
	aSize:=10.
	aDice := HardcodedDice with: 1.
	aNumberOfShips:=2.
	aDiceCollection:=(OrderedCollection with: aDice).
	aGame:= Game with:aSize and: aNumberOfShips and: aDiceCollection.
	self deny: (aGame ended )
]

{ #category : 'tests' }
GameTest >> test002WhenAGameIsCreatedWithXNumberSquaresThenItsNumberOfSquaresIsX [
	
	| aGame aSize aDice aDiceCollection aNumberOfShips |
	aSize:=10.
	aDice := HardcodedDice with: 1.
	aNumberOfShips:=2.
	aDiceCollection:=(OrderedCollection with: aDice).
	aGame:= Game with:aSize and: aNumberOfShips and: aDiceCollection.
	self assert: aGame numberOfSquares equals: aSize 
]

{ #category : 'tests' }
GameTest >> test003WhenAGameWithOnePlayerIsCreatedThenThePlayerStartsAt1 [
	
	| aGame aSize aNumberOfShips aDice aDiceCollection |
	aNumberOfShips := 2.
	aSize:=10.
	aDice := HardcodedDice with: 1.
	aDiceCollection:=(OrderedCollection with: aDice).
	aGame:= Game with:aSize and: aNumberOfShips and: aDiceCollection.
	self assert: aGame standings first equals: 1.
]

{ #category : 'tests' }
GameTest >> test004WhenATurnIsPlayedThenTheFirstShipMovesAccordingly [
	
	| aGame aSize aNumberOfShips aDice aDiceCollection |
	aNumberOfShips := 2.
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
	aNumberOfShips := 2.
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
	aNumberOfShips := 2.
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
	aNumberOfShips := 2.
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
	aNumberOfShips := 2.
	aSize:=20.
	aCollectionOfDices:=OrderedCollection
	with: (HardcodedDice with: 3)
	with: (HardcodedDice with: 8)
	with: (HardcodedDice with: 2).
	aGame:= Game with:aSize and: aNumberOfShips and: aCollectionOfDices.
	aGame playTurn.
	self assert: aGame standings first equals: 14.

]

{ #category : 'tests' }
GameTest >> test013WhenTheGameIsPlayedWithMultipleDicesAndPlayersThenThePlayersRollAllOfThemAndTheShipsMoveByTheTotalAmounts [
	
	| aGame aSize aNumberOfShips aCollectionOfDices |
	aNumberOfShips := 3.
	aSize:=20.
	aCollectionOfDices:=OrderedCollection
	with: (HardcodedDice with: 3)
	with: (HardcodedDice with: 8)
	with: (HardcodedDice with: 2).
	aGame:= Game with:aSize and: aNumberOfShips and: aCollectionOfDices.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame standings select:[:aShipPosition| aShipPosition ~=14]) isEmpty.

]

{ #category : 'tests' }
GameTest >> test014WhenAShipReachesTheEndThenTheGameEnds [
	
	| aGame aSize aNumberOfShips aCollectionOfDices |
	aNumberOfShips := 2.
	aSize:=5.
	aCollectionOfDices:=OrderedCollection
	with: (HardcodedDice with: 4).
	aGame:= Game with:aSize and: aNumberOfShips and: aCollectionOfDices.
	aGame playTurn.
	self assert: (aGame ended).

]

{ #category : 'tests' }
GameTest >> test015WhenAGameEndedThenTurnsCannotBePlayed [
	
	| aGame aSize aNumberOfShips aCollectionOfDices |
	aNumberOfShips := 2.
	aSize:=5.
	aCollectionOfDices:=OrderedCollection
	with: (HardcodedDice with: 4).
	aGame:= Game with:aSize and: aNumberOfShips and: aCollectionOfDices.
	aGame playTurn.
	self should: [aGame playTurn]
	raise:Error
	withExceptionDo: [ :anError|self assert: anError messageText equals:'The Game ended, turns CANNOT be played' ]

]

{ #category : 'tests' }
GameTest >> test016WhenAnyShipReachesTheEndThenTheGameEnds [
	
	| aGame aSize aNumberOfShips aCollectionOfDices |
	aNumberOfShips := 3.
	aSize:=8.
	aCollectionOfDices:=OrderedCollection
	with: (HardcodedDice with: 4).
	aGame:= Game with:aSize and: aNumberOfShips and: aCollectionOfDices.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: aGame ended.
	

]

{ #category : 'tests' }
GameTest >> test017WhenAShipSurpassesTheEndThenItsPositionIsTheLastSquare [
	
	| aGame aSize aNumberOfShips aCollectionOfDices |
	aNumberOfShips := 3.
	aSize:=8.
	aCollectionOfDices:=OrderedCollection
	with: (HardcodedDice with: 4).
	aGame:= Game with:aSize and: aNumberOfShips and: aCollectionOfDices.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: aGame standings first equals: aSize.
	

]

{ #category : 'tests' }
GameTest >> test018WhenAGameIsEndedThenTheStandingsReflectTheWinnerAndTheOthersEndPosition [
	
	| aGame aSize aNumberOfShips aCollectionOfDices |
	aNumberOfShips := 3.
	aSize:=8.
	aCollectionOfDices:=OrderedCollection
	with: (HardcodedDice with: 4).
	aGame:= Game with:aSize and: aNumberOfShips and: aCollectionOfDices.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: aGame standings equals: #(8 5 5) asOrderedCollection.
	

]

{ #category : 'tests' }
GameTest >> test019WhenAGameIsCreatedWithOneShipOrLessThenShouldThrowError [
	
	| aSize aNumberOfShips aCollectionOfDices |
	aNumberOfShips := 1.
	aSize:=8.
	aCollectionOfDices:=OrderedCollection
	with: (HardcodedDice with: 4).
	self should: [Game with:aSize and: aNumberOfShips and: aCollectionOfDices ] 
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'There must be at least two ships' ]
	

]

{ #category : 'tests' }
GameTest >> test020WhenAGameIsCreatedWithNoDiceThenShouldThrowError [
	
	| aSize aNumberOfShips aCollectionOfDices |
	aNumberOfShips := 4.
	aSize:=8.
	aCollectionOfDices:=OrderedCollection new.
	self should: [Game with:aSize and: aNumberOfShips and: aCollectionOfDices ] 
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'There must be at least one dice' ]
	

]

{ #category : 'tests' }
GameTest >> test021WhenAGameIsCreatedWithNullBoardThenShouldThrowError [
	
	| aSize aNumberOfShips aCollectionOfDices |
	aNumberOfShips := 4.
	aSize:=0.
	aCollectionOfDices:=OrderedCollection
	with: (HardcodedDice with: 4).
	self should: [Game with:aSize and: aNumberOfShips and: aCollectionOfDices ] 
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'Board cannot be nil or size be zero' ]
	

]

{ #category : 'tests' }
GameTest >> test022WhenAGameEndsTheWinnerCanBeKnown [
	
	| aGame aSize aNumberOfShips aCollectionOfDices |
	aNumberOfShips := 2.
	aSize:=8.
	aCollectionOfDices:=OrderedCollection
	with: (HardcodedDice with: 4).
	aGame:= Game with:aSize and: aNumberOfShips and: aCollectionOfDices.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
		
	self assert: aGame winner equals: 1.

]

{ #category : 'tests' }
GameTest >> test023WhenAGameIsNotOverThenThereIsNoWinner [
	
	| aGame aSize aNumberOfShips aCollectionOfDices |
	aNumberOfShips := 2.
	aSize:=14.
	aCollectionOfDices:=OrderedCollection
	with: (HardcodedDice with: 4).
	aGame:= Game with:aSize and: aNumberOfShips and: aCollectionOfDices.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self should: [ aGame winner ]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'Game is not over yet' ].

]
