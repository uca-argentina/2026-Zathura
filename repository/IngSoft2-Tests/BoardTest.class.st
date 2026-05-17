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
