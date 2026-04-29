Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'numberOfSides'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Dice class >> with: aNumberOfSides [ 
	(aNumberOfSides <3)ifTrue: [ Error signal: 'Number of sides should be 3 or greater'].
	^(self new) initializeWith: aNumberOfSides.
]

{ #category : 'initialization' }
Dice >> initializeWith: aNumberOfSides [ 
	numberOfSides:=aNumberOfSides.
]

{ #category : 'as yet unclassified' }
Dice >> roll [
	^ ((1 to:numberOfSides ) atRandom ).
]
