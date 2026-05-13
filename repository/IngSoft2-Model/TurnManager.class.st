"
turn manager
"
Class {
	#name : 'TurnManager',
	#superclass : 'Object',
	#instVars : [
		'spaceships',
		'turnNumber'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
TurnManager class >> with: someSpaceships [
	^self new initializeWith: someSpaceships 
]

{ #category : 'logic' }
TurnManager >> advance [
	turnNumber := (turnNumber \\ spaceships size) + 1
]

{ #category : 'logic' }
TurnManager >> currentShip [
	^spaceships at: turnNumber 
]

{ #category : 'initialization' }
TurnManager >> initializeWith: someSpaceships [
	spaceships := someSpaceships.
	turnNumber := 1.
]
