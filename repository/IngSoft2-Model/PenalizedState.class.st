"
penalized state
"
Class {
	#name : 'PenalizedState',
	#superclass : 'SpaceshipState',
	#instVars : [
		'turnToExit'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
PenalizedState class >> with: aSpaceship turns: turns [
	^self new initializeWith: aSpaceship turns: turns
]

{ #category : 'initialization' }
PenalizedState >> initializeWith: aSpaceship turns: turns [
	spaceship := aSpaceship.
	turnToExit := turns.
]

{ #category : 'logic' }
PenalizedState >> playTurn: aRoll in: aGame [
	turnToExit := turnToExit - 1.
	turnToExit == 0 ifFalse: [ ^self ].
	spaceship refuel.
	spaceship transitionTo: (ReadyState with: spaceship)
	
]
