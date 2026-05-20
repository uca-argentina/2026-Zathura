Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'numSquares',
		'effects',
		'parsecLength',
		'squares'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Board class >> effectForProbability: aProbability using: aRandomProvider [

	(aProbability < 0 or: [ aProbability > 1 ])
		ifTrue: [ Error signal: 'Effect probability must be between 0 and 1' ].

	^ ((self effectRangesUsing: aRandomProvider)
		detect: [ :range | range matches: aProbability ]) effect
]

{ #category : 'instance creation' }
Board class >> effectRangesUsing: aRandomProvider [

	^ {
		EffectProbabilityRange from: -1 to: 0.40 effectFactory: [ NoEffect new ].
		EffectProbabilityRange from: 0.40 to: 0.60 effectFactory: [ WormHole new ].
		EffectProbabilityRange from: 0.60 to: 0.80 effectFactory: [ SpeedUp new ].
		EffectProbabilityRange from: 0.80 to: 0.90 effectFactory: [ MoonWalk with: aRandomProvider nextMoonWalkDistance ].
		EffectProbabilityRange from: 0.90 to: 0.98 effectFactory: [ HyperJump with: aRandomProvider nextHyperJumpValues ].
		EffectProbabilityRange from: 0.98 to: 1 effectFactory: [ AtomicBomb new ]
	}
]

{ #category : 'instance creation' }
Board class >> squaresOfSize: aSize using: aRandomProvider [

	^(1 to: aSize ) collect: [ :i |
		Square with: (self effectForProbability: aRandomProvider nextEffectProbability using: aRandomProvider) ].





]

{ #category : 'instance creation' }
Board class >> withSize: aSize andPasrsecLength: aLength  using: aRandomProvider [
	(aSize isInteger) ifFalse: [ Error signal: 'Board size must be a positive integer' ].
	aSize <= 0 ifTrue: [ Error signal: 'Board size must be greater than 0' ].
	(aLength isInteger) ifFalse: [ Error signal: 'Parsecs length must be a positive integer' ].
	aLength <= 0 ifTrue: [ Error signal: 'Parsecs length must be greater than 0' ].
	^ self new initializeWithSize: aSize andParsecLength: aLength andEffects: (self squaresOfSize: aSize using: aRandomProvider).
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
Board >> initializeWithSize: aSize andParsecLength: aLength andEffects: anSquaresArray [
   numSquares := aSize.
	parsecLength := aLength.
	squares := anSquaresArray.

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

{ #category : 'accessing' }
Board >> sizeInParsec [
    ^ numSquares / parsecLength 
]

{ #category : 'accessing' }
Board >> squareAt: aPosition [
    ^ squares at: aPosition
]
