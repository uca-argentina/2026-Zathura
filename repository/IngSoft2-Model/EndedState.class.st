Class {
	#name : 'EndedState',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
EndedState >> ended [ 
	^ true
]

{ #category : 'accessing' }
EndedState >> playTurn: aGame [
	aGame playTurnAsEnded.
]
