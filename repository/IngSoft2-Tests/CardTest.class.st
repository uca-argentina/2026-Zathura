Class {
	#name : 'CardTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
CardTest >> test001WhenAskedIfCardIsAbstractThenOnlyCardClassAnswersTrue [

	self assert: Card isAbstract.
	self deny: Overload isAbstract.
]

{ #category : 'tests' }
CardTest >> test002WhenProbabilityIsInFirstRangeThenCreatesOverload [

	self assert: (Card fromProbability: 0.10) class equals: Overload
]

{ #category : 'tests' }
CardTest >> test003WhenProbabilityIsInSecondRangeThenCreatesSpeed [

	self assert: (Card fromProbability: 0.20) class equals: Speed
]

{ #category : 'tests' }
CardTest >> test004WhenProbabilityIsInThirdRangeThenCreatesAcceleration [

	self assert: (Card fromProbability: 0.40) class equals: Acceleration
]

{ #category : 'tests' }
CardTest >> test005WhenProbabilityIsInFourthRangeThenCreatesCancellation [

	self assert: (Card fromProbability: 0.60) class equals: Cancellation
]

{ #category : 'tests' }
CardTest >> test006WhenProbabilityIsInFifthRangeThenCreatesRedo [

	self assert: (Card fromProbability: 0.80) class equals: Redo
]

{ #category : 'tests' }
CardTest >> test007WhenProbabilityIsInLastRangeThenCreatesRepeat [

	self assert: (Card fromProbability: 0.95) class equals: Repeat
]
