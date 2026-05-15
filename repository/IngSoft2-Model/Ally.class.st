"
Ally card
"
Class {
	#name : 'Ally',
	#superclass : 'Card',
	#instVars : [
		'ship1',
		'ship2'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'play' }
Ally >> isPermanent [
    ^ true
]

{ #category : 'play' }
Ally >> playOn: aSpaceship from: aCardOwner  in: aGame [
	ship1 := aSpaceship.
	ship2 := aCardOwner.
	aGame addPermanentCard: self against: aSpaceship.
	aCardOwner allyWith: aSpaceship.
	aSpaceship allyWith: aCardOwner

]

{ #category : 'play' }
Ally >> removeFrom: aGame [
	ship1 breakAlliance.
   ship2 breakAlliance
]
