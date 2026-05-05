Class {
	#name : 'HardcodedDiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HardcodedDiceTest >> test001WhenAHardcodedDiceIsRolledThenTheResultIsTheExpectedResult [

| aRollResult expectedResult aHardcodeDice |
expectedResult := 3.
aHardcodeDice := HardcodedDice with: expectedResult.
aRollResult := aHardcodeDice roll.


self assert: aRollResult equals: expectedResult
]

{ #category : 'tests' }
HardcodedDiceTest >> test002WhenTheExpectedResultIsLessThanOneThenTheHardcodedDiceCannotBeCreated [

|  expectedResult  |
expectedResult := 0.
self should: [ HardcodedDice with: expectedResult. ]
raise: Error
withExceptionDo: [ :anError | self assert: anError messageText equals: 'The expected result should be one or higher' ].
]
