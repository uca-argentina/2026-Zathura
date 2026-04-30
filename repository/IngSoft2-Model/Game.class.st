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
Game class >> with: aSize and: aNumberOfShips [ 
	^ (self new) initializeWith:aSize and:aNumberOfShips.
]

{ #category : 'accessing' }
Game >> ended [
	^false.
]

{ #category : 'accessing' }
Game >> initializeWith: aSize and: aNumberOfShips and: aHardcodedDice [ 
	numberOfShips := aNumberOfShips.
	size := aSize.
	dice := aHardcodedDice.
	
	ships := OrderedCollection new.
	1 to: numberOfShips do: [ :i | ships add: Ship new ].
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
	
	currentShipIndex := currentShipIndex + 1.
	currentShipIndex > ships size ifTrue: [ currentShipIndex := 1 ].
]

{ #category : 'accessing' }
Game >> ships [
	^ ships
]

{ #category : 'accessing' }
Game >> standings [
	^ positions .
]
