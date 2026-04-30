Class {
	#name : 'HardcodedDiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HardcodedDiceTest >> test002WhenTheExpectedResultIsLessThanOneThenTheHardcodedDiceCannotBeCreated [

|  expectedResult  |
expectedResult := 0.
self should: [ HardcodedDice with: expectedResult. ]
raise: Error
withExceptionDo: [ :anError | self assert: anError messageText equals: 'The expected result should be one or higher' ].
]
