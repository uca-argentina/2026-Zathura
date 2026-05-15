Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'numSquares',
		'ships',
		'effects'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> withSize: aSize and: aEffect [
	(aSize isInteger) ifFalse: [ Error signal: 'Board size must be a positive integer' ].
	aSize <= 0 ifTrue: [ Error signal: 'Board size must be greater than 0' ].
	^ (self new) initializeWithSize: aSize andEffect: aEffect.
]

{ #category : 'instance creation' }
Board >> initializeWithSize: aSize andEffect: aEffect [
	ships:= OrderedCollection new. 
   numSquares := aSize.
	effects := aEffect
]

{ #category : 'accessing' }
Board >> move: aShip thatRolled: aDicesResult andNotify: aGame [ 
    | amountOfSquares |
    amountOfSquares := (aShip position + aDicesResult) min: numSquares.
    aShip moveBy: amountOfSquares - aShip position.
	effects applyTo: aShip in: aGame.
    (self winner: aShip) ifTrue: [ aGame end ].
]

{ #category : 'accessing' }
Board >> numSquares [
    ^ numSquares
]

{ #category : 'accessing' }
Board >> winner: aShip [ 
	^ (aShip position >= numSquares).
]
