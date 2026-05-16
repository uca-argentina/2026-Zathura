Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'name'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Ship class >> named: aName [
	^ self new initializeAs: aName.
]

{ #category : 'accessing' }
Ship >> = aShip [
	^ aShip areYou:name.
]

{ #category : 'accessing' }
Ship >> areYou: aName [
	^ name = aName.
]

{ #category : 'accessing' }
Ship >> didYouWin:aBoardSize [
	^position >= aBoardSize.
]

{ #category : 'initialization' }
Ship >> initializeAs: aName [
	name := aName.
	position := 1.
]

{ #category : 'accessing' }
Ship >> moveBack: anAmountOfSquares [
	(anAmountOfSquares >0)ifFalse: [ Error signal: 'The Ship must move by at least 1 square back' ].
	position := (position - anAmountOfSquares) max: 1.
]

{ #category : 'accessing' }
Ship >> moveBy: anAmountOfSquares [ 
	(anAmountOfSquares >0)ifFalse: [ Error signal: 'The Ship must move by at least 1 square' ].
	position := position + anAmountOfSquares.
]

{ #category : 'accessing' }
Ship >> moveInsideTheLimits: aMaxLimit [ 
	position := position min:aMaxLimit .
]

{ #category : 'accessing' }
Ship >> moveToStart [
	position := 1.
]

{ #category : 'accessing' }
Ship >> name [
	^name.
]

{ #category : 'accessing' }
Ship >> position [
	^position.
]

{ #category : 'accessing' }
Ship >> standing [
	^#(name position).
]
