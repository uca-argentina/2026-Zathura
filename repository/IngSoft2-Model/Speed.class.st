Class {
	#name : 'Speed',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'method' }
Speed >> applyTo: aShip in: aGame [ 
	aGame speed: aShip by: 1.
]
