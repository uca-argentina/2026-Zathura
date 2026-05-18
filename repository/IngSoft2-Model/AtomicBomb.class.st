Class {
	#name : 'AtomicBomb',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
AtomicBomb >> applyTo: aShip withShips: allShips [
	allShips do:[:each | each sendToSquareOne ].
]

{ #category : 'initialization' }
AtomicBomb >> effectsFor: aSize [
	^ Array new: aSize withAll: self.
]
