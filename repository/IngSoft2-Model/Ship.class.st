Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'name',
		'lap',
		'cardsColeccions'
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
Ship >> cardsSize [
	^ cardsColeccions size.
]

{ #category : 'accessing' }
Ship >> didYouWin:aNumberofLaps [
	^lap >= aNumberofLaps.
]

{ #category : 'initialization' }
Ship >> handleLapsFor: aBoardSize [
	lap := lap + ((position - 1 ) // aBoardSize).
   position := ((position - 1) \\ aBoardSize) + 1
]

{ #category : 'initialization' }
Ship >> initializeAs: aName [
	name := aName.
	position := 1.
	lap:=0.
	cardsColeccions := OrderedCollection new.
	cardsColeccions add: Card new.
	cardsColeccions add: Card new.
	
]

{ #category : 'accessing' }
Ship >> lap [
	^lap.
]

{ #category : 'accessing' }
Ship >> moveBack: anAmountOfSquares [
	(anAmountOfSquares >0)ifFalse: [ Error signal: 'The Ship must move by at least 1 square back' ].
	position := (position - anAmountOfSquares).
	(lap = 0 and: [ position < 1]) ifTrue: [ position :=1. ].

]

{ #category : 'accessing' }
Ship >> moveBy: anAmountOfSquares [ 
	(anAmountOfSquares >0)ifFalse: [ Error signal: 'The Ship must move by at least 1 square' ].
	position := position + anAmountOfSquares.
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
Ship >> progressIn: aBoardSize [
    ^ (lap * aBoardSize) + position
]

{ #category : 'accessing' }
Ship >> sendToSquareOne [
	position := 1.
]
