Class {
	#name : 'Acceleration',
	#superclass : 'Card',
	#instVars : [
		'amount'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'actions' }
Acceleration >> applyTo: aShip in: aGame [ 
	amount := 1.
	aGame addActiveCard: self.
]

{ #category : 'actions' }
Acceleration >> modifyRoll: aRoll forShip: aShip [
	^ aRoll + amount.
]
