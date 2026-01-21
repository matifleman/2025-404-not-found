Class {
	#name : 'WormHole',
	#superclass : 'BoardTile',
	#instVars : [
		'offset'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
WormHole class >> inPosition: aPosition withOffset:anOffset [
	^ self new initializeIn: aPosition withOffset: anOffset 

]

{ #category : 'effects' }
WormHole >> applyEffectsTo: aSpaceship in: aGame [
	aSpaceship move: offset .


	"effects ifNotNil: [effects do: [ :effect | effect applyTo: aSpaceship ] ]."
]

{ #category : 'initialization' }
WormHole >> initializeIn: aPosition withOffset:anOffset [
	self initializeIn: aPosition. 
	offset :=anOffset
	
	
]
