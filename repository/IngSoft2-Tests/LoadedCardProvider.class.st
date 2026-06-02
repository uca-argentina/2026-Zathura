Class {
	#name : 'LoadedCardProvider',
	#superclass : 'Object',
	#instVars : [
		'random',
		'probabilities',
		'index'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
LoadedCardProvider class >> with: aProbabilitiesCollection [
	^ self new initializeWith: aProbabilitiesCollection
	
]

{ #category : 'initialization' }
LoadedCardProvider >> initializeWith: aProbabilitiesCollection [
	probabilities:= aProbabilitiesCollection.
	index:= 1.
]

{ #category : 'as yet unclassified' }
LoadedCardProvider >> nextCardProbability [
	|value|
	value := probabilities at: index.
	index := index +1.
	^ value 
]

{ #category : 'as yet unclassified' }
LoadedCardProvider >> nextCardProbability: aProbability [
	^aProbability
]
