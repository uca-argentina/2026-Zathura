Class {
	#name : 'WormHole',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
WormHole class >> applyTo: aShip in: aGame [
	aShip moveBack: 4.
]
