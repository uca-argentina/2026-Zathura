Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'numSquares',
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Board class >> withSize: aSize [ 
	(aSize isInteger) ifFalse: [ Error signal: 'Board size must be a positive integer' ].
	aSize <= 0 ifTrue: [ Error signal: 'Board size must be greater than 0' ].
	^(self new) initializeWithSize: aSize.
]

{ #category : 'instance creation' }
Board >> initializeWithSize: aSize [ 
	ships:= OrderedCollection new. 
   numSquares := aSize.
]

{ #category : 'accessing' }
Board >> move: aShip thatRolled: aDicesResult andNotify: aGame [ 
    | amountOfSquares |
    amountOfSquares := (aShip position + aDicesResult) min: numSquares.
    aShip moveBy: amountOfSquares - aShip position.
    (self winner: aShip) ifTrue: [ aGame end ].
]

{ #category : 'accessing' }
Board >> numSquares [
    ^ numSquares
]

{ #category : 'accessing' }
Board >> winner: aShip [ 
	^ (aShip position >= numSquares).
]
