"
Fuel penalty
"
Class {
	#name : 'FuelPenalty',
	#superclass : 'Reward',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
FuelPenalty >> applyTo: aSpaceship [
	aSpaceship reduceFuelBy: 1 
]
