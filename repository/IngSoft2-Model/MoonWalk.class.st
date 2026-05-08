"
MoonWalk
"
Class {
	#name : 'MoonWalk',
	#superclass : 'BoardTile',
	#instVars : [
		'nTiles'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
MoonWalk class >> inPosition: aPosition backingUp: aNumber [
	^self new initializeIn: aPosition backingUp:aNumber 
]

{ #category : 'effects' }
MoonWalk >> applyEffectsTo: aSpaceship in: aGame [
	aGame saveLastEffect: [:aShip | aShip move:nTiles ].
	aGame activateMoonWalk: nTiles from: aSpaceship.

]

{ #category : 'initialization' }
MoonWalk >> initializeIn: aPosition backingUp: aNumber [
	self initializeIn: aPosition .
	nTiles:= aNumber negated .
]
