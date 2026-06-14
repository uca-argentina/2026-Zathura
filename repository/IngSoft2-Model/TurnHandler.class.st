Class {
	#name : 'TurnHandler',
	#superclass : 'Object',
	#instVars : [
		'ships',
		'currentShipIndex'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
TurnHandler class >> for: aCollectionOfShips [ 
	^ self new initializeFor: aCollectionOfShips .
]

{ #category : 'accessing' }
TurnHandler >> initializeFor: aCollectionOfShips [
	ships:= aCollectionOfShips .
	currentShipIndex := 1.
]

{ #category : 'accessing' }
TurnHandler >> prepareNextTurn [
	currentShipIndex := (currentShipIndex \\ ships size) + 1.
]

{ #category : 'accessing' }
TurnHandler >> validateTurnOf: aShip [
	| currentShip |
	currentShip := ships at:currentShipIndex.
	(aShip = currentShip) ifFalse: [ Error signal: 'It is not this ships turn'].
]

{ #category : 'accessing' }
TurnHandler >> whoseTurnIsIt [
	^ ships at: currentShipIndex.
]
