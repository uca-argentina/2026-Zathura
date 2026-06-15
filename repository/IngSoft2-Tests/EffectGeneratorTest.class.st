Class {
	#name : 'EffectGeneratorTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
EffectGeneratorTest >> test001WhenProbabilityFallsInNoEffectRangeThenGeneratesNoEffect [
	| provider effect |
	provider := LoadedRandomProvider withProbabilities: #(0.10).
	effect := EffectGenerator nextEffectUsing: provider andParsecPerSquare: 1.
	self assert: effect class equals: NoEffect.
]

{ #category : 'tests' }
EffectGeneratorTest >> test002WhenProbabilityFallsInCardGiverRangeThenGeneratesCardGiver [
	| provider effect |
	provider := LoadedRandomProvider withProbabilities: #(0.35).
	effect := EffectGenerator nextEffectUsing: provider andParsecPerSquare: 1.
	self assert: effect class equals: CardGiver.
]

{ #category : 'tests' }
EffectGeneratorTest >> test003WhenProbabilityFallsInWormHoleRangeThenGeneratesWormHole [
	| provider effect |
	provider := LoadedRandomProvider withProbabilities: #(0.50).
	effect := EffectGenerator nextEffectUsing: provider andParsecPerSquare: 1.
	self assert: effect class equals: WormHole.
]

{ #category : 'tests' }
EffectGeneratorTest >> test004WhenProbabilityFallsInSpeedUpRangeThenGeneratesSpeedUp [
	| provider effect |
	provider := LoadedRandomProvider withProbabilities: #(0.70).
	effect := EffectGenerator nextEffectUsing: provider andParsecPerSquare: 1.
	self assert: effect class equals: SpeedUp.
]

{ #category : 'tests' }
EffectGeneratorTest >> test005WhenProbabilityFallsInMoonWalkRangeThenGeneratesMoonWalk [
	| provider effect |
	provider := LoadedRandomProvider with: 0.85 andMoonWalkDistance: 1.
	effect := EffectGenerator nextEffectUsing: provider andParsecPerSquare: 1.
	self assert: effect class equals: MoonWalk.
]

{ #category : 'tests' }
EffectGeneratorTest >> test006WhenProbabilityFallsInHyperJumpRangeThenGeneratesHyperJump [
	| provider effect |
	provider := LoadedRandomProvider with: 0.95 andHyperJumpValues: #(1).
	effect := EffectGenerator nextEffectUsing: provider andParsecPerSquare: 1.
	self assert: effect class equals: HyperJump.
]

{ #category : 'tests' }
EffectGeneratorTest >> test007WhenProbabilityFallsInAtomicBombRangeThenGeneratesAtomicBomb [
	| provider effect |
	provider := LoadedRandomProvider withProbabilities: #(0.99).
	effect := EffectGenerator nextEffectUsing: provider andParsecPerSquare: 1.
	self assert: effect class equals: AtomicBomb.
]

{ #category : 'tests' }
EffectGeneratorTest >> test008WhenProbabilityIsGreaterThanOneThenGenerationFails [ 
	| provider |
	provider := LoadedRandomProvider with: 1.10.
	self
		should: [ EffectGenerator nextEffectUsing: provider andParsecPerSquare: 1 ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'Effect probability must be between 0 and 1' ].

]

{ #category : 'tests' }
EffectGeneratorTest >> test009WhenParsecPerSquareIsFractionalThenHyperJumpValuesAreRoundedToIntegerSquares [ 
	| provider effect ship |
	provider := LoadedRandomProvider with: 0.95 andHyperJumpValues: #(1).
	effect := EffectGenerator nextEffectUsing: provider andParsecPerSquare: (2/3).
	ship := Ship named: 'Nave' using: (LoadedCardProvider with: #(0 0)).
	effect applyTo: ship withShips: { ship }.
	self assert: ship position equals: 3.

]

{ #category : 'tests' }
EffectGeneratorTest >> test010WhenAskedIfEffectIsAbstractThenOnlyEffectClassAnswersTrue [

	self assert: Effect isAbstract.
	self deny: AtomicBomb isAbstract.

]
