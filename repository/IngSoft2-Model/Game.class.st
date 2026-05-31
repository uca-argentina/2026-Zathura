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
		'activeCards'
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
	
	
	
	^(self new) initializeWith: aBoard deepCopy and:aShipsCollection deepCopy and:aDiceCollection deepCopy and:aNumberofLaps.
	
]

{ #category : 'adding' }
Game >> addActiveCard: aCard [
	activeCards add: aCard.
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
Game >> playCard [
	self shouldBeImplemented.
]

{ #category : 'accessing' }
Game >> playCard: aCard from: aShip [ 
	(aShip hasCard: aCard) ifFalse: [ Error signal: 'The ship does not have this card' ].
	aShip removeCard: aCard.
	aCard applyTo: nil in: self.
]

{ #category : 'accessing' }
Game >> playCard: aCard from: aShip cancelingCard: aCardToCancel [ 
	(aShip hasCard: aCard) ifFalse: [ Error signal: 'The ship does not have this card' ].
	aShip removeCard: aCard.
	aCard applyTo: aCardToCancel in: self.
]

{ #category : 'accessing' }
Game >> playCard: aCard from: aShip targeting: anotherShip [ 
	(aShip hasCard: aCard) ifFalse: [ Error signal: 'The ship does not have this card' ].
	aShip removeCard: aCard.
	aCard applyTo: anotherShip in: self.
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
    | ship totalRoll  |
    ship := turnHandler whoseTurnIsIt.
    totalRoll := dices inject: 0 into: [ :sum :aDice | sum + aDice roll ].
	 totalRoll := activeCards inject: totalRoll into: [ :roll :card | card modifyRoll: roll forShip: ship ].
    board move: ship thatRolled: totalRoll.
	board applyEffect: (board effectAt: ship position) to: ship withShips: ships.
	(self hasWon: ship) ifTrue: [ self end ].
	turnHandler prepareNextTurn.
]

{ #category : 'accessing' }
Game >> playTurnFor: aShip [
	turnHandler playTurnFor:aShip.
	self playTurn.
	
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
Game >> removeActiveCard: aCard [ 
	activeCards remove: aCard.
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
Game >> validateShipIsPlaying: theShip [ 
	(ships anySatisfy: [:aShip| aShip = theShip ]) ifFalse: [ Error signal: 'This ship is not playing this game' ].
]

{ #category : 'accessing' }
Game >> whoWon [
	state ended ifFalse: [ Error signal: 'Game is not over yet' ].
    ^ (ships detect: [ :aShip | self hasWon: aShip ]) name.
]
