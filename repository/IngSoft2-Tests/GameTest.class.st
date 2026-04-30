Class {
	#name : 'GameTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
GameTest >> test001WhenAGameIsCreatedThenItCanBePlayed [
	
	| aGame |
	aGame:= Game new.
	self deny: (aGame ended )
]

{ #category : 'tests' }
GameTest >> test002WhenAGameIsCreatedWithXNumberSquaresThenItsNumberOfSquaresIsX [
	
	| aGame aSize |
	aSize:=10.
	aGame:= Game with:aSize and: 1.
	self assert: (aGame numberOfSquares = aSize )
]

{ #category : 'tests' }
GameTest >> test003WhenAGameIsCreatedThenAllThePlayersStartAt1 [
	
	| aGame aSize aNumberOfPlayers aNumberOfShips |
	aNumberOfShips=1.
	aSize:=10.
	aGame:= Game with:aSize and: aNumberOfShips.
	self assert: (aGame standings = 1)
]

{ #category : 'tests' }
GameTest >> test004WhenATurnIsPlayedThenAShipMovesAccordingly [
	
	| aGame aSize aNumberOfPlayers aNumberOfShips |
	aNumberOfShips=1.
	aSize:=10.
	aGame:= Game with:aSize and: aNumberOfShips.
	aGame playTurn.
	self assert: (aGame standings ~= 1)
]
