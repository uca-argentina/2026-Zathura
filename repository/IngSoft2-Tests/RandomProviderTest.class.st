Class {
	#name : 'RandomProviderTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
RandomProviderTest >> test001WhenAskedForEffectProbabilityThenItReturnsANumberBetweenZeroAndOne [

	| randomProvider probability |
	randomProvider := RandomProvider withMaxMoonWalkDistance: 10.

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

{ #category : 'tests' }
RandomProviderTest >> test003WhenRandomProviderIsCreatedWithHyperJumpThenNextHyperJumpValuesHasThreeElements [

	| randomProvider values  |
	randomProvider := RandomProvider withMaxMoonWalkDistance: 1.

	values := randomProvider nextHyperJumpValues.

	self assert: values size equals: 3.
]

{ #category : 'tests' }
RandomProviderTest >> test004WhenRandomProviderIsCreatedWithHyperJumpThenTheValuesAreAllBetweenOneAndTen [

	| randomProvider values  |
	randomProvider := RandomProvider withMaxMoonWalkDistance: 1.

	values := randomProvider nextHyperJumpValues.
	values do: [ :each |self assert: (each >= 1 and: [ each <= 10 ]) ].
]

{ #category : 'tests' }
RandomProviderTest >> test005WhenRandomProviderIsCreatedWithHyperJumpThenTheValuesAreInDescendingOrder [

	| randomProvider values  |
	randomProvider := RandomProvider withMaxMoonWalkDistance: 1.

	values := randomProvider nextHyperJumpValues.
	self assert: values equals: (values sort: [ :a :b | a > b ]).
]
