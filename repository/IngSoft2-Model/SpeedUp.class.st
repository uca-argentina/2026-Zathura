Class {
	#name : 'SpeedUp',
	#superclass : 'Object',
	#instVars : [
		'numSquares',
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
SpeedUp class >> applyTo: aShip in: aGame [ 
	aShip moveBy: 4.
]

{ #category : 'initialization' }
SpeedUp >> applyTo: aShip in: aGame [
	aShip moveBy: 4.
]
