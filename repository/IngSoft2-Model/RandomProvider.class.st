Class {
	#name : 'RandomProvider',
	#superclass : 'Object',
	#instVars : [
		'maxMoonWalkDistance',
		'random'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
RandomProvider class >> withMaxMoonWalkDistance: aMaxDistance [
	^ self new initializeMaxMoonWalkDistance: aMaxDistance.
]

{ #category : 'initialization' }
RandomProvider >> initializeMaxMoonWalkDistance: aMaxDistance [
	maxMoonWalkDistance := aMaxDistance.
	random := Random new.
]

{ #category : 'initialization' }
RandomProvider >> nextEffectProbability [
	^ random next.
]

{ #category : 'initialization' }
RandomProvider >> nextHyperJumpValues [
	| values candidate |
    values := OrderedCollection new.
    [ values size = 3 ] whileFalse: [
        candidate := (random next * 10) ceiling .
        (values includes: candidate) ifFalse: [ values add: candidate ]
    ].
    ^ values sort: [ :a :b | a > b ].
]

{ #category : 'initialization' }
RandomProvider >> nextMoonWalkDistance [
	^ maxMoonWalkDistance atRandom.
]
