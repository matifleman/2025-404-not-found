"
OthersTarget
"
Class {
	#name : 'OthersTarget',
	#superclass : 'TileTarget',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'public' }
OthersTarget >> resolveFrom: aSpaceship in: aGame [
	^ aGame spaceships reject: [ :s | s = aSpaceship ]
]

{ #category : 'highlighting' }
OthersTarget >> reverse [
	^ SelfTarget new
]
