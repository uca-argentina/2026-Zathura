Class {
	#name : 'LoadedDiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
LoadedDiceTest >> test001WhenAHardcodedDiceIsRolledThenTheResultIsTheExpectedResult [

| aRollResult expectedResult aHardcodeDice |
expectedResult := 3.
aHardcodeDice := LoadedDice with: expectedResult.
aRollResult := aHardcodeDice roll.


self assert: aRollResult equals: expectedResult
]

{ #category : 'tests' }
LoadedDiceTest >> test002WhenTheExpectedResultIsLessThanOneThenTheHardcodedDiceCannotBeCreated [

|  expectedResult  |
expectedResult := 0.
self should: [ LoadedDice with: expectedResult. ]
raise: Error
withExceptionDo: [ :anError | self assert: anError messageText equals: 'The expected result should be one or higher' ].
]
