Class {
	#name : 'Ship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'name',
		'lap'
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
Ship >> completeLapFor: aBoardSize [
	lap := lap + ((position - 1 ) // aBoardSize).
   position := ((position - 1) \\ aBoardSize) + 1
]

{ #category : 'accessing' }
Ship >> didYouWin:aNumberofLaps [
	^lap >= aNumberofLaps.
]

{ #category : 'initialization' }
Ship >> handleLapsFor: aBoardSize [

	(position > aBoardSize )ifTrue: [ self completeLapFor:aBoardSize ].

]

{ #category : 'initialization' }
Ship >> initializeAs: aName [
	name := aName.
	position := 1.
	lap:=0.
]

{ #category : 'accessing' }
Ship >> lap [
	^lap.
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
Ship >> moveInsideTheLimits: aBoardSize [
	position := position min:aBoardSize .
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
Ship >> progressIn: aBoardSize [
    ^ (lap * aBoardSize) + position
]

{ #category : 'accessing' }
Ship >> standing [
	^#(name position).
]
