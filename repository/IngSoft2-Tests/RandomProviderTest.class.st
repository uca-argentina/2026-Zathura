Class {
	#name : 'RandomProviderTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RandomProviderTest >> test001WhenAskedForEffectProbabilityThenItReturnsANumberBetweenZeroAndOne [

	| randomProvider probability |
	randomProvider := RandomProvider new.

	probability := randomProvider nextEffectProbability.

	self assert: (probability between: 0 and: 1).
]

{ #category : 'tests' }
RandomProviderTest >> test002WhenAskedForMoonWalkDistanceThenItReturnsAPositiveIntegerWithinLimit [

	| randomProvider distance |
	randomProvider := RandomProvider withMaxMoonWalkDistance: 10.

	distance := randomProvider nextMoonWalkDistance.

	self assert: distance isInteger.
	self assert: (distance between: 1 and: 10).
]
