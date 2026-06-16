Class {
	#name : 'Overload',
	#superclass : 'Card',
	#instVars : [
		'ship',
		'amount'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'actions' }
Overload >> applyTo: aShip in: aGame [ 
	ship := aShip.
	amount := 2.
	aGame addActiveCard: self.
]

{ #category : 'actions' }
Overload >> initialize [ 
	isPermanent := true.
]

{ #category : 'actions' }
Overload >> modifyRoll: aRoll forShip: aShip [
	aShip = ship ifTrue: [ ^aRoll - amount ].
	^ aRoll
]
