Class {
	#name : 'GameLegacyTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameLegacyTest >> test001WhenAnyShipReachesTheEndThenTheGameEnds [
	| aGame aNumberOfPlayers aDiceCollection aBoardSize |
	aNumberOfPlayers := 1.
	aBoardSize :=4.
	aDiceCollection := OrderedCollection new.
	aDiceCollection add: (HardcodeDice with: 3).
	aGame:= GameLegacy with: aNumberOfPlayers and: aDiceCollection and: aBoardSize.
	
	
	aGame playRound.
	
	self assert: (aGame ended).
]
