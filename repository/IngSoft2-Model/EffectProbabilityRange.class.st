Class {
	#name : 'EffectProbabilityRange',
	#superclass : 'Object',
	#instVars : [
		'lowerLimit',
		'upperLimit',
		'effectFactory'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
EffectProbabilityRange class >> from: aLowerLimit to: anUpperLimit effectFactory: aBlock [

	^ self new initializeFrom: aLowerLimit to: anUpperLimit effectFactory: aBlock
]

{ #category : 'instance creation' }
EffectProbabilityRange >> effect [

	^ effectFactory value
]

{ #category : 'instance creation' }
EffectProbabilityRange >> initializeFrom: aLowerLimit to: anUpperLimit effectFactory: aBlock [

	lowerLimit := aLowerLimit.
	upperLimit := anUpperLimit.
	effectFactory := aBlock.
]

{ #category : 'instance creation' }
EffectProbabilityRange >> matches: aProbability [

	^ aProbability > lowerLimit and: [ aProbability <= upperLimit ]
]
