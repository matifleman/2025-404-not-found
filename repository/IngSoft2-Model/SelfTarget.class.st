"
SelfTarget
"
Class {
	#name : 'SelfTarget',
	#superclass : 'TileTarget',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'public' }
SelfTarget >> resolveFrom: aSpaceship in: aGame [
	^ OrderedCollection with: aSpaceship 
]

{ #category : 'highlighting' }
SelfTarget >> reverse [
	^ OthersTarget new
]
