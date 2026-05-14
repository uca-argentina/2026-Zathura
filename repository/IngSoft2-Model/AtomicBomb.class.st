Class {
	#name : 'AtomicBomb',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
AtomicBomb class >> applyTo: aShip in: aGame [ 
	aGame sendAllShipsToStart.
]

{ #category : 'initialization' }
AtomicBomb >> applyTo: aShip in: aGame [ 
	aGame sendAllShipsToStart.
]
