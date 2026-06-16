Class {
	#name : 'Redo',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'actions' }
Redo >> applyTo: aShip in: aGame [ 
	aGame replayLastCardTargeting: aShip.
]

{ #category : 'actions' }
Redo >> initialize [ 
	isPermanent := false.
]
