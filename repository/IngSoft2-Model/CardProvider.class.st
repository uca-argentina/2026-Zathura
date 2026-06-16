Class {
	#name : 'CardProvider',
	#superclass : 'Object',
	#instVars : [
		'random'
	],
	#classInstVars : [
		'random'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
CardProvider >> initialize [ 
	random := Random new.
]

{ #category : 'as yet unclassified' }
CardProvider >> nextCardProbability [
	^random next.
]
