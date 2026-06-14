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
		'aGame',
		'loadedRandomProvider'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
GameTest >> boardWithSize: aSize length: aLength andWithProbability: aProbability [
    | probability provider |
    probability := (1 to: aSize) collect: [ :i | aProbability ].
    provider := LoadedRandomProvider
        withProbabilities: probability
        andMoonWalkDistances: #()
        andHyperJumpValues: #().
    ^ Board withSize: aSize length: aLength unit: Parsec using: provider.
]

{ #category : 'running' }
GameTest >> setUp [

	|probabilities  |
	super setUp.
	
	walter := Ship named: 'Walter' using: (LoadedCardProvider with: #(0.08 0.25)).
	danny := Ship named: 'Danny' using: (LoadedCardProvider with: #(0.42 0.58)).
	lisa := Ship named: 'Lisa' using: (LoadedCardProvider with: #(0.75 0.90)).
	
	
	aDice := LoadedDice with: 3.
	probabilities := OrderedCollection new.
	probabilities addAll: ((1 to: 20) collect: [ :i | 0.3 ]).

	loadedRandomProvider := LoadedRandomProvider
		                        withProbabilities: probabilities
		                        andMoonWalkDistances: 0
		                        andHyperJumpValues: 0.
		
	aBoard := Board withSize: 20 length: 5 unit:Parsec using: loadedRandomProvider.
	aCollectionOfDices := OrderedCollection with: aDice.
	aCollectionOfShips := {
		                      walter.
		                      danny.
		                      lisa }.
	aGame := Game
		         playedOn: aBoard
		         by: aCollectionOfShips
		         throwing: aCollectionOfDices
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
	
	self should: [Game playedOn:aBoard by: {Ship named: 'Walter' using: CardProvider new} throwing: aCollectionOfDices ] 
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

	| probabilities |
	probabilities := OrderedCollection new.
	probabilities addAll: ((1 to: 20) collect: [ :i | 0.70 ]).

	loadedRandomProvider := LoadedRandomProvider
		                        withProbabilities: probabilities
		                        andMoonWalkDistances: 0
		                        andHyperJumpValues: 0.	
		
	aBoard := Board withSize: 20 andParsecLength: 5 using: loadedRandomProvider .
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	
	self assert: (aGame squares at: 'Walter') equals: 8.
	

]

{ #category : 'tests' }
GameTest >> test025WhenASquareIsWormHoleThenTheShipMovesFourSquaresBack [
	
	aBoard := self  boardWithSize: 20 length: 5 andWithProbability: 0.50.
	aCollectionOfDices:= (OrderedCollection with: (LoadedDice with: 6)).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	
	self assert: (aGame squares at: 'Walter') equals: 3.
	

]

{ #category : 'tests' }
GameTest >> test026WhenASquareIsAtomicBombThenAllShipsGoBackToFirstSquare [
	
	aBoard := self boardWithSize: 20 length: 5 andWithProbability: 0.99.
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
	
	| probabilities moonWalkDistances |
	probabilities := OrderedCollection new.
	probabilities addAll: ((1 to: 20) collect: [ :i | 0.85 ]).
	moonWalkDistances:= OrderedCollection new.
	moonWalkDistances addAll: ((1 to: 20) collect: [ :i | 2 ]).

	loadedRandomProvider := LoadedRandomProvider
		                        withProbabilities: probabilities
		                        andMoonWalkDistances: moonWalkDistances 
		                        andHyperJumpValues: 0.	
		
	aBoard := Board withSize: 20 andParsecLength: 5 using: loadedRandomProvider .
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
	walter2:= Ship named: 'Walter' using: CardProvider new.
	aColl2:= OrderedCollection with:walter with:danny with:walter2. 
	self should: [Game playedOn: aBoard by: aColl2 throwing:aCollectionOfDices.]
	raise: Error
	withExceptionDo: [ :anError| self assert: anError messageText equals: 'There CANNOT be two ships named the same way' ]
	
	

]

{ #category : 'tests' }
GameTest >> test030WhenASquareIsHyperJumpThenShipAdvancesByFirstValueInList [
	
	| probabilities hyperJumpDistances |
	probabilities := OrderedCollection new.
	probabilities addAll: ((1 to: 20) collect: [ :i | 0.91 ]).
	hyperJumpDistances:= OrderedCollection new.
	hyperJumpDistances addAll: ((1 to: 20) collect: [ :i | #(5 2 10) ]). "Lo tiene que ordenar a (10 5 2)"

	loadedRandomProvider := LoadedRandomProvider
		                        withProbabilities: probabilities
		                        andMoonWalkDistances: 0 
		                        andHyperJumpValues: hyperJumpDistances .	
		
	aBoard := Board withSize: 20 andParsecLength: 5 using: loadedRandomProvider .
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 6).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	
	self assert: (aGame squares at: 'Walter') equals: 7.

	

]

{ #category : 'tests' }
GameTest >> test031WhenAllHyperJumpValuesAreUsedThenListResets [
	
	| probabilities hyperJumpDistances |
	probabilities := OrderedCollection new.
	probabilities addAll: ((1 to: 40) collect: [ :i | 0.91 ]).
	hyperJumpDistances:= OrderedCollection new.
	hyperJumpDistances addAll: ((1 to: 40) collect: [ :i | #(5 2 10) ]). "Lo tiene que ordenar a (10 5 2)"

	loadedRandomProvider := LoadedRandomProvider
		                        withProbabilities: probabilities
		                        andMoonWalkDistances: 0 
		                        andHyperJumpValues: hyperJumpDistances .	
		
	aBoard := Board withSize: 40 andParsecLength: 20 using: loadedRandomProvider .
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 6).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	aGame playTurn.
	
	self assert: (aGame squares at: 'Walter') equals: 13.
	self assert: (aGame squares at: 'Danny') equals: 17.
	self assert: (aGame squares at: 'Lisa') equals: 11.
	

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
	darthVadersTieFighter:= Ship named: 'darthVadersTieFighter'using: CardProvider new.
	
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
	darthVadersTieFighter:= Ship named: 'darthVadersTieFighter'using: CardProvider new.
	
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
	darthVadersTieFighter:= Ship named: 'darthVadersTieFighter' using: CardProvider new.
	
	self should: [aGame lapsFor:darthVadersTieFighter]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'This ship is not playing this game' ].
]

{ #category : 'tests' }
GameTest >> test041WhenAShipGoBackwardsThenItLosesALap [
	
	aCollectionOfDices:=OrderedCollection with: (LoadedDice with: 22).
	aBoard := self boardWithSize: 20 length: 5 andWithProbability: 0.50.
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices winningWith: 2.
	aGame playTurn.
	self assert: (aGame lapsFor: walter) equals: 0.

]

{ #category : 'tests' }
GameTest >> test042WhenAShipLandsOnASquareByEffectThenNoSecondEffectIsApplied [
	
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 8).
	aBoard := self boardWithSize: 20 length: 5 andWithProbability: 0.50.
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices winningWith: 2.
	aGame playTurn.
	self assert: (aGame squareOf: walter) equals: 5.

]

{ #category : 'tests' }
GameTest >> test043WhenASquareIsAtomicBombThenAllShipsKeepTheirLaps [
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 8).
	aBoard := self boardWithSize: 6 length: 5 andWithProbability: 0.99.
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices winningWith: 5.
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
GameTest >> test044WhenAShipReceivesEffectThatWouldMoveItBeforeLapZeroSquareOneThenItStaysAtLapZeroSquareOne [
	
	aCollectionOfDices:=OrderedCollection
	with: (LoadedDice with: 2).
	aBoard := self boardWithSize: 10 length: 5 andWithProbability: 0.50.
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices winningWith: 2.
	aGame playTurn.
	
	self assert: (aGame squareOf: walter) equals: 1.
	self assert: (aGame lapsFor: walter) equals: 0.

]

{ #category : 'tests' }
GameTest >> test045WhenAShipIsModifiedOutsideGameThenGameStateIsNotAffected [
	aGame playTurn.
	walter moveBy: 10.
	self assert: (aGame squareOf: walter) equals: 4.

]

{ #category : 'tests' }
GameTest >> test046WhenABoardIsModifiedOutsideGameThenGameStateIsNotAffected [
	|externalBoard|
	externalBoard := aBoard.
	aGame playTurn.
	externalBoard move: walter thatRolled: 10.
	self assert: (aGame squareOf: walter) equals: 4.

]

{ #category : 'tests' }
GameTest >> test047WhenADiceCollectionsIsModifiedOutsideGameThenGameStateIsNotAffected [
	aCollectionOfDices add: (LoadedDice with: 100).
	aGame playTurn.
	self assert: (aGame squareOf: walter) equals: 4.

]

{ #category : 'tests' }
GameTest >> test048WhenShipCollectionIsModifiedOutsideGameThenGameStateIsNotAffected [
	|extraShip modifiableCollection|
	extraShip := Ship named:'darthVadersTieFighter' using: CardProvider new. 
	modifiableCollection := aCollectionOfShips asOrderedCollection.
    modifiableCollection add: extraShip.
	self assert: (aGame squares size) equals: 3.

]

{ #category : 'tests' }
GameTest >> test049WhenGameIsCreatedThenAllShipsHaveTwoCards [
	 self assert: (aCollectionOfShips allSatisfy: [ :ship | ship  cardsSize = 2 ]).
]

{ #category : 'tests' }
GameTest >> test050WhenWalterPlaysOverloadOnDannyThenDannysNextThrowIsReducedByTwo [ 
	aGame playCard: Overload from: walter targeting: danny.
	 aGame playTurn. 
	 aGame playTurn.
	self assert: (aGame squareOf:danny) equals: 2.
]

{ #category : 'tests' }
GameTest >> test051WhenWalterPlaysSpeedOnDannyThenDannysNextThrowIsIncreasedByOne [
	aGame playCard: Speed from: walter targeting: danny.
	 aGame playTurn. 
	 aGame playTurn.
	self assert: (aGame squareOf:danny) equals: 5.
]

{ #category : 'tests' }
GameTest >> test052WhenDannyPlaysAccelerationThenAllShipsNextThrowIsIncreasedByOne [
	aGame playTurn.
	aGame playCard: Acceleration from: danny.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame squareOf:danny) equals: 5.
	self assert: (aGame squareOf:walter) equals: 4.
	self assert: (aGame squareOf:lisa) equals: 5.
]

{ #category : 'tests' }
GameTest >> test053WhenDannyPlaysCancellationOnOverloadThenDannysNextThrowIsNormal [
	
	aGame playCard: Overload from: walter targeting: danny.
	aGame playCard: Cancellation from: danny cancelingCard: Overload.
	aGame playTurn.
	aGame playTurn.
	self assert: (aGame squareOf: danny) equals: 4.
]

{ #category : 'tests' }
GameTest >> test054WhenWalterPlaysACardHeDoesntHaveThenAnErrorIsThrown [
	| acceleration |
	acceleration := Acceleration new.
	
	self should: [ aGame playCard: acceleration from: walter ]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'The ship does not have this card' ]
]

{ #category : 'tests' }
GameTest >> test055WhenWalterPlaysACardThenThatCardIsRemovedFromHisHand [
	
	aGame playCard: Overload from: walter targeting: danny.
	self deny: (walter hasCard: Overload)
]

{ #category : 'tests' }
GameTest >> test056WhenShipPlaysCancellationWithNoActiveCardsThenAnErrorIsThrown [
	
	self should: [ aGame playCard: Cancellation from: danny cancelingCard: Overload ]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'There are no active cards to cancel' ]
]

{ #category : 'tests' }
GameTest >> test057WhenACardIsPlayedAfterGameEndedThenAnErrorIsThrown [ 
    aGame playGame.
    
    self should: [aGame playCard: Overload from: walter targeting: danny]
    raise: Error
    withExceptionDo: [ :anError | self assert: anError messageText equals: 'The Game ended, cards CANNOT be played' ]

]

{ #category : 'tests' }
GameTest >> test058WhenACardIsUsedThenItGoesToUsedCardsList [
	 
	aGame playCard: Overload from: walter targeting: danny.
	self assert: (aGame usedCardsList size) equals: 1.
]

{ #category : 'tests' }
GameTest >> test059WhenAShipPlaysRedoThenTheLastTypeOfCardUsedIsPlayed [
	aGame playCard: Overload from: walter  targeting: danny.
	aGame playTurn.
	aGame playTurn.
	aGame playCard: Redo from: lisa targeting: walter.
	aGame playTurn.
	aGame playTurn.
	self assert: ( aGame squareOf: walter) equals: 5.
]

{ #category : 'tests' }
GameTest >> test060WhenAShipPlaysACardButItIsntHisTurnThenThenHeCantPlayIT [
	self should: [aGame playCard: Acceleration from: danny ]
    raise: Error
    withExceptionDo: [ :anError | self assert: anError messageText equals: 'It isn´t players turn, it can´t play it' ]
]

{ #category : 'tests' }
GameTest >> test061WhenAShipPlaysRepeatThenTheLastEffectIsReaplayed [
	aBoard := self boardWithSize: 20 length: 5 andWithProbability: 0.50.
	aCollectionOfDices:= (OrderedCollection with: (LoadedDice with: 6)).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	
	aGame playTurn.

	aGame playCard: Repeat from: lisa targeting: walter.
	self assert: ( aGame squareOf: walter) equals: 1.
]

{ #category : 'tests' }
GameTest >> test062WhenASquareIsCardGiverThenTheShipGetsACard [
	
	aBoard := self boardWithSize: 20 length: 5 andWithProbability: 0.35.
	aCollectionOfDices:= (OrderedCollection with: (LoadedDice with: 6)).
	aGame:= Game playedOn:aBoard by: aCollectionOfShips throwing: aCollectionOfDices.
	aGame playTurn.
	
	self assert: (aGame cardsOf: walter) size equals: 3
	

]

{ #category : 'tests' }
GameTest >> test063WhenOverloadMakesRollNegativeThenShipMovesBack [
    | aDiceCollection |
aDiceCollection := OrderedCollection with: (LoadedDice with: 1).
    aGame := Game playedOn: aBoard by: aCollectionOfShips throwing: aDiceCollection.
    aGame playTurn.  
    aGame playTurn.  
    aGame playTurn.  
    aGame playCard: Overload from: walter targeting: walter.
    aGame playTurn.  
    self assert: (aGame squareOf: walter) equals: 1.
	

]

{ #category : 'tests' }
GameTest >> test064WhenAGameIsCreatedWithNonPositiveLapsToWinThenShouldThrowError [ 
	self should: [ Game playedOn: aBoard by: aCollectionOfShips throwing: aCollectionOfDices winningWith: 0 ]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'Number of laps to win must be greater than 0' ]

	

]
