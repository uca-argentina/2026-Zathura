Class {
	#name : 'BoardLegacyTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
BoardLegacyTest >> test001WhenBoardIsCreatedWithASizeThenBoardSizeShouldBeThatSize [
    | board |
    board := Board withSize: 5.
    self assert: (board numSquares) equals: 5.
]

{ #category : 'tests' }
BoardLegacyTest >> test002WhenBoardIsCreatedWithSizeLessOrEqualToZeroThenShouldThrowError [
    self should: [ Board withSize: 0 ] raise: Error.
    self should: [ Board withSize: -1 ] raise: Error.
]

{ #category : 'tests' }
BoardLegacyTest >> test003WhenBoardIsCreatedWithFloatSizeThenShouldThrowError [
    self should: [ Board withSize: 3.5 ] raise: Error.
]
