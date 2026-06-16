Class {
	#name : 'CardGiver',
	#superclass : 'Effect',
	#instVars : [
		'cardProvider'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
CardGiver >> applyTo: aShip withShips: allShips [
	|aCard|
	aCard := Card fromProbability: (cardProvider  nextCardProbability).
	aShip addCard: aCard.
]

{ #category : 'initialization' }
CardGiver >> initialize [
    cardProvider := CardProvider new.
]
