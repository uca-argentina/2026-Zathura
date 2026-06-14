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
Board class >> withSize: aSize andParsecLength: aLength using: aProvider [
    ^ self withSize: aSize length: aLength unit: Parsec using: aProvider
	

]

{ #category : 'instance creation' }
Board class >> withSize: aSize length: aValue unit: aUnit using: aRandomProvider [
    (aSize isInteger) ifFalse: [ Error signal: 'Board size must be a positive integer' ].
    aSize <= 0 ifTrue: [ Error signal: 'Board size must be greater than 0' ].
    (aValue isInteger) ifFalse: [ Error signal: 'A boards length must be a positive integer' ].
    aValue <= 0 ifTrue: [ Error signal: 'A boards length must be greater than zero' ].
    ^ self new initializeWithSize: aSize length: aValue unit: aUnit andRandomProvider: aRandomProvider.

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

{ #category : 'accessing' }
Board >> initializeWithSize: aSize length: aValue unit: aUnit andRandomProvider: aRandomProvider [
    numSquares := aSize.
    parsecLength := aValue * (DistanceConverter parsecRatioFor: aUnit).
    lightSize := parsecLength * (DistanceConverter  lightYearRatioFor:Parsec ).
    squares := self class squaresOfSize: aSize
                         using: aRandomProvider
                         andParsecPerSquare: self parsecPerSquare.
]

{ #category : 'accessing' }
Board >> lightSize [
	^lightSize
]

{ #category : 'accessing' }
Board >> move: aShip thatRolled: aDicesResult [
    aDicesResult > 0 ifTrue: [ aShip moveBy: aDicesResult ].
    aDicesResult < 0 ifTrue: [ aShip moveBack: aDicesResult abs ].
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
