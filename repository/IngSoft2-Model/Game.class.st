Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'numberOfShips',
		'currentShipIndex',
		'ships',
		'dices',
		'state'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> with: aBoard and: aNumberOfShips and: aDiceCollection [ 
	| aCollectionOfShips |
	
	(aNumberOfShips <2)ifTrue: [ Error signal: 'There must be at least two ships'].
	aDiceCollection isEmpty ifTrue: [ Error signal: 'There must be at least one dice'].
	aBoard ifNil: [ Error signal: 'Board cannot be nil' ].
	
	aCollectionOfShips:=OrderedCollection new.
	1 to: aNumberOfShips do: [ :i | aCollectionOfShips add: Ship new ].
	^(self new) initializeWith: aBoard and:aCollectionOfShips and:aDiceCollection 
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
	numberOfShips := aCollectionOfShips size.
	board := aBoard.
	dices := aDiceCollection.
	state:=OngoingState new.
	ships := aCollectionOfShips.
	currentShipIndex := 1.
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
    ship := ships at: currentShipIndex.
    totalRoll := dices inject: 0 into: [ :sum :aDice | sum + aDice roll ].
    board move: ship thatRolled: totalRoll andNotify: self.
    currentShipIndex := (currentShipIndex \\ ships size) + 1.
]

{ #category : 'accessing' }
Game >> sendAllShipsToStart [
	ships do:[ :aShip | aShip moveToStart].
]

{ #category : 'accessing' }
Game >> standings [
	^ ships collect: [ :aShip | aShip position ]
]

{ #category : 'accessing' }
Game >> winner [
	state ended ifFalse: [ Error signal: 'Game is not over yet' ].
    ^ ships indexOf: (ships detect: [ :aShip | board winner: aShip ]).
]
