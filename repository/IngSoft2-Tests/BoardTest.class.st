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

{ #category : 'tests' }
BoardTest >> test013WhenBoardHasManySquaresThenEachSquareUsesNextGeneratedProbability [

	| board loadedRandomProvider |
	loadedRandomProvider := LoadedRandomProvider
		withProbabilities: #(0.10 0.50 0.70 0.99)
		andMoonWalkDistances: #().

	board := Board withSize: 4 using: loadedRandomProvider.

	self assert: (board effectAt: 1) class equals: NoEffect.
	self assert: (board effectAt: 2) class equals: WormHole.
	self assert: (board effectAt: 3) class equals: SpeedUp.
	self assert: (board effectAt: 4) class equals: AtomicBomb.
]

{ #category : 'tests' }
BoardTest >> test014WhenBoardGeneratesConfigurableEffectsThenEachUsesItsGeneratedConfiguration [

	| board loadedRandomProvider moonWalkEffect hyperJumpEffect shipThatLands otherShip jumpingShip |
	loadedRandomProvider := LoadedRandomProvider
		withProbabilities: #(0.85 0.95)
		andMoonWalkDistances: #(3)
		andHyperJumpValues: #(10 5 2).

	board := Board withSize: 2 using: loadedRandomProvider.

	moonWalkEffect := board effectAt: 1.
	hyperJumpEffect := board effectAt: 2.

	shipThatLands := Ship named: 'Walter'.
	otherShip := Ship named: 'Danny'.
	otherShip moveBy: 5.

	moonWalkEffect applyTo: shipThatLands withShips: { shipThatLands. otherShip }.
	self assert: otherShip position equals: 3.

	jumpingShip := Ship named: 'Lisa'.
	hyperJumpEffect applyTo: jumpingShip withShips: { jumpingShip }.
	self assert: jumpingShip position equals: 11.
]

{ #category : 'tests' }
BoardTest >> test015WhenTwoHyperJumpSquaresAreGeneratedThenEachUsesDifferentGeneratedValues [

	| board loadedRandomProvider firstHyperJump secondHyperJump firstShip secondShip |
	loadedRandomProvider := LoadedRandomProvider
		withProbabilities: #(0.95 0.95)
		andHyperJumpValuesLists: { #(10 5 2). #(7 4 1) }.

	board := Board withSize: 2 using: loadedRandomProvider.

	firstHyperJump := board effectAt: 1.
	secondHyperJump := board effectAt: 2.

	firstShip := Ship named: 'Walter'.
	secondShip := Ship named: 'Danny'.

	firstHyperJump applyTo: firstShip withShips: { firstShip }.
	secondHyperJump applyTo: secondShip withShips: { secondShip }.

	self assert: firstShip position equals: 11.
	self assert: secondShip position equals: 8.
]

{ #category : 'tests' }
BoardTest >> test016WhenProbabilityIsGreaterThanOneThenBoardCreationFails [

	| loadedRandomProvider |
	loadedRandomProvider := LoadedRandomProvider with: 1.10.

	self
		should: [ Board withSize: 1 using: loadedRandomProvider ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'Effect probability must be between 0 and 1' ].
]

{ #category : 'tests' }
BoardTest >> test017WhenBoardIsCreatedWithRandomProviderThenAllSquaresHaveAnEffect [

	| board randomProvider |
	randomProvider := RandomProvider withMaxMoonWalkDistance: 10.

	board := Board withSize: 20 using: randomProvider.

	1 to: board numSquares do: [ :position |
		self deny: (board effectAt: position) isNil ].
]
