Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'numSquares',
		'effects',
		'numberOfLaps'
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

{ #category : 'instance creation' }
Board class >> withSize: aSize using: aProbabilityProvider [
	(aSize isInteger) ifFalse: [ Error signal: 'Board size must be a positive integer' ].
	aSize <= 0 ifTrue: [ Error signal: 'Board size must be greater than 0' ].
	^ (self new) initializeWithSize: aSize using: aProbabilityProvider 
]

{ #category : 'accessing' }
Board >> applyEffect: anEffect to: aShip withShips: allShips [
    anEffect applyTo: aShip withShips: allShips.
    allShips do: [ :each | each handleLapsFor:numSquares].
]

{ #category : 'accessing' }
Board >> effectAt: aPosition [
	^ effects at: aPosition 
]

{ #category : 'accessing' }
Board >> hasWon: aShip forLaps: aNumberOfLaps [
	^ (aShip didYouWin: aNumberOfLaps).
]

{ #category : 'instance creation' }
Board >> initializeWithSize: aSize andEffect: anEffectsArray [
   numSquares := aSize.
	effects := anEffectsArray.

]

{ #category : 'instance creation' }
Board >> initializeWithSize: aSize using: aProbabilityProvider [
	| probability |
	numSquares := aSize.
	effects := Array new: aSize.

	1 to: aSize do: [ :index |
		probability := aProbabilityProvider next.

		probability <= 0.40
			ifTrue: [ effects at: index put: NoEffect new ].

		(probability > 0.40 and: [ probability <= 0.60 ])
			ifTrue: [ effects at: index put: WormHole new ].
			
		(probability > 0.60 and: [ probability <= 0.80 ])
		ifTrue: [ effects at: index put: SpeedUp new ] ].
]

{ #category : 'accessing' }
Board >> move: aShip thatRolled: aDicesResult [
    aShip moveBy: aDicesResult.
    aShip handleLapsFor: numSquares.
]

{ #category : 'accessing' }
Board >> numSquares [
    ^ numSquares
]
