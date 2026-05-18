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
   aBoard := LoadedBoard withSize: 20 and: NoEffect new .
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
	
	self assert: (aGame squares at:'Walter') equals: 1.
]

{ #category : 'tests' }
GameTest >> test004WhenATurnIsPlayedThenTheFirstShipMovesAccordingly [
	
	aGame playTurn.
	self deny: (aGame squares at:'Walter' ) equals: 1
]

{ #category : 'tests' }
GameTest >> test005WhenTheShipRollsThreeThenHisShipMovesForwardThreeSquares [
	aGame playTurn.
	self assert: (aGame squares at:'Walter' )  equals: 4
]

{ #category : 'tests' }
GameTest >> test006WhenTheShipRollsFourThenHisShipMovesForwardFourSquares [
	|aDiceCollection|
	aDiceCollection:=(OrderedCollection with: (LoadedDice with: 4)).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aDiceCollection.
	aGame playTurn.
	self assert: (aGame squares at:'Walter' ) equals: 5
]

{ #category : 'tests' }
GameTest >> test007WhenGameIsCreatedWithMultipleShipsThenAllShipsStartAtPositionOne [
	
	self assert: ((aGame squares select:[:shipPosition| shipPosition ~=1]) isEmpty)
]

{ #category : 'tests' }
GameTest >> test008WhenGameIsCreatedWithMultipleShipsAndPlayTurnThenOnlyFirstShipMovesAccordingly [
	
	| standings |
	aGame playTurn.
	standings:=aGame squares.
	self assert: (standings at:'Walter') equals: 4 .
	self assert: (standings keys select:[:aShipsName| (standings at:aShipsName) ~=1] )size equals: 1.
	
]

{ #category : 'tests' }
GameTest >> test009WhenGameHasMultipleShipsAndPlayTurnTwiceThenSecondShipMoves [
	
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame squares at:'Danny') equals: 4
]

{ #category : 'tests' }
GameTest >> test010WhenGamePlaysTurnThenShipMovesByDiceRoll [
	
	aGame playTurn.

	self assert: (aGame squares at:'Walter') equals: 4
]

{ #category : 'tests' }
GameTest >> test011WhenAllShipsHavePlayedThenTurnStartsAgainFromFirstShip [
	
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.

	self assert: (aGame squares at: 'Walter') equals: 7.
	self assert: (aGame squares at: 'Danny') equals: 4.
]

{ #category : 'tests' }
GameTest >> test012WhenTheGameIsPlayedWithMultipleDicesThenTheShipRollsAllOfThemAndTheShipMovesByTheTotalAmount [

	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 3)
	with: (LoadedDice with: 8)
	with: (LoadedDice with: 2).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	self assert: (aGame squares at: 'Walter') equals: 14.

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
	self assert: (aGame squares select:[:aShipPosition| aShipPosition ~=14]) isEmpty.

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
	with: (LoadedDice with: 20).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	self should: [aGame playTurn]
	raise:Error
	withExceptionDo: [ :anError|self assert: anError messageText equals:'The Game ended, turns CANNOT be played' ]

]

{ #category : 'tests' }
GameTest >> test016WhenAnyShipReachesTheEndThenTheGameEnds [
	
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 20).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playGame.
	
	self assert: aGame ended.
	

]

{ #category : 'tests' }
GameTest >> test017WhenAShipSurpassesTheEndOfTheBoardThenItWrapsAroundAndContinues [
    aCollectionOfDices := OrderedCollection with: (LoadedDice with: 7).
    aGame := Game 
        playedOn: aBoard 
        by: aCollectionOfShips 
        throwing: aCollectionOfDices 
        winningWith: 2.
    7 timesRepeat: [ aGame playTurn ].

	 self assert: (aGame squares at: 'Walter') equals: 2.
    self deny: aGame ended

]

{ #category : 'tests' }
GameTest >> test018WhenAGameIsEndedThenTheStandingsReflectTheWinnerAndTheOthersEndPosition [

	aGame playGame.

	self assert: (aGame squares at: 'Walter') equals: 2.
	self assert: (aGame squares at: 'Danny') equals: 19.
	self assert: (aGame squares at: 'Lisa') equals: 19.

	

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
	
	 aBoard := LoadedBoard withSize: 20 and: SpeedUp new.
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	
	self assert: (aGame squares at: 'Walter') equals: 8.
	

]

{ #category : 'tests' }
GameTest >> test025WhenASquareIsWormHoleThenTheShipMovesFourSquaresBack [
	
	 aBoard := LoadedBoard withSize: 20 and: WormHole new.
	aCollectionOfDices:= (OrderedCollection with: (LoadedDice with: 6)).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	
	self assert: (aGame squares at: 'Walter') equals: 3.
	

]

{ #category : 'tests' }
GameTest >> test026WhenASquareIsAtomicBombThenAllShipsGoBackToFirstSquare [
	
	 aBoard := LoadedBoard withSize: 20 and: AtomicBomb new.
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 6).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	
	self assert: (aGame squares at: 'Walter') equals: 1.
	self assert: (aGame squares at: 'Danny') equals: 1.
	self assert: (aGame squares at: 'Lisa') equals: 1.
	

]

{ #category : 'tests' }
GameTest >> test027WhenASquareIsMoonWalkThenAllOtherShipsMoveBackNSquares [
	
	 aBoard := LoadedBoard withSize: 20 and: (MoonWalk with: 2).
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
	
	self assert: (aGame squares at: 'Walter') equals: 11.
	self assert: (aGame squares at: 'Danny') equals: 5.
	self assert: (aGame squares at: 'Lisa') equals: 7.
	self assert: (aGame lapsFor: walter) equals: 0.
	self assert: (aGame lapsFor: danny) equals: 0.
	self assert: (aGame lapsFor: lisa) equals: 0.
	

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
	
	 aBoard := LoadedBoard withSize: 20 and: (HyperJump with: #(10 5 2)).
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 6).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	
	self assert: (aGame squares at: 'Walter') equals: 17.

	

]

{ #category : 'tests' }
GameTest >> test031WhenAllHyperJumpValuesAreUsedThenListResets [
	
	 aBoard := LoadedBoard withSize: 40 and: (HyperJump with: #(10 5 2)).
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 6).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: (aGame squares at: 'Walter') equals: 33.
	self assert: (aGame squares at: 'Danny') equals: 12.
	self assert: (aGame squares at: 'Lisa') equals: 9.
	

]

{ #category : 'tests' }
GameTest >> test032WhenAShipsPositionIsRequestedThenThatShipsPositionIsRevealed [
	
	aGame playTurnFor: walter.
	aGame playTurn.
	aGame playTurn.
	aGame playTurnFor: walter.
	
	self assert: (aGame squareOf:walter) equals: 7.
	

]

{ #category : 'tests' }
GameTest >> test033WhenAnUnknownShipsPositionIsRequestedThenThatRequestIsDenied [
	
	| darthVadersTieFighter |
	darthVadersTieFighter:= Ship named: 'darthVadersTieFighter'.
	
	self should: [aGame squareOf:darthVadersTieFighter]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'This ship is not playing this game' ]
	
]

{ #category : 'tests' }
GameTest >> test034WhenRankingsIsCalledThenItReturnsShipsOrderedByPosition [

	| ranking secondAndThird |
	aGame := Game 
        playedOn: aBoard 
        by: aCollectionOfShips 
        throwing: aCollectionOfDices 
        winningWith: 3.
    7 timesRepeat: [ aGame playTurn ].
	
	ranking:=aGame ranking.
	self assert: (ranking at: 1) equals: 'Walter'.
	secondAndThird := (Array with: (ranking at: 2) with: (ranking at: 3)) asSet.
	self assert: secondAndThird equals: (Set with: 'Danny' with: 'Lisa')
]

{ #category : 'tests' }
GameTest >> test035WhenARequestForAShipsRankingIsMadeThenThatShipsRankingIsTheResponse [

	aCollectionOfDices := OrderedCollection with: (LoadedDice with: 7).
    aGame := Game 
        playedOn: aBoard 
        by: aCollectionOfShips 
        throwing: aCollectionOfDices 
        winningWith: 3.
    7 timesRepeat: [ aGame playTurn ].
	
	self assert: (aGame rankingFor:walter ) equals:1.

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
GameTest >> test037WhenAShipReachesTheEndOfAFinalLapThenTheGameEnds [
	
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

{ #category : 'tests' }
GameTest >> test038WhenRequestForEveryShipsLapIsMadeThenTheAnswerIsEverysShipsCurrentLap [
	aCollectionOfDices := OrderedCollection with: (LoadedDice with: 7).
    aGame := Game 
        playedOn: aBoard 
        by: aCollectionOfShips 
        throwing: aCollectionOfDices 
        winningWith: 3.
    16 timesRepeat: [ aGame playTurn ].

	 self assert: (aGame laps at: 'Walter') equals: 2.
	self assert: (aGame laps at: 'Danny') equals: 1.
	self assert: (aGame laps at: 'Lisa') equals: 1.


]

{ #category : 'tests' }
GameTest >> test039WhenRequestForAShipsLapIsMadeThenTheAnswerIsThatShipsCurrentLap [
	aCollectionOfDices := OrderedCollection with: (LoadedDice with: 7).
    aGame := Game 
        playedOn: aBoard 
        by: aCollectionOfShips 
        throwing: aCollectionOfDices 
        winningWith: 3.
    16 timesRepeat: [ aGame playTurn ].

	 self assert: (aGame lapsFor: walter) equals: 2.


]

{ #category : 'tests' }
GameTest >> test040WhenARequestForAnUnknownShipsLapIsMadeThenThatRequestIsDenied [

	| darthVadersTieFighter |
	darthVadersTieFighter:= Ship named: 'darthVadersTieFighter'.
	
	self should: [aGame lapsFor:darthVadersTieFighter]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'This ship is not playing this game' ].
]

{ #category : 'tests' }
GameTest >> test041WhenAShipGoBackwardsThenItLoseALap [
	
	| aNumberOfLaps |
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 22).
	aNumberOfLaps:=2.
	aBoard := LoadedBoard withSize: 20 and: WormHole new .
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices winningWith: aNumberOfLaps.
	aGame playTurn.
	self assert: (aGame lapsFor: walter) equals: 0.

]

{ #category : 'tests' }
GameTest >> test042WhenAShipLandsOnASquareByEffectThenNoSecondEffectIsApplied [
	
	| aNumberOfLaps |
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 8).
	aNumberOfLaps:=2.
	aBoard := LoadedBoard withSize: 20 and: WormHole new .
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices winningWith: aNumberOfLaps.
	aGame playTurn.
	self assert: (aGame squareOf: walter) equals: 5.

]

{ #category : 'tests' }
GameTest >> test043WhenASquareIsAtomicBombThenAllShipsKeePTheirLaps [
	
	 | aNumberOfLaps |
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 8).
	aNumberOfLaps:=5.
	aBoard := LoadedBoard withSize: 7 and: AtomicBomb new .
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices winningWith: aNumberOfLaps.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: (aGame lapsFor: walter) equals: 3.
	self assert: (aGame lapsFor: danny) equals: 2.
	self assert: (aGame lapsFor: lisa) equals: 2.

]

{ #category : 'tests' }
GameTest >> test044WhenAShipRecivesEffectThatWouldMoveItBeforeLapZeroSquareOneThenItStaysAtLapZeroSquareOne [
	
	 | aNumberOfLaps |
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 2).
	aNumberOfLaps:=2.
	aBoard := LoadedBoard withSize: 10 and: WormHole new .
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices winningWith: aNumberOfLaps.
	aGame playTurn.
	
	self assert: (aGame squareOf: walter) equals: 1.
	self assert: (aGame lapsFor: walter) equals: 0.

]
