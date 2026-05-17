Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardTest >> test001WhenBoardIsCreatedWithASizeThenBoardSizeShouldBeThatSize [
    | board |
    board := Board withSize: 5 and: NoEffect new.
    self assert: (board numSquares) equals: 5.
]

{ #category : 'tests' }
BoardTest >> test002WhenBoardIsCreatedWithSizeLessOrEqualToZeroThenShouldThrowError [
    self should: [ Board withSize: 0 and: NoEffect new ] raise: Error.
    self should: [ Board withSize: -1 and: NoEffect new ] raise: Error.
]

{ #category : 'tests' }
BoardTest >> test003WhenBoardIsCreatedWithFloatSizeThenShouldThrowError [
    self should: [ Board withSize: 5.5 and: NoEffect new ] raise: Error.
]

{ #category : 'tests' }
BoardTest >> test004WhenAShipCrossesTheEndOfTheBoardThenItWrapsAroundAndCompletesALap [
    | aShip aBoard |
    aShip := Ship named: 'Walter'.
    aBoard := Board withSize: 20 and: NoEffect new andLaps: 2.
    aBoard move: aShip thatRolled: 17.
    aBoard move: aShip thatRolled: 2. 
    self assert: aShip position equals: 20.
    self assert: aShip lap equals: 1
]

{ #category : 'tests' }
BoardTest >> test005WhenAShipMovesMoreThanTwoBoardLengthsThenLapsIncreaseAccordingly [
    | aShip aBoard |
    aShip := Ship named: 'Walter'.
    aBoard := Board withSize: 10 and: NoEffect new andLaps: 3.
    aBoard move: aShip thatRolled: 25.  
    self assert: aShip position equals: 6.
    self assert: aShip lap equals: 2
]
