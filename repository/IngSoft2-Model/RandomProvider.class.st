Class {
	#name : 'RandomProvider',
	#superclass : 'Object',
	#instVars : [
		'maxMoonWalkDistance'
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
]

{ #category : 'initialization' }
RandomProvider >> nextEffectProbability [
	^ Random new next.
]

{ #category : 'initialization' }
RandomProvider >> nextHyperJumpValues [
	^ #(10 5 2)
]

{ #category : 'initialization' }
RandomProvider >> nextMoonWalkDistance [
	^ maxMoonWalkDistance atRandom.
]
