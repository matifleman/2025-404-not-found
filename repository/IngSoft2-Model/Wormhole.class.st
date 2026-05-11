"
Wormhole
"
Class {
	#name : 'WormHole',
	#superclass : 'TileEffect',
	#instVars : [
		'offset'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
WormHole class >> createPairWithEntrance: entrancePos andExit: exitPos [ 
	| distance entrance exit |
	
	distance := exitPos - entrancePos.
	
	entrance := self inPosition: entrancePos withOffset: distance.
	exit := self inPosition: exitPos withOffset: distance negated.
	
	^ { entrance . exit }
]

{ #category : 'as yet unclassified' }
WormHole class >> inPosition: aPosition withOffset: anOffset [ 
	aPosition negative ifTrue: [
		Error signal: 'Tile should be a positive position' ].
		
	^ self new initializeIn: aPosition withOffset: anOffset
	

]

{ #category : 'effects' }
WormHole >> applyEffectTo: aSpaceship in: aGame [
	aSpaceship move: offset .
]

{ #category : 'initialization' }
WormHole >> initializeIn: aPosition withOffset: anOffset [
	self initializeIn: aPosition. 
	offset := anOffset
	
	
]

{ #category : 'asserting' }
WormHole >> shouldSaveAsLastEffect [
	^true 
]
