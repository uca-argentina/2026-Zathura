Class {
	#name : 'SquareTest',
	#superclass : 'TestCase',
	#instVars : [
		'square'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
SquareTest >> test001WhenCreatedWithIdAndEffectThenSquareHasThatEffect [ 
	square := Square withId: 1 effect: NoEffect new.
	self assert: square effect class equals: NoEffect.
]
