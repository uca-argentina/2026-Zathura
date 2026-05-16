Class {
	#name : 'HyperJump',
	#superclass : 'Object',
	#instVars : [
		'values',
		'index'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
HyperJump class >> with: aValuesArray [
	^ self new initializeWith: aValuesArray
	
]

{ #category : 'initialization' }
HyperJump >> applyTo: aShip withShips: allShips [
	aShip moveBy: (values at: index).
	index := (index \\ values size) +1.
]

{ #category : 'initialization' }
HyperJump >> effectsFor: aSize [
	^ Array new: aSize withAll: self.
]

{ #category : 'initialization' }
HyperJump >> initializeWith: aValuesArray [
	values:= aValuesArray asOrderedCollection 
                  sort: [ :a :b | a > b ];
                  asArray.
	index:= 1.
]
