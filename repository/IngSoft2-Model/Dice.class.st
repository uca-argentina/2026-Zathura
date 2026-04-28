Class {
	#name : 'Dice',
	#superclass : 'Object',
	#instVars : [
		'numberOfSides'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Dice >> initializeWith: aNumberOfSides [ 
	numberOfSides:=aNumberOfSides.
]

{ #category : 'as yet unclassified' }
Dice >> roll [
	^ ((1 to:numberOfSides ) atRandom ).
]
