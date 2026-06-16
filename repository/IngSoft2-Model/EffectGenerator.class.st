Class {
	#name : 'EffectGenerator',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
EffectGenerator class >> effectForProbability: aProbability using: aRandomProvider andParsecPerSquare: aParsecPerSquare [

	(aProbability < 0 or: [ aProbability > 1 ])
		ifTrue: [ Error signal: 'Effect probability must be between 0 and 1' ].

	^ ((self effectRangesUsing: aRandomProvider andParsecPerSquare: aParsecPerSquare)
		detect: [ :range | range matches: aProbability ]) effect

]

{ #category : 'as yet unclassified' }
EffectGenerator class >> effectRangesUsing: aRandomProvider andParsecPerSquare: aParsecPerSquare [

	^ {
		EffectProbabilityRange from: -1 to: 0.30 effectFactory: [ NoEffect new ].
		EffectProbabilityRange from: 0.30 to: 0.40 effectFactory: [ CardGiver new ].
		EffectProbabilityRange from: 0.40 to: 0.60 effectFactory: [ WormHole new ].
		EffectProbabilityRange from: 0.60 to: 0.80 effectFactory: [ SpeedUp new ].
		EffectProbabilityRange from: 0.80 to: 0.90 effectFactory: [ MoonWalk with: aRandomProvider nextMoonWalkDistance ].
		EffectProbabilityRange from: 0.90 to: 0.98 effectFactory: [
	| unit values |
	unit := aRandomProvider nextHyperJumpUnit.
	values := aRandomProvider nextHyperJumpValues.
	HyperJump with: (values collect: [ :v |
		(DistanceConverter convert: v from: unit toSquaresWithParsecPerSquare: aParsecPerSquare) rounded ]) ].
		EffectProbabilityRange from: 0.98 to: 1 effectFactory: [ AtomicBomb new ]
	}

]

{ #category : 'as yet unclassified' }
EffectGenerator class >> nextEffectUsing: aRandomProvider andParsecPerSquare: aParsecPerSquare [
	^ self effectForProbability: aRandomProvider nextEffectProbability using: aRandomProvider andParsecPerSquare: aParsecPerSquare

]
