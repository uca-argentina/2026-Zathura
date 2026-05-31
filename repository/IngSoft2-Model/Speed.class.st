Class {
	#name : 'Speed',
	#superclass : 'Card',
	#instVars : [
		'ship',
		'amount'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'actions' }
Speed >> applyTo: aShip in: aGame [ 
	ship := aShip.
	amount := 1.
	aGame addActiveCard: self.
]

{ #category : 'actions' }
Speed >> modifyRoll: aRoll forShip: aShip [
	aShip = ship ifTrue: [ ^ aRoll + amount ].
	^ aRoll
]
