Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'numSquares',
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

{ #category : 'accessing' }
Board >> hasWon: aShip [ 
	^ (aShip didYouWin: numSquares).
]

{ #category : 'instance creation' }
Board >> initializeWithSize: aSize andEffect: aEffect [
   numSquares := aSize.
	effects := aEffect
]

{ #category : 'accessing' }
Board >> move: aShip thatRolled: aDicesResult andNotify: aGame [ 
    | amountOfSquares |
    amountOfSquares := (aShip position + aDicesResult) min: numSquares.
    aShip moveBy: aDicesResult.
	effects applyTo: aShip in: aGame.
	aShip moveInsideTheLimits: numSquares.
]

{ #category : 'accessing' }
Board >> numSquares [
    ^ numSquares
]
