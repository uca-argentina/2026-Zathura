Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'ships',
		'dices',
		'state',
		'turnHandler'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> playedOn: aBoard by: aShipsCollection  throwing: aDiceCollection [ 
	
	
	| shipsNames |
	(aShipsCollection size <2)ifTrue: [ Error signal: 'There must be at least two ships'].
	shipsNames:=aShipsCollection collect:[:aShip| aShip name].
	(shipsNames asSet size = aShipsCollection size) ifFalse: [ Error signal: 'There CANNOT be two ships named the same way'].
	aDiceCollection isEmpty ifTrue: [ Error signal: 'There must be at least one dice'].
	aBoard ifNil: [ Error signal: 'Board cannot be nil' ].
	
	
	
	^(self new) initializeWith: aBoard and:aShipsCollection and:aDiceCollection 
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
Game >> initializeWith: aBoard and: aCollectionOfShips and: aDiceCollection [ 
	board := aBoard.
	dices := aDiceCollection.
	state:=OngoingState new.
	ships := aCollectionOfShips.
	turnHandler := TurnHandler for:aCollectionOfShips.
]

{ #category : 'accessing' }
Game >> moveAllShipsExcept: aShip by:  numSquares [
	ships do: [ :each | each ~= aShip ifTrue: [ each moveBack: numSquares ] ]
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
    board move: ship thatRolled: totalRoll andNotify: self.
	turnHandler prepareNextTurn.
]

{ #category : 'accessing' }
Game >> playTurnFor: aShip [
	turnHandler playTurnFor:aShip.
	self playTurn.
	
]

{ #category : 'accessing' }
Game >> sendAllShipsToStart [
	ships do:[ :aShip | aShip moveToStart].
]

{ #category : 'accessing' }
Game >> standings [
	| dict |
	dict:=Dictionary new.
	ships do:[:aShip| dict at: aShip name put: aShip position].
	^ dict.
]

{ #category : 'accessing' }
Game >> winner [
	state ended ifFalse: [ Error signal: 'Game is not over yet' ].
    ^ ships indexOf: (ships detect: [ :aShip | board winner: aShip ]).
]
