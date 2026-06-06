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
     ^ self new initializeWithProbabilities: { aProbability }
               andMoonWalkDistances: #()
               andHyperJumpValuesLists: #()
               andHyperJumpUnit: Parsec.
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> with: aProbability andHyperJumpValues: someValues [
	 ^ self new initializeWithProbabilities: { aProbability }
               andMoonWalkDistances: #()
               andHyperJumpValuesLists: { someValues }
               andHyperJumpUnit: Parsec.
]

{ #category : 'as yet unclassified' }
LoadedRandomProvider class >> with: aProbability andHyperJumpValues: someValues unit: aUnit [
    ^ self new
        initializeWithProbabilities: { aProbability }
        andMoonWalkDistances: #()
        andHyperJumpValuesLists: { someValues }
        andHyperJumpUnit: aUnit.
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> with: aProbability andMoonWalkDistance: aDistance [ 
	 ^ self new
        initializeWithProbabilities: { aProbability }
        andMoonWalkDistances: { aDistance }
        andHyperJumpValuesLists: #()
		  andHyperJumpUnit: Parsec.
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: aProbabilityList [
    ^ (self new) initializeWithProbabilities:  aProbabilityList  andMoonWalkDistances: #() andHyperJumpValuesLists: #() andHyperJumpUnit: Parsec.
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: someProbabilities andHyperJumpValuesLists: someHyperJumpValuesLists [
	^ self new
        initializeWithProbabilities: someProbabilities
        andMoonWalkDistances: #()
        andHyperJumpValuesLists: someHyperJumpValuesLists
		andHyperJumpUnit: Parsec.
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: someProbabilities andMoonWalkDistances: someDistances [
 ^ self new
        initializeWithProbabilities: someProbabilities
        andMoonWalkDistances: someDistances
        andHyperJumpValuesLists: #()
		andHyperJumpUnit: Parsec.
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: someProbabilities andMoonWalkDistances: someDistances andHyperJumpValues: someHyperJumpValuesLists [
	^ self new
        initializeWithProbabilities: someProbabilities
        andMoonWalkDistances: someDistances
        andHyperJumpValuesLists: someHyperJumpValuesLists
			andHyperJumpUnit: Parsec.
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
