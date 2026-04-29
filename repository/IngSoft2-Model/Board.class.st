Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'numSquares'
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

{ #category : 'instance creation' }
Board >> initializeWithSize: aSize [ 
   numSquares := aSize.
]

{ #category : 'accessing' }
Board >> numSquares [
    ^ numSquares
]
