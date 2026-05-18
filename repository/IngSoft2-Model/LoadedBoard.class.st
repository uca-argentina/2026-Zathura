Class {
	#name : 'LoadedBoard',
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
LoadedBoard class >> withSize: aSize and: aEffectProvider [
	(aSize isInteger) ifFalse: [ Error signal: 'Board size must be a positive integer' ].
	aSize <= 0 ifTrue: [ Error signal: 'Board size must be greater than 0' ].
	^ (self new) initializeWithSize: aSize andEffect: (aEffectProvider effectsFor: aSize).
]

{ #category : 'accessing' }
LoadedBoard >> applyEffect: anEffect to: aShip withShips: allShips [
    anEffect applyTo: aShip withShips: allShips.
    allShips do: [ :each | each handleLapsFor:numSquares].
]

{ #category : 'accessing' }
LoadedBoard >> effectAt: aPosition [
	^ effects at: aPosition 
]

{ #category : 'accessing' }
LoadedBoard >> hasWon: aShip forLaps: aNumberOfLaps [
	^ (aShip didYouWin: aNumberOfLaps).
]

{ #category : 'instance creation' }
LoadedBoard >> initializeWithSize: aSize andEffect: anEffectsArray [
   numSquares := aSize.
	effects := anEffectsArray.

]

{ #category : 'accessing' }
LoadedBoard >> move: aShip thatRolled: aDicesResult [
    aShip moveBy: aDicesResult.
    aShip handleLapsFor: numSquares.
]

{ #category : 'accessing' }
LoadedBoard >> numSquares [
    ^ numSquares
]
