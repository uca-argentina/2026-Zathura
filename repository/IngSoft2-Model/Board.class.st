Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'numSquares',
		'effects',
		'numberOfLaps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Board class >> withSize: aSize and: aEffectProvider [
	(aSize isInteger) ifFalse: [ Error signal: 'Board size must be a positive integer' ].
	aSize <= 0 ifTrue: [ Error signal: 'Board size must be greater than 0' ].
	^ (self new) initializeWithSize: aSize andEffect: (aEffectProvider effectsFor: aSize) andNumberOfLaps: 1.
]

{ #category : 'as yet unclassified' }
Board class >> withSize: aSize and: aEffectProvider andLaps: anAmount [
	(aSize isInteger) ifFalse: [ Error signal: 'Board size must be a positive integer' ].
	aSize <= 0 ifTrue: [ Error signal: 'Board size must be greater than 0' ].
	^ (self new) initializeWithSize: aSize andEffect: (aEffectProvider effectsFor: aSize) andNumberOfLaps: anAmount .
]

{ #category : 'accessing' }
Board >> applyEffect: anEffect to: aShip withShips: allShips [
    anEffect applyTo: aShip withShips: allShips.
    allShips do: [ :each | each handleLapsFor:numSquares andNumberOfLaps:numberOfLaps ].
]

{ #category : 'accessing' }
Board >> effectAt: aPosition [
	^ effects at: aPosition 
]

{ #category : 'accessing' }
Board >> hasWon: aShip [ 
	^ (aShip didYouWin: numberOfLaps).
]

{ #category : 'accessing' }
Board >> hasWon: aShip forLaps: aNumberOfLaps [
	^ (aShip didYouWin: aNumberOfLaps).
]

{ #category : 'instance creation' }
Board >> initializeWithSize: aSize andEffect: anEffectsArray andNumberOfLaps:anAmount [
   numSquares := aSize.
	effects := anEffectsArray.
	numberOfLaps:=anAmount.
]

{ #category : 'accessing' }
Board >> move: aShip thatRolled: aDicesResult [ 
    aShip moveBy: aDicesResult.
	aShip handleLapsFor: numSquares andNumberOfLaps: numberOfLaps.
]

{ #category : 'accessing' }
Board >> numSquares [
    ^ numSquares
]
