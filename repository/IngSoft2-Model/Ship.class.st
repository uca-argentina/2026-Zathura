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
Ship >> moveBack: anAmountOfSquares [
	(anAmountOfSquares >0)ifFalse: [ Error signal: 'The Ship must move by at least 1 square back' ].
	position := position - anAmountOfSquares.
]

{ #category : 'accessing' }
Ship >> moveBy: anAmountOfSquares [
	(anAmountOfSquares >0)ifFalse: [ Error signal: 'The Ship must move by at least 1 square' ].
	position := position + anAmountOfSquares.
]

{ #category : 'accessing' }
Ship >> moveToStart [
	position := 1.
]

{ #category : 'accessing' }
Ship >> position [
	^position.
]
