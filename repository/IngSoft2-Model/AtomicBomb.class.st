Class {
	#name : 'AtomicBomb',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
AtomicBomb >> applyTo: aShip withShips: allShips [
	allShips do:[:each | each sendToSquareOne ].
]
