Class {
	#name : 'HardcodeDice',
	#superclass : 'Object',
	#instVars : [
		'expectedResult'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
HardcodeDice >> initializeWith: anExpectedResult [
	expectedResult := anExpectedResult.
]

{ #category : 'as yet unclassified' }
HardcodeDice >> roll [
	^expectedResult .
]
