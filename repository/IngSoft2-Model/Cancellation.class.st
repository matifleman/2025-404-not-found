"
Cancellation card
"
Class {
	#name : 'Cancellation',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'play' }
Cancellation >> isPermanent [
    ^ false
]

{ #category : 'play' }
Cancellation >> playOn: aCardToRemove from: aCardOwner in: aGame [
	aGame removeCard: aCardToRemove

]
