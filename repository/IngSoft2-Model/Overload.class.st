"
Overload card
"
Class {
	#name : 'Overload',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'play' }
Overload >> isPermanent [
	^true
]

{ #category : 'play' }
Overload >> playOn: aSpaceship from: aCardOwner in: aGame [
	aGame addPermanentCard: self against: aSpaceship.
   aSpaceship modifyRoll: -2

]

{ #category : 'play' }
Overload >> removeFrom: aGame [
	aGame modifyRollAll: 2
]
