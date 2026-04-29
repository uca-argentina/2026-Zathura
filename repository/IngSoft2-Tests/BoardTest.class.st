Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
BoardTest >> test001WhenBoardIsCreatedWithASizeThenBoardSizeShouldBeThatSize [
    | board |
    board := Board withSize: 5.
    self assert: (board numSquares) equals: 5.
]

{ #category : 'as yet unclassified' }
BoardTest >> test002WhenBoardIsCreatedWithSizeLessOrEqualToZeroThenShouldThrowError [
    self should: [ Board withSize: 0 ] raise: Error.
    self should: [ Board withSize: -1 ] raise: Error.
]

{ #category : 'as yet unclassified' }
BoardTest >> test003WhenBoardIsCreatedWithFloatSizeThenShouldThrowError [
    self should: [ Board withSize: 3.5 ] raise: Error.
]
