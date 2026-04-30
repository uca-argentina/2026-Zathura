Class {
	#name : 'HardcodedDice',
	#superclass : 'Object',
	#instVars : [
		'expectedResult'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HardcodedDice >> initializeWith: anExpectedResult [
	expectedResult := anExpectedResult.
]

{ #category : 'initialization' }
HardcodedDice >> roll [
	^expectedResult 
]
