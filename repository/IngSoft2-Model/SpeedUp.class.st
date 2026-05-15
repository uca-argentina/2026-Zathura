Class {
	#name : 'SpeedUp',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SpeedUp >> applyTo: aShip in: aGame [
	aShip moveBy: 4.
]
