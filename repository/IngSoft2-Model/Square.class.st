Class {
	#name : 'Square',
	#superclass : 'Object',
	#instVars : [
		'id',
		'effect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Square class >> withId: anId effect: anEffect [
	^ self new initializeWith: anId effect: anEffect.
]

{ #category : 'initialization' }
Square >> effect [
	^ effect.
]

{ #category : 'initialization' }
Square >> initializeWith: anId effect: anEffect [ 
	id := anId.
	effect := anEffect.

]
