Class {
	#name : 'DistanceConverterTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
DistanceConverterTest >> test001WhenConvertingParsecsToSquaresThenResultIsCorrect [
    self assert: (DistanceConverter convert: 5 from: Parsec toSquaresWithParsecPerSquare: 1)
         equals: 5.
]

{ #category : 'tests' }
DistanceConverterTest >> test002WhenConvertingLightYearsToSquaresThenResultIsCorrect [
    self assert: (DistanceConverter convert: 3 from: LightYear toSquaresWithParsecPerSquare: 1)
         equals: 1.
]

{ #category : 'tests' }
DistanceConverterTest >> test003WhenConvertingLightYearsWithSmallerSquaresThenResultScalesCorrectly [
    self assert: (DistanceConverter convert: 6 from: LightYear toSquaresWithParsecPerSquare: 2)
         equals: 1.
]
