Class {
	#name : 'SpeedUp',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SpeedUp >> applyTo: aShip withShips: allShips [
	aShip moveBy: 4.
]

{ #category : 'initialization' }
SpeedUp >> effectsFor: aSize [
	^ Array new: aSize withAll: self.
]
