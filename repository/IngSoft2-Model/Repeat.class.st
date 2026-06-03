Class {
	#name : 'Repeat',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'actions' }
Repeat >> applyTo: aShip in: aGame [ 
	aGame applyLastEffectTo: aShip.
]

{ #category : 'actions' }
Repeat >> initialize [ 
	isPermanent := false.
]
