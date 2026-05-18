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
BoardTest >> test004WhenProbabilityFallsInNoEffectRangeThenSquareHasNoEffect [
	| board loadedProbability |
	loadedProbability := LoadedProbability with: 0.10.
	board := Board withSize: 1 using: loadedProbability.
	self assert: (board effectAt: 1) class equals: NoEffect.
]

{ #category : 'tests' }
BoardTest >> test005WhenProbabilityFallsInWormHoleRangeThenSquareHasWormHole [
	| board loadedProbability |
	loadedProbability := LoadedProbability with: 0.50.
	board := Board withSize: 1 using: loadedProbability.
	self assert: (board effectAt: 1) class equals: WormHole.
]

{ #category : 'tests' }
BoardTest >> test006WhenProbabilityFallsInSpeedUpRangeThenSquareHasSpeedUp [
	| board loadedProbability |
	loadedProbability := LoadedProbability with: 0.70.
	board := Board withSize: 1 using: loadedProbability.
	self assert: (board effectAt: 1) class equals: SpeedUp.
]
