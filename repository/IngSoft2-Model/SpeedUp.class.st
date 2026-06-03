Class {
	#name : 'SpeedUp',
	#superclass : 'Effect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SpeedUp >> applyTo: aShip withShips: allShips [
	aShip moveBy: 4.
]
