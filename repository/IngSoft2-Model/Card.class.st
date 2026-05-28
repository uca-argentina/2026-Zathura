Class {
	#name : 'Card',
	#superclass : 'Object',
	#instVars : [
		'isPermanent'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'testing' }
Card class >> isAbstract [

	^ self == Card
]
