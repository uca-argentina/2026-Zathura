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
	(aSize isInteger) ifFalse: [ Error signal: 'el tamaño del tablero debe ser un numero entero' ].
	aSize <= 0 ifTrue: [ Error signal: 'tamaño del tablero debe ser mayor a 0' ].
	^(self new) initializeWithSize: aSize.
]

{ #category : 'accessing' }
Board >> addShip: aShip [ 
	ships add: aShip
]

{ #category : 'instance creation' }
Board >> initializeWithSize: aSize [ 
	ships:= OrderedCollection new. 
   numSquares := aSize.
]

{ #category : 'accessing' }
Board >> numSquares [
    ^ numSquares
]

{ #category : 'accessing' }
Board >> numberShips [
	 ^ships size.
]

{ #category : 'accessing' }
Board >> winner: aShip [ 
	^ (aShip position >= numSquares).
]
