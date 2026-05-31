Class {
	#name : 'Board',
	#superclass : 'Object',
	#instVars : [
		'numSquares',
		'effects',
		'parsecLength',
		'squares',
		'lightSize'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Board class >> squaresOfSize: aSize using: aRandomProvider andParsecPerSquare: aParsecPerSquare [

	^(1 to: aSize ) collect: [ :i |
		Square withId: i andRandomProvider: aRandomProvider andParsecPerSquare: aParsecPerSquare  ].





]

{ #category : 'instance creation' }
Board class >> withSize: aSize andParsecLength: aLength  using: aRandomProvider [
	(aSize isInteger) ifFalse: [ Error signal: 'Board size must be a positive integer' ].
	aSize <= 0 ifTrue: [ Error signal: 'Board size must be greater than 0' ].
	(aLength isInteger) ifFalse: [ Error signal: 'Parsecs length must be a positive integer' ].
	aLength <= 0 ifTrue: [ Error signal: 'Parsecs length must be greater than 0' ].
	^ self new initializeWithSize: aSize andParsecLength: aLength andRandomProvider: aRandomProvider.
	

]

{ #category : 'accessing' }
Board >> applyEffect: anEffect to: aShip withShips: allShips [
    anEffect applyTo: aShip withShips: allShips.
	allShips do: [ :each | each handleLapsFor:numSquares].
  
]

{ #category : 'accessing' }
Board >> effectAt: aPosition [
	^ (self squareAt: aPosition ) effect
]

{ #category : 'instance creation' }
Board >> initializeWithSize: aSize andParsecLength: aLength andRandomProvider: aRandomProvider [
   numSquares := aSize.
	parsecLength := aLength.
	squares := self class squaresOfSize: aSize using: aRandomProvider andParsecPerSquare: self parsecPerSquare.
	lightSize := aLength /3
]

{ #category : 'accessing' }
Board >> lightSize [
	^lightSize
]

{ #category : 'accessing' }
Board >> move: aShip thatRolled: aDicesResult [
    aShip moveBy: aDicesResult.
	aShip handleLapsFor: numSquares.
]

{ #category : 'accessing' }
Board >> numSquares [
    ^ numSquares
]

{ #category : 'accessing' }
Board >> parsecPerSquare [
    ^ parsecLength / numSquares  
]

{ #category : 'accessing' }
Board >> squareAt: aPosition [
    ^ squares at: aPosition
]
