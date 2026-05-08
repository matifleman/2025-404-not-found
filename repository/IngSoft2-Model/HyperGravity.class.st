"
Hypergravity
"
Class {
	#name : 'HyperGravity',
	#superclass : 'BoardTile',
	#instVars : [
		'exitRoll'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperGravity class >> inPosition: aPosition needingToRoll:aNumber [
	^self new initializeIn: aPosition needing:aNumber.
	
]

{ #category : 'effects' }
HyperGravity >> applyEffectsTo: aSpaceship in: aGame [
	aGame saveLastEffect: [:aShip | aShip lockUntil:exitRoll ].
	aSpaceship lockUntil: exitRoll.
	
]

{ #category : 'initialization' }
HyperGravity >> initializeIn: aPosition needing:aNumber [
	self initializeIn: aPosition.
	exitRoll :=aNumber
]
