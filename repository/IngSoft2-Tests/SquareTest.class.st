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
SquareTest >> test001WhenProbabilityFallsInNoEffectRangeThenSquareHasNoEffect [
	|provider| 
	provider := LoadedRandomProvider withProbabilities: #(0.10).
	square := Square withId: 1 andRandomProvider: provider andParsecPerSquare: 1.
	self assert: square  effect class equals: NoEffect.
]

{ #category : 'tests' }
SquareTest >> test002WhenProbabilityFallsInWormHoleRangeThenSquareHasWormHole [
	|provider| 
	provider := LoadedRandomProvider withProbabilities: #(0.50).
	square := Square withId: 1 andRandomProvider: provider andParsecPerSquare: 1.
	self assert: square  effect class equals: WormHole .
]

{ #category : 'tests' }
SquareTest >> test003WhenProbabilityFallsInSpeedUpRangeThenSquareHasSpeedUp [
	|provider| 
	provider := LoadedRandomProvider withProbabilities: #(0.70).
	square := Square withId: 1 andRandomProvider: provider andParsecPerSquare: 1.
	self assert: square  effect class equals: SpeedUp .
]

{ #category : 'tests' }
SquareTest >> test004WhenProbabilityFallsInMoonWalkRangeThenSquareHasMoonWalk [
	
	|provider| 
	provider := LoadedRandomProvider with: 0.85 andMoonWalkDistance: 1.
	square := Square withId: 1 andRandomProvider: provider andParsecPerSquare: 1.
	self assert: square  effect class equals: MoonWalk .
]

{ #category : 'tests' }
SquareTest >> test005WhenProbabilityFallsInHyperJumpRangeThenSquareHasHyperJump [

	| loadedRandomProvider |
	loadedRandomProvider := LoadedRandomProvider with: 0.95 andHyperJumpValues: #(1).
	square := Square withId: 1 andRandomProvider: loadedRandomProvider andParsecPerSquare: 1.
	self assert: square  effect class equals: HyperJump.
]

{ #category : 'tests' }
SquareTest >> test006WhenProbabilityFallsInAtomicBombRangeThenSquareHasAtomicBomb [
	|provider| 
	provider := LoadedRandomProvider withProbabilities: #(0.99).
	square := Square withId: 1 andRandomProvider: provider andParsecPerSquare: 1.
	self assert: square  effect class equals: AtomicBomb.
]

{ #category : 'tests' }
SquareTest >> test007WhenProbabilityIsGreaterThanOneThenBoardCreationFails [

	| loadedRandomProvider |
	loadedRandomProvider := LoadedRandomProvider with: 1.10.

	self
		should: [ Board withSize: 1 andParsecLength: 1 using: loadedRandomProvider ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'Effect probability must be between 0 and 1' ].
]
