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
	aProbability < (0.1667) ifTrue: [ ^ Overload new ].
    aProbability < (0.3333) ifTrue: [ ^ Speed new ].
    aProbability < (0.5000) ifTrue: [ ^ Acceleration new ].
    aProbability < (0.6667) ifTrue: [ ^ Cancellation new ].
    aProbability < (0.8333) ifTrue: [ ^ Redo new ].
    aProbability < (1.1) ifTrue: [ ^ Repeat new ].
]

{ #category : 'testing' }
Card class >> isAbstract [

	^ self == Card
]

{ #category : 'accessing' }
Card >> isPermanent [
	^isPermanent
]
