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
Ship class >> named: aName using: aProvider [
	^ self new initializeAs: aName using: aProvider.
]

{ #category : 'accessing' }
Ship >> = aShip [
	^ aShip areYou:name.
]

{ #category : 'adding' }
Ship >> addCard: aCard [
	cardsColeccions add: aCard
]

{ #category : 'accessing' }
Ship >> areYou: aName [
	^ name = aName.
]

{ #category : 'adding' }
Ship >> cardOfClass: aCardClass [
	^ cardsColeccions  detect: [ :card | card class = aCardClass ] ifNone: [ nil ].
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

{ #category : 'testing' }
Ship >> hasCard: aCard [
	^ cardsColeccions includes: aCard.
]

{ #category : 'initialization' }
Ship >> initializeAs: aName using: aProvider [
	name := aName.
	position := 1.
	lap:=0.
	cardsColeccions := OrderedCollection new.
	2 timesRepeat: [ cardsColeccions add: (Card fromProbability: aProvider nextCardProbability) ].
	
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

{ #category : 'removing' }
Ship >> removeCard: aCard [
	cardsColeccions remove: aCard.
]

{ #category : 'accessing' }
Ship >> sendToSquareOne [
	position := 1.
]
