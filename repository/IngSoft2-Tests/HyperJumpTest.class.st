Class {
	#name : 'HyperJumpTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
HyperJumpTest >> test001WhenCreatedWithEmptyValuesThenShouldThrowError [

	self
		should: [ HyperJump with: #(  ) ]
		raise: Error
		withExceptionDo: [ :anError |
				self
					assert: anError messageText
					equals: 'HyperJump must have at least one value' ]
]
