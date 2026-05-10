"
MoonWalk
"
Class {
	#name : 'MoonWalk',
	#superclass : 'TileEffect',
	#instVars : [
		'steps'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
MoonWalk class >> steps: aNumber [
	^self new initializeWithSteps: aNumber 
]

{ #category : 'effects' }
MoonWalk >> applyEffectTo: aSpaceship in: aGame [
	aSpaceship move: steps .

]

{ #category : 'initialization' }
MoonWalk >> initializeWithSteps: aNumber [
	steps := aNumber negated .
]

{ #category : 'asserting' }
MoonWalk >> shouldSaveAsLastEffect [
	^true 
]
