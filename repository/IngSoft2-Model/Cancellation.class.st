Class {
	#name : 'Cancellation',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'actions' }
Cancellation >> applyTo: aCard in: aGame [ 
	aGame removeActiveCard: aCard.
]
