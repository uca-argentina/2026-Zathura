Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#instVars : [
		'aGame',
		'aBoard',
		'aCollectionOfDices',
		'aCollectionOfShips'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
GameTest >> setUp [ 
	|aDice walter danny lisa|
	walter:= Ship named: 'Walter'.
	danny:= Ship named: 'Danny'.
	lisa:= Ship named: 'Lisa'.
	aDice := LoadedDice with: 3.
   aBoard := Board withSize: 20 and: NoEffect new .
	aCollectionOfDices:= (OrderedCollection with: aDice).
	aCollectionOfShips := { walter. danny. lisa }.
	aGame:= Game with: aBoard and: aCollectionOfShips and: aCollectionOfDices.
]

{ #category : 'tests' }
GameTest >> test001WhenAGameIsCreatedThenItCanBePlayed [
	
	self deny: (aGame ended )
]

{ #category : 'tests' }
GameTest >> test002WhenAGameIsCreatedWithXNumberSquaresThenItsNumberOfSquaresIsX [
	
	self assert: (aBoard numSquares) equals: 20
]

{ #category : 'tests' }
GameTest >> test003WhenAGameWithShipsIsCreatedThenTheShipsStartsAt1 [
	
	self assert: aGame standings first equals: 1.
]

{ #category : 'tests' }
GameTest >> test004WhenATurnIsPlayedThenTheFirstShipMovesAccordingly [
	
	aGame playTurn.
	self deny: aGame standings first equals: 1
]

{ #category : 'tests' }
GameTest >> test005WhenTheShipRollsThreeThenHisShipMovesForwardThreeSquares [
	aGame playTurn.
	self assert: aGame standings first equals: 4
]

{ #category : 'tests' }
GameTest >> test006WhenTheShipRollsFourThenHisShipMovesForwardFourSquares [
	|aDiceCollection|
	aDiceCollection:=(OrderedCollection with: (LoadedDice with: 4)).
	aGame:= Game with:aBoard and: aCollectionOfShips and: aDiceCollection.
	aGame playTurn.
	self assert: aGame standings first equals: 5
]

{ #category : 'tests' }
GameTest >> test007WhenGameIsCreatedWithMultipleShipsThenAllShipsStartAtPositionOne [
	
	self assert: ((aGame standings select:[:shipPosition| shipPosition ~=1]) isEmpty)
]

{ #category : 'tests' }
GameTest >> test008WhenGameIsCreatedWithMultipleShipsAndPlayTurnThenOnlyFirstShipMovesAccordingly [
	
	aGame playTurn.
	self assert:(( aGame standings first = 4) and: ((aGame standings select:[:aShipPosition|aShipPosition ~=1] )size = 1)).
	
]

{ #category : 'tests' }
GameTest >> test009WhenGameHasMultipleShipsAndPlayTurnTwiceThenSecondShipMoves [
	
	aGame playTurn.
	aGame playTurn.
	self assert: aGame standings second equals: 4
]

{ #category : 'tests' }
GameTest >> test010WhenGamePlaysTurnThenShipMovesByDiceRoll [
	
	aGame playTurn.

	self assert: aGame standings first equals: 4
]

{ #category : 'tests' }
GameTest >> test011WhenAllShipsHavePlayedThenTurnStartsAgainFromFirstShip [
	
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: aGame standings first equals: 7.
	self assert: aGame standings second equals: 4.
]

{ #category : 'tests' }
GameTest >> test012WhenTheGameIsPlayedWithMultipleDicesThenTheShipRollsAllOfThemAndTheShipMovesByTheTotalAmount [

	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 3)
	with: (LoadedDice with: 8)
	with: (LoadedDice with: 2).
	aGame:= Game with:aBoard and: aCollectionOfShips and: aCollectionOfDices.
	aGame playTurn.
	self assert: aGame standings first equals: 14.

]

{ #category : 'tests' }
GameTest >> test013WhenTheGameIsPlayedWithMultipleDicesAndShipsThenAShipRollAllOfThemAndTheShipsMoveByTheTotalAmounts [
	
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 3)
	with: (LoadedDice with: 8)
	with: (LoadedDice with: 2).
	aGame:= Game with:aBoard and: aCollectionOfShips and: aCollectionOfDices.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame standings select:[:aShipPosition| aShipPosition ~=14]) isEmpty.

]

{ #category : 'tests' }
GameTest >> test014WhenAShipReachesTheEndThenTheGameEnds [
	
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 19).
	aGame:= Game with:aBoard and: aCollectionOfShips and: aCollectionOfDices.
	aGame playGame.
	self assert: (aGame ended).

]

{ #category : 'tests' }
GameTest >> test015WhenAGameEndedThenTurnsCannotBePlayed [
	
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 19).
	aGame:= Game with:aBoard and: aCollectionOfShips and: aCollectionOfDices.
	aGame playTurn.
	self should: [aGame playTurn]
	raise:Error
	withExceptionDo: [ :anError|self assert: anError messageText equals:'The Game ended, turns CANNOT be played' ]

]

{ #category : 'tests' }
GameTest >> test016WhenAnyShipReachesTheEndThenTheGameEnds [
	
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 19).
	aGame:= Game with:aBoard and: aCollectionOfShips and: aCollectionOfDices.
	aGame playGame.
	
	self assert: aGame ended.
	

]

{ #category : 'tests' }
GameTest >> test017WhenAShipSurpassesTheEndThenItsPositionIsTheLastSquare [
	
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 7).
	aGame:= Game with:aBoard and: aCollectionOfShips and: aCollectionOfDices.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: aGame standings first equals: aBoard numSquares.
	

]

{ #category : 'tests' }
GameTest >> test018WhenAGameIsEndedThenTheStandingsReflectTheWinnerAndTheOthersEndPosition [

	aGame playGame.
	
	self assert: aGame standings equals: #(20 19 19) asOrderedCollection.
	

]

{ #category : 'tests' }
GameTest >> test019WhenAGameIsCreatedWithOneShipOrLessThenShouldThrowError [
	
	self should: [Game with:aBoard and: {Ship named: 'Walter'} and: aCollectionOfDices ] 
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'There must be at least two ships' ]
	

]

{ #category : 'tests' }
GameTest >> test020WhenAGameIsCreatedWithNoDiceThenShouldThrowError [
	
	aCollectionOfDices:=OrderedCollection new.
	self should: [Game with:aBoard and:aCollectionOfShips and: aCollectionOfDices ] 
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'There must be at least one dice' ]
	

]

{ #category : 'tests' }
GameTest >> test021WhenAGameIsCreatedWithNullBoardThenShouldThrowError [

    self should: [ Game with: nil and: aCollectionOfShips and: aCollectionOfDices ]
    raise: Error
    withExceptionDo: [ :anError | self assert: anError messageText equals: 'Board cannot be nil' ].

]

{ #category : 'tests' }
GameTest >> test022WhenAGameEndsTheWinnerCanBeKnown [
	
	aGame playGame.
		
	self assert: aGame winner equals: 1.

]

{ #category : 'tests' }
GameTest >> test023WhenAGameIsNotOverThenThereIsNoWinner [
	
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self should: [ aGame winner ]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'Game is not over yet' ].

]

{ #category : 'tests' }
GameTest >> test024WhenASquareIsSpeedUpThenTheShipMovesFourSquaresMore [
	
	 aBoard := Board withSize: 20 and: SpeedUp new.
	aGame:= Game with:aBoard and: aCollectionOfShips and: aCollectionOfDices.
	aGame playTurn.
	
	self assert: aGame standings first equals: 8.
	

]

{ #category : 'tests' }
GameTest >> test025WhenASquareIsWormHoleThenTheShipMovesFourSquaresBack [
	
	 aBoard := Board withSize: 20 and: WormHole new.
	aCollectionOfDices:= (OrderedCollection with: (LoadedDice with: 6)).
	aGame:= Game with:aBoard and: aCollectionOfShips and: aCollectionOfDices.
	aGame playTurn.
	
	self assert: aGame standings first equals: 3.
	

]

{ #category : 'tests' }
GameTest >> test026WhenASquareIsAtomicBombThenAllShipsGoBackToFirstSquare [
	
	 aBoard := Board withSize: 20 and: AtomicBomb new.
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 6).
	aGame:= Game with:aBoard and: aCollectionOfShips and: aCollectionOfDices.
	aGame playTurn.
	
	self assert: aGame standings equals: #(1 1 1) asOrderedCollection.
	

]

{ #category : 'tests' }
GameTest >> test027WhenASquareIsMoonWalkThenAllOtherShipsMoveBackNSquares [
	
	 aBoard := Board withSize: 20 and: (MoonWalk with: 2).
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 6).
	aGame:= Game with:aBoard and: aCollectionOfShips and: aCollectionOfDices.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: aGame standings equals: #(11 3 3) asOrderedCollection.
	

]
