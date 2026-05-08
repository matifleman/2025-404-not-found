Class {
	#name : 'NoOneTarget',
	#superclass : 'TileTarget',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'public' }
NoOneTarget >> resolveFrom: aSpaceship in: aGame [
	^ OrderedCollection new
]

{ #category : 'highlighting' }
NoOneTarget >> reverse [
	^ AllTarget new
]
