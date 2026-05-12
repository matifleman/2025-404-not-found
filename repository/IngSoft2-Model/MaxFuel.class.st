"
Max fuel
"
Class {
	#name : 'MaxFuel',
	#superclass : 'Reward',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'operations' }
MaxFuel >> applyTo: aSpaceship [
	aSpaceship increaseMaxFuelBy: 1 
]
