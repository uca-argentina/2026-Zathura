Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> test001WhenBoardIsCreatedWithASizeThenBoardSizeShouldBeThatSize [
    | board |
    board := Board withSize: 5.
    self assert: (board numSquares) equals: 5.
]

{ #category : 'tests' }
BoardTest >> test002WhenBoardIsCreatedWithSizeLessOrEqualToZeroThenShouldThrowError [
    self should: [ Board withSize: 0 ] raise: Error.
    self should: [ Board withSize: -1 ] raise: Error.
]

{ #category : 'tests' }
BoardTest >> test003WhenBoardIsCreatedWithFloatSizeThenShouldThrowError [
    self should: [ Board withSize: 3.5 ] raise: Error.
]

{ #category : 'tests' }
BoardTest >> test004WhenShipsAreAddedToTheBoardThenTheBoardsNumberOfShipsIncreasesAccordingly [
    |aBoard|
		aBoard:= Board withSize: 10.
		aBoard addShip: (Ship knownBy: 1).
		aBoard addShip: (Ship knownBy: 2).
		aBoard addShip: (Ship knownBy: 3).
		self assert: aBoard numberShips equals: 3.
]
