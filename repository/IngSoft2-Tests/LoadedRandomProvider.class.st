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
	^ self new initializeWith: aProbability
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> with: aProbability andHyperJumpValues: someValues [
	^self new initializeWith: aProbability andHyperJumpValues: someValues.
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> with: aProbability andMoonWalkDistance: aDistance [ 
	^self new initializeWith: aProbability andMoonWalkDistance: aDistance.
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: someProbabilities andHyperJumpValuesLists: someHyperJumpValuesLists [
	^ self new
		initializeWithProbabilities: someProbabilities
		andHyperJumpValuesLists: someHyperJumpValuesLists
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: someProbabilities andMoonWalkDistances: someDistances [

	^ self new initializeWithProbabilities: someProbabilities andMoonWalkDistances: someDistances
]

{ #category : 'instance creation' }
LoadedRandomProvider class >> withProbabilities: someProbabilities andMoonWalkDistances: someDistances andHyperJumpValues: someValues [
	^self new initializeWithProbabilities: someProbabilities andMoonWalkDistances: someDistances andHyperJumpValues: someValues.
]

{ #category : 'initialization' }
LoadedRandomProvider >> initializeWith: aProbability [
	probabilities := { aProbability }.
	probabilityIndex := 1.
]

{ #category : 'initialization' }
LoadedRandomProvider >> initializeWith: aProbability andHyperJumpValues: someValues [
	probabilities := { aProbability }.
	probabilityIndex := 1.
	hyperJumpValuesLists := { someValues }.
	hyperJumpValuesIndex := 1.
]

{ #category : 'initialization' }
LoadedRandomProvider >> initializeWith: aProbability andMoonWalkDistance: aDistance [ 
	probabilities := { aProbability }.
	probabilityIndex := 1.
	moonWalkDistances := { aDistance }.
	moonWalkDistanceIndex := 1.
]

{ #category : 'initialization' }
LoadedRandomProvider >> initializeWithProbabilities: someProbabilities andHyperJumpValuesLists: someHyperJumpValuesLists [ 
	probabilities :=  someProbabilities .
	probabilityIndex := 1.
	hyperJumpValuesLists := someHyperJumpValuesLists .
	hyperJumpValuesIndex := 1.
]

{ #category : 'initialization' }
LoadedRandomProvider >> initializeWithProbabilities: someProbabilities andMoonWalkDistances: someDistances [

	probabilities := someProbabilities.
	probabilityIndex := 1.
	moonWalkDistances := someDistances.
	moonWalkDistanceIndex := 1.
]

{ #category : 'initialization' }
LoadedRandomProvider >> initializeWithProbabilities: someProbabilities andMoonWalkDistances: someDistances andHyperJumpValues: someValues [
	
	probabilities := someProbabilities.
	probabilityIndex := 1.
	moonWalkDistances := someDistances.
	moonWalkDistanceIndex := 1.
	hyperJumpValuesLists := { someValues }.
	hyperJumpValuesIndex := 1.
	
	
	
]

{ #category : 'initialization' }
LoadedRandomProvider >> nextEffectProbability [
	| value |
	value := probabilities at: probabilityIndex.
	probabilityIndex := probabilityIndex + 1.
	^ value
]

{ #category : 'initialization' }
LoadedRandomProvider >> nextHyperJumpValues [
	| values |
	values := hyperJumpValuesLists at: hyperJumpValuesIndex.
	hyperJumpValuesIndex := hyperJumpValuesIndex + 1.
	^ values
]

{ #category : 'initialization' }
LoadedRandomProvider >> nextMoonWalkDistance [
	| value |
	value := moonWalkDistances at: moonWalkDistanceIndex.
	moonWalkDistanceIndex := moonWalkDistanceIndex + 1.
	^ value
]
