"
Board tile
"
Class {
	#name : 'TileEffect',
	#superclass : 'Object',
	#classInstVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effects' }
TileEffect >> applyEffectTo: aSpaceship in: aGame [
	self subclassResponsibility 
]

{ #category : 'asserting' }
TileEffect >> shouldSaveAsLastEffect [
	self subclassResponsibility 
]
