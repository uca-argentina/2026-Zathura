Class {
	#name : 'ShipLegacy',
	#superclass : 'Object',
	#instVars : [
		'id',
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
ShipLegacy class >> knownBy: anId [ 
	^(self new) initializeWith: anId.
]

{ #category : 'initialization' }
ShipLegacy >> id [
	^ id
]

{ #category : 'initialization' }
ShipLegacy >> initializeWith: anId [ 
	position := 1.
	id:= anId.
]

{ #category : 'initialization' }
ShipLegacy >> moveForward: numberOfSquares [ 
	(numberOfSquares <1) ifTrue: [ Error signal: 'A ship cannot move forward less than 1 square' ].
	position := position + numberOfSquares.
]

{ #category : 'initialization' }
ShipLegacy >> position [
	^ position.
]
