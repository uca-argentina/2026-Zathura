Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'size',
		'numberOfShips',
		'position'
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
Game >> initializeWith: aSize and: aNumberOfShips [ 
	position:=1.
	size:=aSize.
	numberOfShips:=aNumberOfShips.
]

{ #category : 'accessing' }
Game >> numberOfSquares [ 
	^size.
]

{ #category : 'as yet unclassified' }
Game >> playTurn [
	position := position + 3.
]

{ #category : 'accessing' }
Game >> standings [
	^ position .
]
