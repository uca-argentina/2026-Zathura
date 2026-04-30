Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'size',
		'numberOfShips',
		'position',
		'dice',
		'positions',
		'currentShipIndex',
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Game class >> with: aSize and: aNumberOfShips and: aHardcodedDice [ 

		
	| aCollectionOfShips |
	aCollectionOfShips:=OrderedCollection new.
	1 to: aNumberOfShips do: [ :i | aCollectionOfShips add: Ship new ].
	^(self new) initializeWith: aSize and:aCollectionOfShips and:aHardcodedDice 
]

{ #category : 'accessing' }
Game >> ended [
	^false.
]

{ #category : 'accessing' }
Game >> initializeWith: aSize and: aCollectionOfShips and: aHardcodedDice [ 
	numberOfShips := aCollectionOfShips size.
	size := aSize.
	dice := aHardcodedDice.
	
	ships := aCollectionOfShips.
	currentShipIndex := 1.
]

{ #category : 'accessing' }
Game >> numberOfSquares [ 
	^size.
]

{ #category : 'as yet unclassified' }
Game >> playTurn [
	| ship |
	ship := ships at: currentShipIndex.
	ship moveBy: dice roll.
	
	currentShipIndex := (currentShipIndex \\ numberOfShips) +1.
	"currentShipIndex > ships size ifTrue: [ currentShipIndex := 1 ]."
]

{ #category : 'accessing' }
Game >> ships [
	^ ships
]

{ #category : 'accessing' }
Game >> standings [
	| positionCollection|
	positionCollection:=ships collect:[:aShip| aShip position].
	^ positionCollection.
]
