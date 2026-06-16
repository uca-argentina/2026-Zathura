Class {
	#name : 'LoadedRandomProvider',
	#superclass : 'Object',
	#instVars : [
		'probabilities',
		'probabilityIndex',
		'moonWalkDistances',
		'moonWalkDistanceIndex',
		'hyperJumpValuesLists',
		'hyperJumpValuesIndex',
		'hyperJumpUnit'
	],
	#classInstVars : [
		'probabilities',
		'probabilityIndex',
		'hyperJumpValues'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'instance creation' }
LoadedRandomProvider class >> with: aProbability [

	^ self
		withProbabilities: { aProbability }
		andMoonWalkDistances: #()
		andHyperJumpValues: #()
		unit: Parsec
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> with: aProbability andHyperJumpValues: someValues [

	^ self
		withProbabilities: { aProbability }
		andMoonWalkDistances: #()
		andHyperJumpValues: { someValues }
		unit: Parsec
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> with: aProbability andHyperJumpValues: someValues unit: aUnit [

	^ self
		withProbabilities: { aProbability }
		andMoonWalkDistances: #()
		andHyperJumpValues: { someValues }
		unit: aUnit
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> with: aProbability andMoonWalkDistance: aDistance [

	^ self
		withProbabilities: { aProbability }
		andMoonWalkDistances: { aDistance }
		andHyperJumpValues: #()
		unit: Parsec
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: aProbabilityList [

	^ self
		withProbabilities: aProbabilityList
		andMoonWalkDistances: #()
		andHyperJumpValues: #()
		unit: Parsec
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: someProbabilities andHyperJumpValuesLists: someHyperJumpValuesLists [

	^ self
		withProbabilities: someProbabilities
		andMoonWalkDistances: #()
		andHyperJumpValues: someHyperJumpValuesLists
		unit: Parsec
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: someProbabilities andMoonWalkDistances: someDistances [

	^ self
		withProbabilities: someProbabilities
		andMoonWalkDistances: someDistances
		andHyperJumpValues: #()
		unit: Parsec
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: someProbabilities andMoonWalkDistances: someDistances andHyperJumpValues: someHyperJumpValuesLists [

	^ self
		withProbabilities: someProbabilities
		andMoonWalkDistances: someDistances
		andHyperJumpValues: someHyperJumpValuesLists
		unit: Parsec
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: someProbabilities andMoonWalkDistances: someDistances andHyperJumpValues: someHyperJumpValuesLists unit: aUnit [

	^ self new
		initializeWithProbabilities: someProbabilities
		andMoonWalkDistances: someDistances
		andHyperJumpValuesLists: someHyperJumpValuesLists
		andHyperJumpUnit: aUnit
]

{ #category : 'accessing' }
LoadedRandomProvider >> initializeWithProbabilities: someProbabilities andMoonWalkDistances: someDistances andHyperJumpValuesLists: someValues andHyperJumpUnit: aUnit [
    probabilities := someProbabilities.
    probabilityIndex := 1.
    moonWalkDistances := someDistances.
    moonWalkDistanceIndex := 1.
    hyperJumpValuesLists := someValues.
    hyperJumpValuesIndex := 1.
    hyperJumpUnit := aUnit.
]

{ #category : 'accessing' }
LoadedRandomProvider >> nextEffectProbability [
	| value |
	value := probabilities at: probabilityIndex.
	probabilityIndex := probabilityIndex + 1.
	^ value
]

{ #category : 'accessing' }
LoadedRandomProvider >> nextHyperJumpUnit [
    ^ hyperJumpUnit.
]

{ #category : 'accessing' }
LoadedRandomProvider >> nextHyperJumpValues [
	| values |
	values := hyperJumpValuesLists at: hyperJumpValuesIndex.
	hyperJumpValuesIndex := hyperJumpValuesIndex + 1.
	^ values
]

{ #category : 'accessing' }
LoadedRandomProvider >> nextMoonWalkDistance [
	| value |
	value := moonWalkDistances at: moonWalkDistanceIndex.
	moonWalkDistanceIndex := moonWalkDistanceIndex + 1.
	^ value
]
