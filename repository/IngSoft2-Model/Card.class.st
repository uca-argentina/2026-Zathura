Class {
	#name : 'Card',
	#superclass : 'Object',
	#instVars : [
		'isPermanent'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Card class >> fromProbability: aProbability [
	aProbability < (0.21) ifTrue: [ ^ Overload new ].
    aProbability < (0.41) ifTrue: [ ^ Speed new ].
    aProbability < (0.61) ifTrue: [ ^ Acceleration new ].
	aProbability < (0.81) ifTrue: [ ^ Cancellation new ].
    ^ Redo new.
]

{ #category : 'testing' }
Card class >> isAbstract [

	^ self == Card
]

{ #category : 'accessing' }
Card >> isPermanent [
	^isPermanent
]
