Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'id',
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Ship >> id [
	^ id
]

{ #category : 'initialization' }
Ship >> initializeWith: anId [ 
	position := 1.
	id:= anId.
]

{ #category : 'initialization' }
Ship >> moveForward: numberOfSquares [ 
	(numberOfSquares <1) ifTrue: [ Error signal: 'A ship cannot move forward less than 1 square' ].
	position := position + numberOfSquares.
]

{ #category : 'initialization' }
Ship >> position [
	^ position.
]
