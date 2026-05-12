"
Black hole
"
Class {
	#name : 'BlackHole',
	#superclass : 'TileEffect',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effects' }
BlackHole >> applyEffectTo: aSpaceship in: aGame [
	aSpaceship move: -4.
	aSpaceship loseTurbine.
]

{ #category : 'asserting' }
BlackHole >> shouldSaveAsLastEffect [
	^true 
]
