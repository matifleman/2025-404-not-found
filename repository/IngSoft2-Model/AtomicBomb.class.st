"
Atomic Bomb
"
Class {
	#name : 'AtomicBomb',
	#superclass : 'TileEffect',
	#instVars : [
		'target',
		'effect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'effects' }
AtomicBomb >> applyEffectTo: aSpaceship in: aGame [
	aSpaceship resetToStartWithoutFuelLoss 
]

{ #category : 'asserting' }
AtomicBomb >> shouldSaveAsLastEffect [
	^true 
]
