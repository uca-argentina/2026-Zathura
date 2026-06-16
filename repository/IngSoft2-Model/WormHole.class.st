Class {
	#name : 'WormHole',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
WormHole >> applyTo: aShip withShips: allShips [
	aShip moveBack: 4.
]
