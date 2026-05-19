"
Please describe the package using the class comment of the included manifest class. The manifest class also includes other additional metadata for the package. These meta data are used by other tools such as the SmalllintManifestChecker and the critics Browser
"
Class {
	#name : 'ManifestIngSoft2Model',
	#superclass : 'PackageManifest',
	#category : 'IngSoft2-Model-Manifest',
	#package : 'IngSoft2-Model',
	#tag : 'Manifest'
}

{ #category : 'code-critics' }
ManifestIngSoft2Model class >> ruleToDoCollectRuleV1FalsePositive [

	<ignoreForCoverage>
	^ #(#(#(#RGMethodDefinition #(#'Board class' #effectsOfSize:using: #true)) #'2026-05-19T02:10:38.336-03:00') )
]
