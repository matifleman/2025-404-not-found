Class {
	#name : 'AllTarget',
	#superclass : 'TileTarget',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'public' }
AllTarget >> resolveFrom: aSpaceship in: aGame [
	^ aGame spaceships 
]

{ #category : 'highlighting' }
AllTarget >> reverse [
	^ NoOneTarget new
]
