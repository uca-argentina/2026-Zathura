Class {
	#name : 'BoardTest',
	#superclass : 'TestCase',
	#instVars : [
		'board'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'as yet unclassified' }
BoardTest >> boardWithSize: aSize length: aLength andWithProbability: aProbability [
    ^ Board withSize: aSize length: aLength unit: Parsec 
            using: (LoadedRandomProvider with: aProbability).
]

{ #category : 'tests' }
BoardTest >> test001WhenBoardIsCreatedWithASizeThenBoardSizeShouldBeThatSize [
    board := Board withSize: 5 andParsecLength: 1 using: (LoadedRandomProvider withProbabilities: {0.4 . 0.4 . 0.4 . 0.4 . 0.4}).
    self assert: (board numSquares) equals: 5.
]

{ #category : 'tests' }
BoardTest >> test002WhenBoardIsCreatedWithSizeLessOrEqualToZeroThenShouldThrowError [
    self should: [ Board withSize: 0 andParsecLength: 4 using: (LoadedRandomProvider with: 0.4)] raise: Error.
    self should: [ Board withSize: -1 andParsecLength: 4 using: (LoadedRandomProvider with: 0.4) ] raise: Error.
]

{ #category : 'tests' }
BoardTest >> test003WhenBoardIsCreatedWithFloatSizeThenShouldThrowError [
    self should: [ Board withSize: 5.5 andParsecLength: 4 using: (LoadedRandomProvider withProbabilities: {0.4 . 0.4 . 0.4 . 0.4 . 0.4 . 0.4}) ] raise: Error.
]

{ #category : 'tests' }
BoardTest >> test004WhenBoardIsCreatedWithParsecSizeThenItReturndTheParsecLength [

	|  randomProvider |
	randomProvider := RandomProvider withMaxMoonWalkDistance: 10.

	board := Board withSize: 20 andParsecLength: 4  using: randomProvider.

	self assert: board parsecPerSquare equals: 4/20.
]

{ #category : 'tests' }
BoardTest >> test005WhenBoardIsCreatedWithParsecLengthLessOrEqualToZeroThenShouldThrowError [
    self should: [ Board withSize: 20 andParsecLength: 0 using: (LoadedRandomProvider with: 0.4)] raise: Error.
    self should: [ Board withSize: 20 andParsecLength: -1 using: (LoadedRandomProvider with: 0.4) ] raise: Error.
]

{ #category : 'tests' }
BoardTest >> test006WhenBoardIsCreatedWithFloatParsecLEngthThenShouldThrowError [
    self should: [ Board withSize: 20 andParsecLength: 4.5 using: (LoadedRandomProvider withProbabilities: {0.4 . 0.4 . 0.4 . 0.4 . 0.4 . 0.4}) ] raise: Error.
]

{ #category : 'tests' }
BoardTest >> test007WhenBoardIsCreatedThenEachPositionHasASquare [
    board := Board withSize: 5 andParsecLength: 1 using: (LoadedRandomProvider withProbabilities: {0.4 . 0.4 . 0.4 . 0.4 . 0.4}).
    1 to: 5 do: [:i | self assert: (board squareAt: i) class equals: Square].
]

{ #category : 'tests' }
BoardTest >> test008WhenProbabilityFallsInMoonWalkRangeThenMoonWalkUsesGeneratedDistance [

	| loadedProbability effect shipThatLands otherShip cardProvider |
	loadedProbability := LoadedRandomProvider
	
		with: 0.85
		andMoonWalkDistance: 2.

	board := Board withSize: 1  andParsecLength: 1 using: loadedProbability.
	effect := board effectAt: 1.
	
	cardProvider := CardProvider new.
	
	shipThatLands := Ship named: 'Walter' using: cardProvider.
	otherShip := Ship named: 'Danny'using: cardProvider.
	otherShip moveBy: 4.

	effect applyTo: shipThatLands withShips: { shipThatLands. otherShip }.

	self assert: otherShip position equals: 3.
	self assert: shipThatLands position equals: 1.
]

{ #category : 'tests' }
BoardTest >> test009WhenTwoMoonWalkSquaresAreGeneratedThenEachUsesADifferentGeneratedDistance [

	| loadedRandomProvider firstEffect secondEffect shipThatLands otherShip |
	loadedRandomProvider := LoadedRandomProvider
		withProbabilities: #(0.85 0.85)
		andMoonWalkDistances: #(2 5).

	board := Board withSize: 2 andParsecLength: 1 using: loadedRandomProvider.

	firstEffect := board effectAt: 1.
	secondEffect := board effectAt: 2.

	shipThatLands := Ship named: 'Walter' using: CardProvider new.
	otherShip := Ship named: 'Danny' using: CardProvider new.
	otherShip moveBy: 10.

	firstEffect applyTo: shipThatLands withShips: { shipThatLands. otherShip }.
	self assert: otherShip position equals: 9.

	otherShip moveBy: 10.
	secondEffect applyTo: shipThatLands withShips: { shipThatLands. otherShip }.
	self assert: otherShip position equals: 14.
]

{ #category : 'tests' }
BoardTest >> test010WhenProbabilityFallsInHyperJumpRangeThenHyperJumpUsesGeneratedValues [

	| loadedRandomProvider effect ship |
	loadedRandomProvider := LoadedRandomProvider
		with: 0.95
		andHyperJumpValues: #(5 10 2). "los tiene que ordenar"

	board := Board withSize: 1 andParsecLength: 1 using: loadedRandomProvider.
	effect := board effectAt: 1.

	ship := Ship named: 'Walter' using: CardProvider new.

	effect applyTo: ship withShips: { ship }.

	self assert: ship position equals: 11.
]

{ #category : 'tests' }
BoardTest >> test011WhenBoardHasManySquaresThenEachSquareUsesNextGeneratedProbability [

	|  loadedRandomProvider |
	loadedRandomProvider := LoadedRandomProvider
		withProbabilities: #(0.10 0.50 0.70 0.99)
		andMoonWalkDistances: #().

	board := Board withSize: 4 andParsecLength: 1 using: loadedRandomProvider.

	self assert: (board effectAt: 1) class equals: NoEffect.
	self assert: (board effectAt: 2) class equals: WormHole.
	self assert: (board effectAt: 3) class equals: SpeedUp.
	self assert: (board effectAt: 4) class equals: AtomicBomb.
]

{ #category : 'tests' }
BoardTest >> test012WhenBoardGeneratesConfigurableEffectsThenEachUsesItsGeneratedConfiguration [

	| loadedRandomProvider moonWalkEffect hyperJumpEffect shipThatLands otherShip jumpingShip |
	loadedRandomProvider := LoadedRandomProvider
		withProbabilities: #(0.85 0.95)
		andMoonWalkDistances: #(3)
		andHyperJumpValues: {#(10 5 2)}.

	board := Board withSize: 2 andParsecLength: 1 using: loadedRandomProvider.

	moonWalkEffect := board effectAt: 1.
	hyperJumpEffect := board effectAt: 2.

	shipThatLands := Ship named: 'Walter' using: CardProvider new.
	otherShip := Ship named: 'Danny' using: CardProvider new.
	otherShip moveBy: 5.

	moonWalkEffect applyTo: shipThatLands withShips: { shipThatLands. otherShip }.
	self assert: otherShip position equals: 3.

	jumpingShip := Ship named: 'Lisa' using: CardProvider new.
	hyperJumpEffect applyTo: jumpingShip withShips: { jumpingShip }.
	self assert: jumpingShip position equals: 21.
]

{ #category : 'tests' }
BoardTest >> test013WhenTwoHyperJumpSquaresAreGeneratedThenEachUsesDifferentGeneratedValues [

	|  loadedRandomProvider firstHyperJump secondHyperJump firstShip secondShip |
	loadedRandomProvider := LoadedRandomProvider
		withProbabilities: #(0.95 0.95)
		andHyperJumpValuesLists: { #(10 5 2). #(7 4 1) }.

	board := Board withSize: 2 andParsecLength: 1 using: loadedRandomProvider.

	firstHyperJump := board effectAt: 1.
	secondHyperJump := board effectAt: 2.

	firstShip := Ship named: 'Walter' using: CardProvider new.
	secondShip := Ship named: 'Danny' using: CardProvider new.

	firstHyperJump applyTo: firstShip withShips: { firstShip }.
	secondHyperJump applyTo: secondShip withShips: { secondShip }.

	self assert: firstShip position equals: 21.
	self assert: secondShip position equals: 15.
]

{ #category : 'tests' }
BoardTest >> test014WhenBoardIsCreatedWithRandomProviderThenAllSquaresHaveAnEffect [

	|  randomProvider |
	randomProvider := RandomProvider withMaxMoonWalkDistance: 10.

	board := Board withSize: 20 andParsecLength: 1 using: randomProvider.

	1 to: board numSquares do: [ :position |
		self deny: (board effectAt: position) isNil ].
]

{ #category : 'tests' }
BoardTest >> test015WhenBoardIsAskLengthInLightYearsThenParsecConversionIsCorrect [
	|loadedRandomProvider|
	loadedRandomProvider := LoadedRandomProvider
		with: 0.95
		andHyperJumpValues: #(5 10 2). "los tiene que ordenar"

	board := Board withSize: 1 andParsecLength: 12 using: loadedRandomProvider.
	self assert: board lightSize equals: 36.
]

{ #category : 'tests' }
BoardTest >> test016WhenBoardIsCreatedWithParsecsUnitThenParsecPerSquareIsCorrect [
    board := Board withSize: 6 length: 3 unit: Parsec using:
        (LoadedRandomProvider withProbabilities: #(0.1 0.1 0.1 0.1 0.1 0.1)).
    self assert: board parsecPerSquare equals: 1/2.
]

{ #category : 'tests' }
BoardTest >> test017WhenBoardIsCreatedWithLightYearUnitThenParsecPerSquareAndLightSizeAreCorrect [
    board := Board withSize: 6 length: 9 unit: LightYear using:
        (LoadedRandomProvider withProbabilities: #(0.1 0.1 0.1 0.1 0.1 0.1)).
    self assert: board parsecPerSquare equals: 1/2.
    self assert: board lightSize equals: 9.
]

{ #category : 'tests' }
BoardTest >> test018WhenHyperJumpValuesAreInParsecsWithUnitThenShipMovesCorrectly [
    | provider ship |
    provider := LoadedRandomProvider with: 0.95 andHyperJumpValues: #(5 10 2) unit: Parsec.
    board := Board withSize: 1 length: 1 unit: Parsec using: provider.
    ship := Ship named: 'Walter' using: CardProvider new.
    (board effectAt: 1) applyTo: ship withShips: { ship }.
    self assert: ship position equals: 11.
]

{ #category : 'tests' }
BoardTest >> test019WhenHyperJumpValuesAreInLightYearsThenConversionIsCorrect [
    | provider  ship |
    provider := LoadedRandomProvider with: 0.95 andHyperJumpValues: #(9 6 3) unit: LightYear.
    board := Board withSize: 1 length: 1 unit: Parsec using: provider.
    ship := Ship named: 'Walter' using: CardProvider new.
    (board effectAt: 1) applyTo: ship withShips: { ship }.
    self assert: ship position equals: 4.
]
