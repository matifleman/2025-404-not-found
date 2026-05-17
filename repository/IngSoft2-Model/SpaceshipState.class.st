"
spaceship state
"
Class {
	#name : 'SpaceshipState',
	#superclass : 'Object',
	#instVars : [
		'spaceship'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
SpaceshipState class >> with: aSpaceship [
	^ self new initializeWith: aSpaceship 
	 
]

{ #category : 'initialization' }
SpaceshipState >> initializeWith: aSpaceship [
	spaceship := aSpaceship 
]

{ #category : 'as yet unclassified' }
SpaceshipState >> playTurn: aRoll in: aGame [
	self subclassResponsibility 
]
