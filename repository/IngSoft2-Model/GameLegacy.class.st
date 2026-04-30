Class {
	#name : 'GameLegacy',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'dices',
		'board',
		'state',
		'ended'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
GameLegacy class >> with: aNumberOfPlayers and: aDiceCollection and: aBoardSize [ 

	| aBoard  aShipCollection|
	aBoard:= Board withSize: aBoardSize.
	
	aShipCollection:=OrderedCollection new.
	1 to: aNumberOfPlayers do: [ :aShipId | aShipCollection add: (ShipLegacy knownBy:aShipId) ].
	
	^ (self new) initializeWith: aShipCollection and: aDiceCollection and: aBoard.
]

{ #category : 'initialization' }
GameLegacy >> ended [
	^ ended. 
]

{ #category : 'initialization' }
GameLegacy >> initializeWith: aShipCollection and: aDiceCollection and: aBoard [ 
	ships:=aShipCollection.
	dices:=aDiceCollection.
	board:=aBoard.
	ended:=false.
	
]

{ #category : 'initialization' }
GameLegacy >> playRound [

		
	| aShip aDice totalRoll |
	
	1 to: (ships size) do: [:i| (ended)ifFalse:[self playTurn] ]
	
]

{ #category : 'as yet unclassified' }
GameLegacy >> playTurn [

		
	| aShip aDice totalRoll |
	
	aShip:= ships removeFirst.
	ships add: aShip.
	
	totalRoll:= 0.
	dices do: [:aDice | totalRoll:=totalRoll + (aDice roll) ].
	
	aShip moveForward: totalRoll.
	
	ended := board winner:aShip. 
	
]
