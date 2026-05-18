Class {
	#name : 'LoadedProbability',
	#superclass : 'Object',
	#instVars : [
		'probability'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'initialization' }
LoadedProbability >> initializeWith: aProbability [
	probability := aProbability
]

{ #category : 'initialization' }
LoadedProbability >> next [
	^ probability 
]
