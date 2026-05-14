Class {
	#name : 'MoonWalk',
	#superclass : 'Object',
	#instVars : [
		'numSquares'
	],
	#classInstVars : [
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
MoonWalk >> applyTo: aShip in: aGame [
	aGame moveAllShipsExcept: aShip by:  numSquares.
]

{ #category : 'initialization' }
MoonWalk >> initializeWith: aNumber [
	numSquares:= aNumber.
]
