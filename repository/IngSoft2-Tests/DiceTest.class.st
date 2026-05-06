Class {
	#name : 'DiceTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DiceTest >> test001WhenANSidedDiceRollsThenTheResultIsBetween1AndN [
	| rollResult numberOfSides aDice |
	numberOfSides :=6.
	aDice:= Dice with:numberOfSides.
	rollResult := aDice roll.
	self assert: (rollResult between: 1 and:numberOfSides).   
]

{ #category : 'tests' }
DiceTest >> test002WhenTheNumberOfSidesIsLessThan3ThenTheDiceCannotBeInstanced [
	|numberOfSides|
	numberOfSides :=2.
	self should: [Dice with:numberOfSides]
	raise: Error
	withExceptionDo: [:anError|self assert: anError messageText equals: 'Number of sides should be 3 or greater'].   
]
