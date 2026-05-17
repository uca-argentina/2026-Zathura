Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#instVars : [
		'walter',
		'danny',
		'lisa',
		'aDice',
		'aBoard',
		'aCollectionOfDices',
		'aCollectionOfShips',
		'aGame'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
GameTest >> setUp [ 
	
	super setUp.
	walter:= Ship named: 'Walter'.
	danny:= Ship named: 'Danny'.
	lisa:= Ship named: 'Lisa'.
	aDice := LoadedDice with: 3.
   aBoard := Board withSize: 20 and: NoEffect new .
	aCollectionOfDices:= (OrderedCollection with: aDice).
	aCollectionOfShips := { walter. danny. lisa }.
	aGame:= Game playedOn: aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	
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
	
	self assert: (aGame standings at:'Walter' ) equals: 1.
]

{ #category : 'tests' }
GameTest >> test004WhenATurnIsPlayedThenTheFirstShipMovesAccordingly [
	
	aGame playTurn.
	self deny: (aGame standings at:'Walter' ) equals: 1
]

{ #category : 'tests' }
GameTest >> test005WhenTheShipRollsThreeThenHisShipMovesForwardThreeSquares [
	aGame playTurn.
	self assert: (aGame standings at:'Walter' )  equals: 4
]

{ #category : 'tests' }
GameTest >> test006WhenTheShipRollsFourThenHisShipMovesForwardFourSquares [
	|aDiceCollection|
	aDiceCollection:=(OrderedCollection with: (LoadedDice with: 4)).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aDiceCollection.
	aGame playTurn.
	self assert: (aGame standings at:'Walter' ) equals: 5
]

{ #category : 'tests' }
GameTest >> test007WhenGameIsCreatedWithMultipleShipsThenAllShipsStartAtPositionOne [
	
	self assert: ((aGame standings select:[:shipPosition| shipPosition ~=1]) isEmpty)
]

{ #category : 'tests' }
GameTest >> test008WhenGameIsCreatedWithMultipleShipsAndPlayTurnThenOnlyFirstShipMovesAccordingly [
	
	| standings |
	aGame playTurn.
	standings:=aGame standings.
	self assert: (standings at:'Walter') equals: 4 .
	self assert: (standings keys select:[:aShipsName| (standings at:aShipsName) ~=1] )size equals: 1.
	
]

{ #category : 'tests' }
GameTest >> test009WhenGameHasMultipleShipsAndPlayTurnTwiceThenSecondShipMoves [
	
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame standings at:'Danny') equals: 4
]

{ #category : 'tests' }
GameTest >> test010WhenGamePlaysTurnThenShipMovesByDiceRoll [
	
	aGame playTurn.

	self assert: (aGame standings at:'Walter') equals: 4
]

{ #category : 'tests' }
GameTest >> test011WhenAllShipsHavePlayedThenTurnStartsAgainFromFirstShip [
	
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame standings at: 'Walter') equals: 7.
	self assert: (aGame standings at: 'Danny') equals: 4.
]

{ #category : 'tests' }
GameTest >> test012WhenTheGameIsPlayedWithMultipleDicesThenTheShipRollsAllOfThemAndTheShipMovesByTheTotalAmount [

	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 3)
	with: (LoadedDice with: 8)
	with: (LoadedDice with: 2).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	self assert: (aGame standings at: 'Walter') equals: 14.

]

{ #category : 'tests' }
GameTest >> test013WhenTheGameIsPlayedWithMultipleDicesAndShipsThenAShipRollAllOfThemAndTheShipsMoveByTheTotalAmounts [
	
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 3)
	with: (LoadedDice with: 8)
	with: (LoadedDice with: 2).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame standings select:[:aShipPosition| aShipPosition ~=14]) isEmpty.

]

{ #category : 'tests' }
GameTest >> test014WhenAShipReachesTheEndThenTheGameEnds [
	
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 19).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playGame.
	self assert: (aGame ended).

]

{ #category : 'tests' }
GameTest >> test015WhenAGameEndedThenTurnsCannotBePlayed [
	
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 19).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	self should: [aGame playTurn]
	raise:Error
	withExceptionDo: [ :anError|self assert: anError messageText equals:'The Game ended, turns CANNOT be played' ]

]

{ #category : 'tests' }
GameTest >> test016WhenAnyShipReachesTheEndThenTheGameEnds [
	
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 19).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playGame.
	
	self assert: aGame ended.
	

]

{ #category : 'tests' }
GameTest >> test017WhenAShipSurpassesTheEndThenItsPositionIsTheLastSquare [
	
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 7).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: (aGame standings at:'Walter') equals: aBoard numSquares.
	

]

{ #category : 'tests' }
GameTest >> test018WhenAGameIsEndedThenTheStandingsReflectTheWinnerAndTheOthersEndPosition [

	aGame playGame.

	self assert: (aGame standings at: 'Walter') equals: 20.
	self assert: (aGame standings at: 'Danny') equals: 19.
	self assert: (aGame standings at: 'Lisa') equals: 19.

	

]

{ #category : 'tests' }
GameTest >> test019WhenAGameIsCreatedWithOneShipOrLessThenShouldThrowError [
	
	self should: [Game playedOn:aBoard by: {Ship named: 'Walter'} throwing: aCollectionOfDices ] 
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'There must be at least two ships' ]
	

]

{ #category : 'tests' }
GameTest >> test020WhenAGameIsCreatedWithNoDiceThenShouldThrowError [
	
	aCollectionOfDices:=OrderedCollection new.
	self should: [Game playedOn:aBoard by:aCollectionOfShips throwing: aCollectionOfDices ] 
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'There must be at least one dice' ]
	

]

{ #category : 'tests' }
GameTest >> test021WhenAGameIsCreatedWithNullBoardThenShouldThrowError [

    self should: [ Game playedOn: nil by: aCollectionOfShips throwing: aCollectionOfDices ]
    raise: Error
    withExceptionDo: [ :anError | self assert: anError messageText equals: 'Board cannot be nil' ].

]

{ #category : 'tests' }
GameTest >> test022WhenAGameEndsTheWinnerCanBeKnown [
	
	aGame playGame.
		
	self assert: aGame whoWon equals: 'Walter'.

]

{ #category : 'tests' }
GameTest >> test023WhenAGameIsNotOverThenThereIsNoWinner [
	
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self should: [ aGame whoWon ]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'Game is not over yet' ].

]

{ #category : 'tests' }
GameTest >> test024WhenASquareIsSpeedUpThenTheShipMovesFourSquaresMore [
	
	 aBoard := Board withSize: 20 and: SpeedUp new.
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	
	self assert: (aGame standings at: 'Walter') equals: 8.
	

]

{ #category : 'tests' }
GameTest >> test025WhenASquareIsWormHoleThenTheShipMovesFourSquaresBack [
	
	 aBoard := Board withSize: 20 and: WormHole new.
	aCollectionOfDices:= (OrderedCollection with: (LoadedDice with: 6)).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	
	self assert: (aGame standings at: 'Walter') equals: 3.
	

]

{ #category : 'tests' }
GameTest >> test026WhenASquareIsAtomicBombThenAllShipsGoBackToFirstSquare [
	
	 aBoard := Board withSize: 20 and: AtomicBomb new.
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 6).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	
	self assert: (aGame standings at: 'Walter') equals: 1.
	self assert: (aGame standings at: 'Danny') equals: 1.
	self assert: (aGame standings at: 'Lisa') equals: 1.
	

]

{ #category : 'tests' }
GameTest >> test027WhenASquareIsMoonWalkThenAllOtherShipsMoveBackNSquares [
	
	 aBoard := Board withSize: 20 and: (MoonWalk with: 2).
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 6).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: (aGame standings at: 'Walter') equals: 11.
	self assert: (aGame standings at: 'Danny') equals: 5.
	self assert: (aGame standings at: 'Lisa') equals: 7.
	

]

{ #category : 'tests' }
GameTest >> test028WhenAShipsTriesToPlayInAnotherShipsTurnThenTheShipCannotPlay [
	aGame playTurnFor: walter.
	self should: [aGame playTurnFor:walter ]
	raise: Error
	withExceptionDo: [ :anError| self assert: anError messageText equals: 'It is not this ships turn' ]
	
	

]

{ #category : 'tests' }
GameTest >> test029WhenTwoShipsAreNameTheSameThenTheGameCannotBeCreated [
	| walter2 aColl2 |
	walter2:= Ship named: 'Walter'.
	aColl2:= OrderedCollection with:walter with:danny with:walter2. 
	self should: [Game playedOn: aBoard by: aColl2 throwing:aCollectionOfDices.]
	raise: Error
	withExceptionDo: [ :anError| self assert: anError messageText equals: 'There CANNOT be two ships named the same way' ]
	
	

]

{ #category : 'tests' }
GameTest >> test030WhenASquareIsHyperJumpThenShipAdvancesByFirstValueInList [
	
	 aBoard := Board withSize: 20 and: (HyperJump with: #(10 5 2)).
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 6).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	
	self assert: (aGame standings at: 'Walter') equals: 17.

	

]

{ #category : 'tests' }
GameTest >> test031WhenAllHyperJumpValuesAreUsedThenListResets [
	
	 aBoard := Board withSize: 40 and: (HyperJump with: #(10 5 2)).
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 6).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: (aGame standings at: 'Walter') equals: 33.
	self assert: (aGame standings at: 'Danny') equals: 12.
	self assert: (aGame standings at: 'Lisa') equals: 9.
	

]

{ #category : 'tests' }
GameTest >> test032WhenAShipsPositionIsRequestedThenThatShipsPositionIsRevealed [
	
	aGame playTurnFor: walter.
	aGame playTurn.
	aGame playTurn.
	aGame playTurnFor: walter.
	
	self assert: (aGame positionOf:walter) equals: 7.
	

]

{ #category : 'tests' }
GameTest >> test033WhenAnUnknownShipsPositionIsRequestedThenThatRequestIsDenied [
	
	| darthVadersTieFighter |
	darthVadersTieFighter:= Ship named: 'darthVadersTieFighter'.
	
	self should: [aGame positionOf:darthVadersTieFighter]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'This ship is not playing this game' ]
	
]

{ #category : 'tests' }
GameTest >> test034WhenRankingsIsCalledThenItReturnsShipsOrderedByPosition [

	| ranking secondAndThird |
	aGame playTurnFor:walter; 
			playTurnFor:danny;
			playTurnFor:lisa;
			playTurnFor:walter.
	
	ranking:=aGame ranking.
	self assert: (ranking at: 1) equals: 'Walter'.
	secondAndThird := (Array with: (ranking at: 2) with: (ranking at: 3)) asSet.
	self assert: secondAndThird equals: (Set with: 'Danny' with: 'Lisa')
]

{ #category : 'tests' }
GameTest >> test035WhenARequestForAShipsRankingIsMadeThenThatShipsRankingIsTheResponse [

	aGame playTurnFor:walter.
	aGame playTurnFor: danny.
	
	self assert: (aGame rankingFor:lisa) equals:3
]

{ #category : 'tests' }
GameTest >> test036WhenARequestForAnUnknownShipsRankingIsMadeThenThatRequestIsDenied [

	| darthVadersTieFighter |
	darthVadersTieFighter:= Ship named: 'darthVadersTieFighter'.
	
	self should: [aGame rankingFor:darthVadersTieFighter]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'This ship is not playing this game' ].
]

{ #category : 'tests' }
GameTest >> test037WhenAShipReachesTheEndOfANotFinalLapThenTheGameDoesNotEnd [
	
	| aNumberOfLaps |
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 13).
	aNumberOfLaps:=2.
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices winningWith: aNumberOfLaps.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self deny: (aGame ended).

]

{ #category : 'tests' }
GameTest >> test038WhenAShipReachesTheEndOfAFinalLapThenTheGameEnds [
	
	| aNumberOfLaps |
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 20).
	aNumberOfLaps:=2.
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices winningWith: aNumberOfLaps.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame ended).

]
