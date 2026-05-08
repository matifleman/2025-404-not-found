Class {
	#name : 'TileTarget',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'public' }
TileTarget >> resolveFrom: aSpaceship in: aGame [
	self subclassResponsibility 
]

{ #category : 'highlighting' }
TileTarget >> reverse [
	self subclassResponsibility 
]
