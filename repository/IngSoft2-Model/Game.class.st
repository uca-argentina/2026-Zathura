Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'ships',
		'dices',
		'state',
		'turnHandler',
		'lapsToWin',
		'activeCards',
		'usedCards',
		'lastPlayedCard',
		'lastEffect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> playedOn: aBoard by: aShipsCollection  throwing: aDiceCollection [ 
	
	^ self playedOn: aBoard by: aShipsCollection throwing: aDiceCollection winningWith: 1.
]

{ #category : 'as yet unclassified' }
Game class >> playedOn: aBoard by: aShipsCollection throwing: aDiceCollection winningWith: aNumberofLaps [ 
	
	| shipsNames |
	(aShipsCollection size <2)ifTrue: [ Error signal: 'There must be at least two ships'].
	shipsNames:=aShipsCollection collect:[:aShip| aShip name].
	(shipsNames asSet size = aShipsCollection size) ifFalse: [ Error signal: 'There CANNOT be two ships named the same way'].
	aDiceCollection isEmpty ifTrue: [ Error signal: 'There must be at least one dice'].
	aBoard ifNil: [ Error signal: 'Board cannot be nil' ].
	aNumberofLaps <= 0 ifTrue: [ Error signal: 'Number of laps to win must be greater than 0' ].
	
	^(self new) initializeWith: aBoard deepCopy and:aShipsCollection deepCopy and:aDiceCollection deepCopy and:aNumberofLaps.
	
	
]

{ #category : 'adding' }
Game >> addActiveCard: aCard [
	activeCards add: aCard.
]

{ #category : 'accessing' }
Game >> applyLastEffectTo: aShip [
	| internalShip |
	internalShip := ships detect: [:each | each = aShip].
	board applyEffect: lastEffect to: internalShip withShips: ships.
	(self hasWon: internalShip) ifTrue: [ self end ].
]

{ #category : 'accessing' }
Game >> cardsOf: theShip [ 
	self validateShipIsPlaying: theShip.
	^ (ships detect: [:each | each = theShip]) cards deepCopy.
]

{ #category : 'playingLogic' }
Game >> end [
	state:= EndedState new.
]

{ #category : 'accessing' }
Game >> ended [
	^ state ended
]

{ #category : 'accessing' }
Game >> hasWon: aShip [
    ^ aShip didYouWin: lapsToWin
]

{ #category : 'accessing' }
Game >> initializeWith: aBoard and: aCollectionOfShips and: aDiceCollection and: aNumberOfLaps [ 
	board := aBoard.
	dices := aDiceCollection.
	state:=OngoingState new.
	ships := aCollectionOfShips .
	turnHandler := TurnHandler for:aCollectionOfShips.
	lapsToWin:=aNumberOfLaps.
	activeCards := OrderedCollection new.
	usedCards:= OrderedCollection new.
]

{ #category : 'accessing' }
Game >> laps [
	| dict |
	dict:=Dictionary new.
	ships do:[:aShip| dict at: aShip name put: aShip lap ].
	^ dict.
]

{ #category : 'accessing' }
Game >> lapsFor: theShip [ 
	self validateShipIsPlaying: theShip.
	^ (self laps) at: theShip name.
]

{ #category : 'accessing' }
Game >> playCard: aCard from: aShip [ 
	|card|
	self ended ifTrue: [ Error signal: 'The Game ended, cards CANNOT be played' ].
	card:= aShip cardOfClass: aCard.
	card ifNil: [ Error signal: 'The ship does not have this card' ].
	(card isPermanent and: [ (turnHandler whoseTurnIsIt) ~= aShip ])
        ifTrue: [ Error signal: 'It isn´t players turn, it can´t play it' ].
	aShip removeCard: card.
	card applyTo: nil in: self.
	lastPlayedCard := card.
	usedCards add: card.
]

{ #category : 'accessing' }
Game >> playCard: aCard from: aShip cancelingCard: aCardToCancel [ 

	|card|
	self ended ifTrue: [ Error signal: 'The Game ended, cards CANNOT be played' ].
	card:= aShip cardOfClass: aCard.
	card  ifNil: [ Error signal: 'The ship does not have this card' ].
	(card isPermanent and: [ (turnHandler whoseTurnIsIt) ~= aShip ])
        ifTrue: [ Error signal: 'It isn´t players turn, it can´t play it' ].
	aShip removeCard: card.
	card applyTo: aCardToCancel in: self.
	lastPlayedCard := card.
	usedCards add: card
]

{ #category : 'accessing' }
Game >> playCard: aCardClass from: aShip targeting: anotherShip [ 
	
	|card|
	self ended ifTrue: [ Error signal: 'The Game ended, cards CANNOT be played' ].
	card:= aShip cardOfClass: aCardClass.
	card  ifNil: [ Error signal: 'The ship does not have this card' ].
	(card isPermanent and: [ (turnHandler whoseTurnIsIt) ~= aShip ])
        ifTrue: [ Error signal: 'It isn´t players turn, it can´t play it' ].
	aShip removeCard: card.
	card applyTo: anotherShip in: self.
	lastPlayedCard := card.
	usedCards add: card.
]

{ #category : 'accessing' }
Game >> playGame [
	[ self ended ] whileFalse: [ self playTurn ].
	
]

{ #category : 'accessing' }
Game >> playTurn [
	state playTurn: self
	
]

{ #category : 'accessing' }
Game >> playTurnAsEnded [ 
    Error signal: 'The Game ended, turns CANNOT be played'.
]

{ #category : 'accessing' }
Game >> playTurnAsOngoing [
| ship totalRoll |
    ship := turnHandler whoseTurnIsIt.
    totalRoll := dices inject: 0 into: [ :sum :aDice | sum + aDice roll ].
    totalRoll := activeCards inject: totalRoll into: [ :roll :card | card modifyRoll: roll forShip: ship ].
    board move: ship thatRolled: totalRoll.
    lastEffect := board land: ship withShips: ships.
    (self hasWon: ship) ifTrue: [ self end ].
    turnHandler prepareNextTurn.
]

{ #category : 'accessing' }
Game >> ranking [
	| sortedShips dict |
	sortedShips := ships asSortedCollection: [ :a :b | 
    (a progressIn: board numSquares) > (b progressIn: board numSquares) ].
	dict := Dictionary new.
	sortedShips doWithIndex: [ :aShip :i | dict at: i put: aShip name ].
	^ dict
]

{ #category : 'accessing' }
Game >> rankingFor: theShip [ 
	self validateShipIsPlaying: theShip.
	^ self ranking keyAtValue: theShip name.
]

{ #category : 'accessing' }
Game >> removeActiveCard: aCardClass [ 
	|aCard |
	aCard:=activeCards detect: [ :card | card class = aCardClass ] ifNone: [ nil ].
	aCard ifNil: [ Error signal: 'There are no active cards to cancel' ].
	activeCards remove: aCard.
]

{ #category : 'accessing' }
Game >> replayLastCardTargeting: aShip [
	
	|card|
	self ended ifTrue: [ Error signal: 'The Game ended, cards CANNOT be played' ].
	card:= lastPlayedCard class new.
	card  ifNil: [ Error signal: 'The ship does not have this card' ].
	card applyTo: aShip in: self.
	usedCards add: card.
]

{ #category : 'accessing' }
Game >> squareOf: theShip [ 
	self validateShipIsPlaying: theShip.
	^ (ships detect: [:each | each = theShip]) position.
	
]

{ #category : 'accessing' }
Game >> squares [
	| dict |
	dict:=Dictionary new.
	ships do:[:aShip| dict at: aShip name put: aShip position ].
	^ dict.
]

{ #category : 'accessing' }
Game >> usedCardsList [
	^usedCards
]

{ #category : 'accessing' }
Game >> validateShipIsPlaying: theShip [ 
	(ships anySatisfy: [:aShip| aShip = theShip ]) ifFalse: [ Error signal: 'This ship is not playing this game' ].
]

{ #category : 'accessing' }
Game >> validateTurnOf: aShip [
	turnHandler validateTurnOf:aShip.
	self playTurn.
	
]

{ #category : 'accessing' }
Game >> whoWon [
	state ended ifFalse: [ Error signal: 'Game is not over yet' ].
    ^ (ships detect: [ :aShip | self hasWon: aShip ]) name.
]
