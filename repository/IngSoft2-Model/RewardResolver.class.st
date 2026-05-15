"
reward resolver
"
Class {
	#name : 'RewardResolver',
	#superclass : 'Object',
	#instVars : [
		'percetage'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
RewardResolver class >> withPercentage: aPercentage [
	^self new initializeWithPercentage: aPercentage 
]

{ #category : 'initialization' }
RewardResolver >> initializeWithPercentage: aPercentage [
	percetage := aPercentage
]

{ #category : 'logic' }
RewardResolver >> resolveFor: aSpaceship [
	| randomNumber reward |
	randomNumber := (Random new next * 100) rounded.
	reward := randomNumber <= percetage 
		ifTrue: [ MaxFuel new ] ifFalse: [ FuelPenalty new ].
	reward applyTo: aSpaceship 
]
