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
	loadedProbability := LoadedRandomProvider with: 0.10.
	board := Board withSize: 1 using: loadedProbability.
	self assert: (board effectAt: 1) class equals: NoEffect.
]

{ #category : 'tests' }
BoardTest >> test005WhenProbabilityFallsInWormHoleRangeThenSquareHasWormHole [
	| board loadedProbability |
	loadedProbability := LoadedRandomProvider with: 0.50.
	board := Board withSize: 1 using: loadedProbability.
	self assert: (board effectAt: 1) class equals: WormHole.
]

{ #category : 'tests' }
BoardTest >> test006WhenProbabilityFallsInSpeedUpRangeThenSquareHasSpeedUp [
	| board loadedProbability |
	loadedProbability := LoadedRandomProvider with: 0.70.
	board := Board withSize: 1 using: loadedProbability.
	self assert: (board effectAt: 1) class equals: SpeedUp.
]

{ #category : 'tests' }
BoardTest >> test007WhenProbabilityFallsInMoonWalkRangeThenSquareHasMoonWalk [
	| board loadedProbability |
	loadedProbability := LoadedRandomProvider with: 0.85 andMoonWalkDistance: 1.
	board := Board withSize: 1 using: loadedProbability.
	self assert: (board effectAt: 1) class equals: MoonWalk.
]

{ #category : 'tests' }
BoardTest >> test008WhenProbabilityFallsInMoonWalkRangeThenMoonWalkUsesGeneratedDistance [

	| board loadedProbability effect shipThatLands otherShip |
	loadedProbability := LoadedRandomProvider
		with: 0.85
		andMoonWalkDistance: 2.

	board := Board withSize: 1 using: loadedProbability.
	effect := board effectAt: 1.

	shipThatLands := Ship named: 'Walter'.
	otherShip := Ship named: 'Danny'.
	otherShip moveBy: 4.

	effect applyTo: shipThatLands withShips: { shipThatLands. otherShip }.

	self assert: otherShip position equals: 3.
	self assert: shipThatLands position equals: 1.
]

{ #category : 'tests' }
BoardTest >> test009WhenTwoMoonWalkSquaresAreGeneratedThenEachUsesADifferentGeneratedDistance [

	| board loadedRandomProvider firstEffect secondEffect shipThatLands otherShip |
	loadedRandomProvider := LoadedRandomProvider
		withProbabilities: #(0.85 0.85)
		andMoonWalkDistances: #(2 5).

	board := Board withSize: 2 using: loadedRandomProvider.

	firstEffect := board effectAt: 1.
	secondEffect := board effectAt: 2.

	shipThatLands := Ship named: 'Walter'.
	otherShip := Ship named: 'Danny'.
	otherShip moveBy: 10.

	firstEffect applyTo: shipThatLands withShips: { shipThatLands. otherShip }.
	self assert: otherShip position equals: 9.

	otherShip moveBy: 10.
	secondEffect applyTo: shipThatLands withShips: { shipThatLands. otherShip }.
	self assert: otherShip position equals: 14.
]

{ #category : 'tests' }
BoardTest >> test010WhenProbabilityFallsInHyperJumpRangeThenSquareHasHyperJump [

	| board loadedRandomProvider |
	loadedRandomProvider := LoadedRandomProvider with: 0.95 andHyperJumpValues: #(1).

	board := Board withSize: 1 using: loadedRandomProvider.

	self assert: (board effectAt: 1) class equals: HyperJump.
]

{ #category : 'tests' }
BoardTest >> test011WhenProbabilityFallsInHyperJumpRangeThenHyperJumpUsesGeneratedValues [

	| board loadedRandomProvider effect ship |
	loadedRandomProvider := LoadedRandomProvider
		with: 0.95
		andHyperJumpValues: #(10 5 2).

	board := Board withSize: 1 using: loadedRandomProvider.
	effect := board effectAt: 1.

	ship := Ship named: 'Walter'.

	effect applyTo: ship withShips: { ship }.

	self assert: ship position equals: 11.
]

{ #category : 'tests' }
BoardTest >> test012WhenProbabilityFallsInAtomicBombRangeThenSquareHasAtomicBomb [

	| board loadedRandomProvider |
	loadedRandomProvider := LoadedRandomProvider with: 0.99.

	board := Board withSize: 1 using: loadedRandomProvider.

	self assert: (board effectAt: 1) class equals: AtomicBomb.
]
