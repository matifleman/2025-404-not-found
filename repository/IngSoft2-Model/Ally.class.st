Class {
	#name : 'Ally',
	#superclass : 'CardAction',
	#instVars : [
		'ally1',
		'ally2'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
Ally >> actOn: aSpaceship from: aCardSpaceship during: aGame [
	ally1 := aSpaceship.
	ally2 := aCardSpaceship.
	aGame addCard: self against:aSpaceship .
	aCardSpaceship allyWith: aSpaceship.
	aSpaceship allyWith: aCardSpaceship .

]

{ #category : 'as yet unclassified' }
Ally >> actOn: aSpaceship from: aCardSpaceship in: aGame [
	Error signal:'Permanent Card can only be played turing turn'

]

{ #category : 'as yet unclassified' }
Ally >> nameOfCard [ 
^'ally'
]

{ #category : 'removing' }
Ally >> removeAction: aGame [
	ally1 breakAlliance.
	ally2 breakAlliance.
	
]

{ #category : 'removing' }
Ally >> removeAction:allies in:aGame [
	allies first breakAlliance.
	allies second breakAlliance.
	
]
