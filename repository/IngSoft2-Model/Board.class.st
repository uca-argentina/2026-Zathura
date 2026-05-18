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
Board class >> withSize: aSize using: aRandomProvider [
	(aSize isInteger) ifFalse: [ Error signal: 'Board size must be a positive integer' ].
	aSize <= 0 ifTrue: [ Error signal: 'Board size must be greater than 0' ].
	^ (self new) initializeWithSize: aSize using: aRandomProvider. 
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
Board >> initializeWithSize: aSize using: aRandomProvider [
	| probability |
	numSquares := aSize.
	effects := Array new: aSize.
	
	1 to: aSize do: [ :index |
		probability := aRandomProvider nextEffectProbability.
		
		(probability < 0 or: [ probability > 1 ])
		ifTrue: [ Error signal: 'Effect probability must be between 0 and 1' ].
		
		probability <= 0.40
			ifTrue: [ effects at: index put: NoEffect new ].

		(probability > 0.40 and: [ probability <= 0.60 ])
			ifTrue: [ effects at: index put: WormHole new ].
			
		(probability > 0.60 and: [ probability <= 0.80 ])
		ifTrue: [ effects at: index put: SpeedUp new ].
		
		(probability > 0.80 and: [ probability <= 0.90 ])
		ifTrue: [ effects at: index put: (MoonWalk with: aRandomProvider nextMoonWalkDistance) ].
		
		(probability > 0.90 and: [ probability <= 0.98 ])
		ifTrue: [ effects at: index put: (HyperJump with: aRandomProvider nextHyperJumpValues) ].
		
		(probability > 0.98 and: [ probability <= 1 ])
		ifTrue: [ effects at: index put: AtomicBomb new ]. ].
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
