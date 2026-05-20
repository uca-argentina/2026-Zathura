Class {
	#name : 'Square',
	#superclass : 'Object',
	#instVars : [
		'effect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Square class >> with: anEffect [
	^ self new initializeWith: anEffect.
]

{ #category : 'initialization' }
Square >> effect [
	^ effect.
]

{ #category : 'initialization' }
Square >> initializeWith: anEffect [
	effect := anEffect.
]
