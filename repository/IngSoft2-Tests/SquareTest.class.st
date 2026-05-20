Class {
	#name : 'SquareTest',
	#superclass : 'TestCase',
	#instVars : [
		'square'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SquareTest >> test004WhenProbabilityFallsInNoEffectRangeThenSquareHasNoEffect [
	self assert: ((self boardWithSize: 1 AndPasrsecLength: 1 AndWithLoadProbability: 0.10 )effectAt: 1) class equals: NoEffect.
]

{ #category : 'tests' }
SquareTest >> test005WhenProbabilityFallsInWormHoleRangeThenSquareHasWormHole [
	self assert: ((self boardWithSize: 1 AndPasrsecLength: 1 AndWithLoadProbability: 0.50 )effectAt: 1) class equals: WormHole.
]

{ #category : 'tests' }
SquareTest >> test006WhenProbabilityFallsInSpeedUpRangeThenSquareHasSpeedUp [
	self assert: ((self boardWithSize: 1 AndPasrsecLength: 1 AndWithLoadProbability: 0.70 )effectAt: 1) class equals: SpeedUp.
]

{ #category : 'tests' }
SquareTest >> test007WhenProbabilityFallsInMoonWalkRangeThenSquareHasMoonWalk [
	| loadedProbability |
    loadedProbability := LoadedRandomProvider with: 0.85 andMoonWalkDistance: 1.
    board := Board withSize: 1  andPasrsecLength: 1 using: loadedProbability.
    self assert: (board effectAt: 1) class equals: MoonWalk.
]

{ #category : 'tests' }
SquareTest >> test008WhenProbabilityFallsInMoonWalkRangeThenMoonWalkUsesGeneratedDistance [

	| loadedProbability effect shipThatLands otherShip |
	loadedProbability := LoadedRandomProvider
		with: 0.85
		andMoonWalkDistance: 2.

	board := Board withSize: 1  andPasrsecLength: 1 using: loadedProbability.
	effect := board effectAt: 1.

	shipThatLands := Ship named: 'Walter'.
	otherShip := Ship named: 'Danny'.
	otherShip moveBy: 4.

	effect applyTo: shipThatLands withShips: { shipThatLands. otherShip }.

	self assert: otherShip position equals: 3.
	self assert: shipThatLands position equals: 1.
]

{ #category : 'tests' }
SquareTest >> test009WhenTwoMoonWalkSquaresAreGeneratedThenEachUsesADifferentGeneratedDistance [

	| loadedRandomProvider firstEffect secondEffect shipThatLands otherShip |
	loadedRandomProvider := LoadedRandomProvider
		withProbabilities: #(0.85 0.85)
		andMoonWalkDistances: #(2 5).

	board := Board withSize: 2 andPasrsecLength: 1 using: loadedRandomProvider.

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
SquareTest >> test010WhenProbabilityFallsInHyperJumpRangeThenSquareHasHyperJump [

	| loadedRandomProvider |
	loadedRandomProvider := LoadedRandomProvider with: 0.95 andHyperJumpValues: #(1).

	board := Board withSize: 1 andPasrsecLength: 1 using: loadedRandomProvider.

	self assert: (board effectAt: 1) class equals: HyperJump.
]

{ #category : 'tests' }
SquareTest >> test011WhenProbabilityFallsInHyperJumpRangeThenHyperJumpUsesGeneratedValues [

	| loadedRandomProvider effect ship |
	loadedRandomProvider := LoadedRandomProvider
		with: 0.95
		andHyperJumpValues: #(5 10 2). "los tiene que ordenar"

	board := Board withSize: 1 andPasrsecLength: 1 using: loadedRandomProvider.
	effect := board effectAt: 1.

	ship := Ship named: 'Walter'.

	effect applyTo: ship withShips: { ship }.

	self assert: ship position equals: 11.
]

{ #category : 'tests' }
SquareTest >> test012WhenProbabilityFallsInAtomicBombRangeThenSquareHasAtomicBomb [
	self assert:  ((self boardWithSize: 1 AndPasrsecLength: 1 AndWithLoadProbability: 0.99 )effectAt: 1) class equals: AtomicBomb.
]

{ #category : 'tests' }
SquareTest >> test013WhenBoardHasManySquaresThenEachSquareUsesNextGeneratedProbability [

	|  loadedRandomProvider |
	loadedRandomProvider := LoadedRandomProvider
		withProbabilities: #(0.10 0.50 0.70 0.99)
		andMoonWalkDistances: #().

	board := Board withSize: 4 andPasrsecLength: 1 using: loadedRandomProvider.

	self assert: (board effectAt: 1) class equals: NoEffect.
	self assert: (board effectAt: 2) class equals: WormHole.
	self assert: (board effectAt: 3) class equals: SpeedUp.
	self assert: (board effectAt: 4) class equals: AtomicBomb.
]

{ #category : 'tests' }
SquareTest >> test014WhenBoardGeneratesConfigurableEffectsThenEachUsesItsGeneratedConfiguration [

	| loadedRandomProvider moonWalkEffect hyperJumpEffect shipThatLands otherShip jumpingShip |
	loadedRandomProvider := LoadedRandomProvider
		withProbabilities: #(0.85 0.95)
		andMoonWalkDistances: #(3)
		andHyperJumpValues: {#(10 5 2)}.

	board := Board withSize: 2 andPasrsecLength: 1 using: loadedRandomProvider.

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
SquareTest >> test015WhenTwoHyperJumpSquaresAreGeneratedThenEachUsesDifferentGeneratedValues [

	|  loadedRandomProvider firstHyperJump secondHyperJump firstShip secondShip |
	loadedRandomProvider := LoadedRandomProvider
		withProbabilities: #(0.95 0.95)
		andHyperJumpValuesLists: { #(10 5 2). #(7 4 1) }.

	board := Board withSize: 2 andPasrsecLength: 1 using: loadedRandomProvider.

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
SquareTest >> test016WhenProbabilityIsGreaterThanOneThenBoardCreationFails [

	| loadedRandomProvider |
	loadedRandomProvider := LoadedRandomProvider with: 1.10.

	self
		should: [ Board withSize: 1 andPasrsecLength: 1 using: loadedRandomProvider ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'Effect probability must be between 0 and 1' ].
]

{ #category : 'tests' }
SquareTest >> test017WhenBoardIsCreatedWithRandomProviderThenAllSquaresHaveAnEffect [

	|  randomProvider |
	randomProvider := RandomProvider withMaxMoonWalkDistance: 10.

	board := Board withSize: 20 andPasrsecLength: 1 using: randomProvider.

	1 to: board numSquares do: [ :position |
		self deny: (board effectAt: position) isNil ].
]
