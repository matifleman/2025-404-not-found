"
Redo card
"
Class {
	#name : 'Redo',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'play' }
Redo >> isPermanent [
    ^ false
]

{ #category : 'play' }
Redo >> playOn: aSpaceship from: aCardOwner in: aGame [
	| lastCard |
	lastCard := aGame readLastCard.
   lastCard playOn: aSpaceship from: aCardOwner in: aGame 

]
