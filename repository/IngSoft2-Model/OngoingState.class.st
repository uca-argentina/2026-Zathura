Class {
	#name : 'OngoingState',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
OngoingState >> ended [
	^false.
]

{ #category : 'accessing' }
OngoingState >> playTurn: aGame [
	aGame playTurnAsOngoing.
]
