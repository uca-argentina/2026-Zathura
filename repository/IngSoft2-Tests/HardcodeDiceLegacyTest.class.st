Class {
	#name : 'HardcodeDiceLegacyTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HardcodeDiceLegacyTest >> test001WhenAHardcodedDiceIsRolledThenTheResultIsTheExpectedResult [

| aRollResult expectedResult aHardcodeDice |
expectedResult := 3.
aHardcodeDice := HardcodeDice with: expectedResult.
aRollResult := aHardcodeDice roll.


self assert: (aRollResult = expectedResult)
]

{ #category : 'tests' }
HardcodeDiceLegacyTest >> test002WhenTheExpectedResultIsLessThanOneThenTheHardcodedDiceCannotBeCreated [

|  expectedResult  |
expectedResult := 0.
self should: [ HardcodeDice with: expectedResult. ]
raise: Error
withExceptionDo: [ :anError | self assert: anError messageText equals: 'The expected result should be one or higher' ].
]
