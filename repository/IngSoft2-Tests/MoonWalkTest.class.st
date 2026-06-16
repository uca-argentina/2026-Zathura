Class {
	#name : 'MoonWalkTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
MoonWalkTest >> test001WhenCreatedWithNonPositiveDistanceThenShouldThrowError [ 
	self should: [ MoonWalk with: 0 ]
	raise: Error
	withExceptionDo: [ :anError | self assert: anError messageText equals: 'MoonWalk distance must be greater than 0' ]

]
