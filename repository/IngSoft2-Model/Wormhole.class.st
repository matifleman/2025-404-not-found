"
Wormhole
"
Class {
	#name : 'Wormhole',
	#superclass : 'TileEffect',
	#instVars : [
		'offset',
		'destination'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Wormhole class >> inPosition: aPosition withOffset: anOffset [ 
	aPosition negative ifTrue: [
		Error signal: 'Tile should be a positive position' ].
		
	^ self new initializeIn: aPosition withOffset: anOffset
	

]

{ #category : 'effects' }
Wormhole >> applyEffectTo: aSpaceship in: aGame [
	aSpaceship moveToTile: destination .
]

{ #category : 'effects' }
Wormhole >> pairWith: aPosition [
	destination := aPosition.
]

{ #category : 'asserting' }
Wormhole >> shouldSaveAsLastEffect [
	^true 
]
