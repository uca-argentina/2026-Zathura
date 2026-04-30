Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Ship >> initialize [
	position := 1.
]

{ #category : 'accessing' }
Ship >> moveBy: aNumber [
	position := position + aNumber.
]

{ #category : 'accessing' }
Ship >> position [
	^position.
]
