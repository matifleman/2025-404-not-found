"
Acceleration card
"
Class {
	#name : 'Acceleration',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'play' }
Acceleration >> isPermanent [
    ^ true
]

{ #category : 'play' }
Acceleration >> playOn: aSpaceship from: aCardOwner in: aGame [
	aGame addPermanentCard: self against: aSpaceship.
   aGame modifyRollAll: 1 

]

{ #category : 'play' }
Acceleration >> removeFrom: aGame [
	aGame modifyRollAll: -1
]
