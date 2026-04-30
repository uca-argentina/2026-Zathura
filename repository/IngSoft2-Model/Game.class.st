Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'board',
		'numberOfShips',
		'currentShipIndex',
		'ships',
		'dices',
		'ended'
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

{ #category : 'accessing' }
Game >> ended [
	^ended.
]

{ #category : 'accessing' }
Game >> initializeWith: aBoard and: aCollectionOfShips and: aDiceCollection [ 
	numberOfShips := aCollectionOfShips size.
	board := aBoard.
	dices := aDiceCollection.
	ended:=false.
	ships := aCollectionOfShips.
	currentShipIndex := 1.
]

{ #category : 'accessing' }
Game >> playTurn [
	| ship totalRoll |
	
	
	(ended) ifTrue: [Error signal: 'The Game ended, turns CANNOT be played'].
	ship := ships at: currentShipIndex.
	totalRoll := dices inject: 0 into: [ :sum :aDice | sum + aDice roll ].
	(ship position + totalRoll >=board numSquares) ifTrue: [ended:=true. totalRoll :=board numSquares- ship position].
	ship moveBy: totalRoll.
	
	
	currentShipIndex := (currentShipIndex \\ numberOfShips) +1.
	
]

{ #category : 'accessing' }
Game >> ships [
	^ ships
]

{ #category : 'accessing' }
Game >> standings [
	| positionCollection|
	positionCollection:= Dictionary new.
	ships keysAndValuesDo: [ :index :aShip | positionCollection at: index put: aShip position ].
    ^ positionCollection values asOrderedCollection.
]

{ #category : 'accessing' }
Game >> winner [
	self ended ifFalse: [ Error signal: 'Game is not over yet' ].
    ^ ships indexOf: (ships detect: [ :aShip | board winner: aShip ]).
]
