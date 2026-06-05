Class {
	#name : 'Square',
	#superclass : 'Object',
	#instVars : [
		'id',
		'effect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Square class >> effectForProbability: aProbability using: aRandomProvider andParsecPerSquare: aParsecPerSquare [

	(aProbability < 0 or: [ aProbability > 1 ])
		ifTrue: [ Error signal: 'Effect probability must be between 0 and 1' ].

	^ ((self effectRangesUsing: aRandomProvider andParsecPerSquare: aParsecPerSquare)
		detect: [ :range | range matches: aProbability ]) effect
		
]

{ #category : 'instance creation' }
Square class >> effectRangesUsing: aRandomProvider andParsecPerSquare: aParsecPerSquare [

	^ {
		EffectProbabilityRange from: -1 to: 0.30 effectFactory: [ NoEffect new ].
		EffectProbabilityRange from: 0.30 to: 0.40 effectFactory: [ CardGiver new ].
		EffectProbabilityRange from: 0.40 to: 0.60 effectFactory: [ WormHole new ].
		EffectProbabilityRange from: 0.60 to: 0.80 effectFactory: [ SpeedUp new ].
		EffectProbabilityRange from: 0.80 to: 0.90 effectFactory: [ MoonWalk with: aRandomProvider nextMoonWalkDistance ].
		EffectProbabilityRange from: 0.90 to: 0.98 effectFactory: [ HyperJump with: (aRandomProvider nextHyperJumpValues collect: [:v | v / aParsecPerSquare]) ].
		EffectProbabilityRange from: 0.98 to: 1 effectFactory: [ AtomicBomb new ]
	}
]

{ #category : 'instance creation' }
Square class >> withId: aId andRandomProvider: aProvider andParsecPerSquare: aParsecPerSquare [
	^ self new initializeWith: aId andRandomProvider: aProvider andParsecPerSquare: aParsecPerSquare.

]

{ #category : 'initialization' }
Square >> effect [
	^ effect.
]

{ #category : 'initialization' }
Square >> initializeWith: aId andRandomProvider: aRandomProvider andParsecPerSquare: aParsecPerSquare [
	id := aId.
	effect := self class effectForProbability: aRandomProvider nextEffectProbability using: aRandomProvider andParsecPerSquare: aParsecPerSquare.

]
