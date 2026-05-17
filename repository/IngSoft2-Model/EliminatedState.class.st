"
eliminated state
"
Class {
	#name : 'EliminatedState',
	#superclass : 'SpaceshipState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
EliminatedState >> playTurn: aRoll in: aGame [
	"Error signal: 'Spaceship has no more turbines'"
]
