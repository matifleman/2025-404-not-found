"
Board tile class
"
Class {
	#name : 'BoardTile',
	#superclass : 'Object',
	#instVars : [
		'position',
		'effect',
		'target'
	],
	#classInstVars : [
		'position',
		'effect',
		'taget'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
BoardTile class >> inPosition: aPosition effect: anEffect target: aTarget [
	aPosition negative ifTrue: [
   		Error signal: 'Tile should be a positive position' ].
   ^ self new initializeIn: aPosition effect: anEffect target: aTarget
]

{ #category : 'effects' }
BoardTile >> applyEffectsTo: aSpaceship in: aGame [
	| affectedShips |
	effect shouldSaveAsLastEffect ifTrue: [ 
		aGame saveLastEffect: [ :aShip | effect applyEffectTo: aShip in: aGame ].
	].
   affectedShips := target resolveFrom: aSpaceship in: aGame.
   affectedShips do: [ :ship | effect applyEffectTo: ship in: aGame ].
]

{ #category : 'initialization' }
BoardTile >> initializeIn: aPosition effect: anEffect target: aTarget [
	position := aPosition .
   effect := anEffect .
   target := aTarget .
]

{ #category : 'accessing' }
BoardTile >> position [
	^position 
]

{ #category : 'effects' }
BoardTile >> reverseTarget [
	target := target reverse.
]
