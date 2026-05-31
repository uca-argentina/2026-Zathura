Class {
	#name : 'Overload',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'method' }
Overload >> applyTo: aShip in: aGame [ 
	aGame overload: aShip by: 2.
]
