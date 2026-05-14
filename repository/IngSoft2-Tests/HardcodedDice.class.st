Class {
	#name : 'HardcodedDice',
	#superclass : 'Object',
	#instVars : [
		'expectedResult'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
HardcodedDice class >> with: anExpectedResult [ 
	(anExpectedResult <1)ifTrue: [ Error signal:'The expected result should be one or higher' ].
	^ (self new) initializeWith: anExpectedResult.
]

{ #category : 'initialization' }
HardcodedDice >> initializeWith: anExpectedResult [
	expectedResult := anExpectedResult.
]

{ #category : 'initialization' }
HardcodedDice >> roll [
	^expectedResult 
]
