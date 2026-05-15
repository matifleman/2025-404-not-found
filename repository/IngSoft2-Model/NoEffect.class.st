"
Common tile
"
Class {
	#name : 'NoEffect',
	#superclass : 'TileEffect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effects' }
NoEffect >> applyEffectTo: aSpaceship in: aGame [
	
]

{ #category : 'asserting' }
NoEffect >> shouldSaveAsLastEffect [
	^false 
]
