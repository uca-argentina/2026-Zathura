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
Board >> initializeWithSize: aSize [ 
   numSquares := aSize.
]

{ #category : 'accessing' }
Board >> numSquares [
    ^ numSquares
]
