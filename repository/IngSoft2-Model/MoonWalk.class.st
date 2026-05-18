Class {
	#name : 'MoonWalk',
	#superclass : 'Object',
	#instVars : [
		'numSquares'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
MoonWalk class >> with: aNumber [
	^self new initializeWith: aNumber.
]

{ #category : 'initialization' }
MoonWalk >> applyTo: aShip withShips: allShips [
	allShips select: [ :each | each ~= aShip ] thenDo: [ :each | each moveBack: numSquares ]
]

{ #category : 'initialization' }
MoonWalk >> effectsFor: aSize [
	^ Array new: aSize withAll: self.
]

{ #category : 'initialization' }
MoonWalk >> initializeWith: aNumber [
	numSquares:= aNumber.
]
