Class {
	#name : 'LoadedRandomProvider',
	#superclass : 'Object',
	#instVars : [
		'probability',
		'moonWalkDistance',
		'probabilities',
		'probabilityIndex',
		'moonWalkDistances',
		'moonWalkDistanceIndex',
		'hyperJumpValues',
		'hyperJumpValuesLists',
		'hyperJumpValuesIndex'
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
    ^ (self new) initializeWithProbabilities: { aProbability } andMoonWalkDistances: #() andHyperJumpValuesLists: #().
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> with: aProbability andHyperJumpValues: someValues [
	^ self new
        initializeWithProbabilities: { aProbability }
        andMoonWalkDistances: #()
        andHyperJumpValuesLists: { someValues }
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> with: aProbability andMoonWalkDistance: aDistance [ 
	 ^ self new
        initializeWithProbabilities: { aProbability }
        andMoonWalkDistances: { aDistance }
        andHyperJumpValuesLists: #()
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: aProbabilityList [
    ^ (self new) initializeWithProbabilities:  aProbabilityList  andMoonWalkDistances: #() andHyperJumpValuesLists: #().
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: someProbabilities andHyperJumpValuesLists: someHyperJumpValuesLists [
	^ self new
        initializeWithProbabilities: someProbabilities
        andMoonWalkDistances: #()
        andHyperJumpValuesLists: someHyperJumpValuesLists
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: someProbabilities andMoonWalkDistances: someDistances [
 ^ self new
        initializeWithProbabilities: someProbabilities
        andMoonWalkDistances: someDistances
        andHyperJumpValuesLists: #()
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: someProbabilities andMoonWalkDistances: someDistances andHyperJumpValues: someValues [
	^ self new
        initializeWithProbabilities: someProbabilities
        andMoonWalkDistances: someDistances
        andHyperJumpValuesLists: someValues
]

{ #category : 'initialization' }
LoadedRandomProvider >> initializeWithProbabilities: someProbabilities andMoonWalkDistances: someDistances andHyperJumpValuesLists: someValues [
	
	probabilities := someProbabilities.
	probabilityIndex := 1.
	moonWalkDistances := someDistances.
	moonWalkDistanceIndex := 1.
	hyperJumpValuesLists :=  someValues .
	hyperJumpValuesIndex := 1.
	
	
	
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
