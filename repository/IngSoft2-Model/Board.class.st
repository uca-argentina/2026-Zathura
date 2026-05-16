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
Board class >> withSize: aSize and: aEffectProvider [
	(aSize isInteger) ifFalse: [ Error signal: 'Board size must be a positive integer' ].
	aSize <= 0 ifTrue: [ Error signal: 'Board size must be greater than 0' ].
	^ (self new) initializeWithSize: aSize andEffect: (aEffectProvider effectsFor: aSize).
]

{ #category : 'accessing' }
Board >> applyEffect: anEffect to: aShip withShips: allShips [
    anEffect applyTo: aShip withShips: allShips.
    allShips do: [ :each | each moveInsideTheLimits: numSquares ].
]

{ #category : 'accessing' }
Board >> effectAt: aPosition [
	^ effects at: aPosition 
]

{ #category : 'accessing' }
Board >> hasWon: aShip [ 
	^ (aShip didYouWin: numSquares).
]

{ #category : 'instance creation' }
Board >> initializeWithSize: aSize andEffect: anEffectsArray [
   numSquares := aSize.
	effects := anEffectsArray.
]

{ #category : 'accessing' }
Board >> move: aShip thatRolled: aDicesResult [ 
    | amountOfSquares |
    amountOfSquares := (aShip position + aDicesResult) min: numSquares.
    aShip moveBy: aDicesResult.
	aShip moveInsideTheLimits: numSquares.
]

{ #category : 'accessing' }
Board >> numSquares [
    ^ numSquares
]
