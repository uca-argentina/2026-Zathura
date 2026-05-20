Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#instVars : [
		'board'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> boardWithSize: aSize AndPasrsecLength: aLength AndWithLoadProbability: aProbability [
    ^Board withSize: aSize andPasrsecLength: aLength using: (LoadedRandomProvider with: aProbability).
]

{ #category : 'tests' }
BoardTest >> test001WhenBoardIsCreatedWithASizeThenBoardSizeShouldBeThatSize [
    board := Board withSize: 5 andPasrsecLength: 1 using: (LoadedRandomProvider withProbabilities: {0.4 . 0.4 . 0.4 . 0.4 . 0.4}).
    self assert: (board numSquares) equals: 5.
]

{ #category : 'tests' }
BoardTest >> test002WhenBoardIsCreatedWithSizeLessOrEqualToZeroThenShouldThrowError [
    self should: [ Board withSize: 0 andPasrsecLength: 4 using: (LoadedRandomProvider with: 0.4)] raise: Error.
    self should: [ Board withSize: -1 andPasrsecLength: 4 using: (LoadedRandomProvider with: 0.4) ] raise: Error.
]

{ #category : 'tests' }
BoardTest >> test003WhenBoardIsCreatedWithFloatSizeThenShouldThrowError [
    self should: [ Board withSize: 5.5 andPasrsecLength: 4 using: (LoadedRandomProvider withProbabilities: {0.4 . 0.4 . 0.4 . 0.4 . 0.4 . 0.4}) ] raise: Error.
]

{ #category : 'tests' }
BoardTest >> test004WhenBoardIsCreatedWithParsecSizeThenItReturndTheParsecLength [

	|  randomProvider |
	randomProvider := RandomProvider withMaxMoonWalkDistance: 10.

	board := Board withSize: 20 andPasrsecLength: 4  using: randomProvider.

	self assert: board sizeInParsec equals: 5.
]

{ #category : 'tests' }
BoardTest >> test005WhenBoardIsCreatedWithParsecLengthLessOrEqualToZeroThenShouldThrowError [
    self should: [ Board withSize: 20 andPasrsecLength: 0 using: (LoadedRandomProvider with: 0.4)] raise: Error.
    self should: [ Board withSize: 20 andPasrsecLength: -1 using: (LoadedRandomProvider with: 0.4) ] raise: Error.
]

{ #category : 'tests' }
BoardTest >> test006WhenBoardIsCreatedWithFloatParsecLEngthThenShouldThrowError [
    self should: [ Board withSize: 20 andPasrsecLength: 4.5 using: (LoadedRandomProvider withProbabilities: {0.4 . 0.4 . 0.4 . 0.4 . 0.4 . 0.4}) ] raise: Error.
]

{ #category : 'tests' }
BoardTest >> test007WhenBoardIsCreatedThenEachPositionHasASquare [
    board := Board withSize: 5 andPasrsecLength: 1 using: (LoadedRandomProvider withProbabilities: {0.4 . 0.4 . 0.4 . 0.4 . 0.4}).
    1 to: 5 do: [:i | self assert: (board squareAt: i) class equals: Square].
]
