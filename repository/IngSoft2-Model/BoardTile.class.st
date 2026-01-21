Class {
	#name : 'BoardTile',
	#superclass : 'Object',
	#instVars : [
		'position'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
BoardTile class >> inPosition: aPosition [ 
	aPosition negative ifTrue: [
		Error signal: 'Tile should be a positive position' ].
	^self new initializeIn: aPosition 
]

{ #category : 'accessing' }
BoardTile >> initializeIn: aPosition [
	position:=aPosition.

]

{ #category : 'accessing' }
BoardTile >> position [
	^position 
]
