"
Hypergravity
"
Class {
	#name : 'HyperGravity',
	#superclass : 'TileEffect',
	#instVars : [
		'exitRoll'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
HyperGravity class >> needing: aNumber [
	^self new initializeNeeding: aNumber
	
]

{ #category : 'effects' }
HyperGravity >> applyEffectTo: aSpaceship in: aGame [
	aGame saveLastEffect: [:aShip | aShip lockUntil:exitRoll ].
	aSpaceship lockUntil: exitRoll.
	
]

{ #category : 'initialization' }
HyperGravity >> initializeNeeding: aNumber [
	exitRoll := aNumber
]

{ #category : 'asserting' }
HyperGravity >> shouldSaveAsLastEffect [
	^true 
]
