Class {
	#name : 'DistanceConverter',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
DistanceConverter class >> convert: aValue from: aUnit toSquaresWithParsecPerSquare: aParsecPerSquare [
    ^ (aValue * (self parsecRatioFor: aUnit)) / aParsecPerSquare.
]

{ #category : 'as yet unclassified' }
DistanceConverter class >> lightYearRatioFor: aUnit [
    aUnit = Parsec ifTrue: [ ^ 3 ].
    aUnit = LightYear ifTrue: [ ^ 1 ].
    Error signal: 'Unknown unit'.
]

{ #category : 'as yet unclassified' }
DistanceConverter class >> parsecRatioFor: aUnit [
    aUnit = Parsec ifTrue: [ ^ 1 ].
    aUnit = LightYear ifTrue: [ ^ 1/3 ].
    Error signal: 'Unknown unit'.
]
