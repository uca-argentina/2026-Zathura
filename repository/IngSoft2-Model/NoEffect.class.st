Class {
	#name : 'NoEffect',
	#superclass : 'Object',
	#instVars : [
		'numSquares',
		'ships'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
NoEffect >> applyTo: aShip withShips: allShips [
	"do nothing"
]

{ #category : 'as yet unclassified' }
NoEffect >> effectsFor: aSize [
	^ Array new: aSize withAll: self.
]
