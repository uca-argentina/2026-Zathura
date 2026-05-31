Class {
	#name : 'Acceleration',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'method' }
Acceleration >> applyTo: aShip in: aGame [ 
	aGame accelerate: 1.
]
