"
ready state
"
Class {
	#name : 'ReadyState',
	#superclass : 'SpaceshipState',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
ReadyState >> playTurn: aRoll in: aGame [
	spaceship move: aRoll.
	spaceship beAffectedIn: aGame
	"self checkTurbines.
   toMove < exitRoll ifTrue: [ 
		self loseTurbine.
		^ self 
	].
   exitRoll := 0.
   self move: toMove + rollAddOn.
   board applyTileEffectTo: self in: aGame"
]
