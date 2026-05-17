"
locked state
"
Class {
	#name : 'LockedState',
	#superclass : 'SpaceshipState',
	#instVars : [
		'exitRoll'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
LockedState class >> with: aSpaceship exitRoll: aRoll [
	^self new initializeWith: aSpaceship exitRoll: aRoll 
]

{ #category : 'initialization' }
LockedState >> initializeWith: aSpaceship exitRoll: aRoll [
	spaceship := aSpaceship .
	exitRoll := aRoll.
]

{ #category : 'logic' }
LockedState >> playTurn: aRoll in: aGame [
	aRoll < exitRoll ifTrue: [ 
		spaceship loseTurbine.
		^self
	].
	spaceship transitionTo: (ReadyState with: spaceship)
]
