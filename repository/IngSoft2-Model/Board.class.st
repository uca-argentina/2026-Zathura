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

{ #category : 'instance creation' }
Board class >> effectsOfSize: aSize using: aRandomProvider [ 
    | effects probability |
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
            ifTrue: [ effects at: index put: AtomicBomb new ] ].
    ^ effects







]

{ #category : 'as yet unclassified' }
Board class >> withSize: aSize and: aEffectProvider [
	(aSize isInteger) ifFalse: [ Error signal: 'Board size must be a positive integer' ].
	aSize <= 0 ifTrue: [ Error signal: 'Board size must be greater than 0' ].
	^ (self new) initializeWithSize: aSize andEffects: (aEffectProvider effectsFor: aSize).
]

{ #category : 'instance creation' }
Board class >> withSize: aSize using: aRandomProvider [
	(aSize isInteger) ifFalse: [ Error signal: 'Board size must be a positive integer' ].
	aSize <= 0 ifTrue: [ Error signal: 'Board size must be greater than 0' ].
	^ self new initializeWithSize: aSize andEffects: (self effectsOfSize: aSize using: aRandomProvider).
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

{ #category : 'instance creation' }
Board >> initializeWithSize: aSize andEffects: anEffectsArray [
   numSquares := aSize.
	effects := anEffectsArray.

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
