"
Repeat card
"
Class {
	#name : 'Repeat',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'play' }
Repeat >> isPermanent [
    ^ false
]

{ #category : 'play' }
Repeat >> playOn: aSpaceship from: aCardOwner in: aGame [
	aGame lastEffect ifNotNil: [ :effect | effect value: aSpaceship ]

]
