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

{ #category : 'accessing' }
TurnHandler >> initializeFor: aCollectionOfShips [
	ships:= aCollectionOfShips .
	currentShipIndex := 1.
]

{ #category : 'accessing' }
TurnHandler >> playTurnFor: aShip [
	| currentShip |
	currentShip := ships at:currentShipIndex.
	(aShip = currentShip) ifFalse: [ Error signal: 'It is not this ships turn'].
]

{ #category : 'accessing' }
TurnHandler >> prepareNextTurn [
	currentShipIndex := (currentShipIndex \\ ships size) + 1.
]

{ #category : 'accessing' }
TurnHandler >> whoseTurnIsIt [
	^ ships at: currentShipIndex.
]
