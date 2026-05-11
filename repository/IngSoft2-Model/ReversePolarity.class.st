"
Reverse Polarity
"
Class {
	#name : 'ReversePolarity',
	#superclass : 'Card',
	#instVars : [
		'reversedTile'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'play' }
ReversePolarity >> isPermanent [
	^true

]

{ #category : 'play' }
ReversePolarity >> playOn: aTile from: aCardOwner in: aGame [
	reversedTile := aTile.
	aGame addPermanentCard: self against: aTile.
	aTile reverseTarget

]

{ #category : 'play' }
ReversePolarity >> removeFrom: aGame [
	reversedTile reverseTarget 
]
