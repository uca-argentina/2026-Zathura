Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'size',
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
Game class >> with: aSize and: aNumberOfShips and: aDiceCollection [ 
	| aCollectionOfShips |
	
	(aNumberOfShips <2)ifTrue: [ Error signal: 'There must be at least two ships'].
	aDiceCollection isEmpty ifTrue: [ Error signal: 'There must be at least one dice'].
	(aSize <1)ifTrue: [ Error signal: 'Board cannot be nil or size be zero'].
	
	aCollectionOfShips:=OrderedCollection new.
	1 to: aNumberOfShips do: [ :i | aCollectionOfShips add: Ship new ].
	^(self new) initializeWith: aSize and:aCollectionOfShips and:aDiceCollection 
]

{ #category : 'accessing' }
Game >> ended [
	^ended.
]

{ #category : 'accessing' }
Game >> initializeWith: aSize and: aCollectionOfShips and: aDiceCollection [ 
	numberOfShips := aCollectionOfShips size.
	size := aSize.
	dices := aDiceCollection.
	ended:=false.
	ships := aCollectionOfShips.
	currentShipIndex := 1.
]

{ #category : 'accessing' }
Game >> numberOfSquares [ 
	^size.
]

{ #category : 'accessing' }
Game >> playTurn [
	| ship totalRoll |
	
	
	(ended) ifTrue: [Error signal: 'The Game ended, turns CANNOT be played'].
	ship := ships at: currentShipIndex.
	totalRoll := dices inject: 0 into: [ :sum :aDice | sum + aDice roll ].
	(ship position + totalRoll >=size) ifTrue: [ended:=true. totalRoll :=size- ship position].
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
	|maxPosition|
	self ended ifFalse: [ Error signal: 'Game is not over yet' ].
	maxPosition := self standings max.
    ^ self standings indexOf: maxPosition.
]
