"
Reverse Polarity
"
Class {
	#name : 'ReversePolarity',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'play' }
ReversePolarity >> isPermanent [
	^true

]

{ #category : 'play' }
ReversePolarity >> playOn: aTile from: aCardOwner in: aGame [
	aGame addPermanentCard: self against: aTile.
	aTile reverseTarget

]
