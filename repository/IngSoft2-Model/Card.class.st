"
Card class
"
Class {
	#name : 'Card',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'play' }
Card >> isPermanent [
	^false
]

{ #category : 'play' }
Card >> playOn: aSpaceship from: aCardOwner in: aGame [
	self subclassResponsibility 

]

{ #category : 'play' }
Card >> removeFrom: aGame [
]
