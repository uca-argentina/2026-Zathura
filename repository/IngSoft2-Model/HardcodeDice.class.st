Class {
	#name : 'HardcodeDice',
	#superclass : 'Object',
	#instVars : [
		'expectedResult'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
HardcodeDice class >> with: anExpectedResult [ 
	(anExpectedResult <1)ifTrue: [ Error signal:'The expected result should be one or higher' ].
	^ (self new) initializeWith: anExpectedResult.
]

{ #category : 'initialization' }
HardcodeDice >> initializeWith: anExpectedResult [
	expectedResult := anExpectedResult.
]

{ #category : 'as yet unclassified' }
HardcodeDice >> roll [
	^expectedResult .
]
