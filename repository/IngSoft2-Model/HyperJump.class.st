"
HyperJump
"
Class {
	#name : 'HyperJump',
	#superclass : 'TileEffect',
	#instVars : [
		'parsecs',
		'listOfValues',
		'originalList',
		'convertor'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
HyperJump class >> withParsecs: aListOfParsec convertor: aConvertor boardSize: sizeOfBoard [ 
   ^ self new initializeWithParsecs: aListOfParsec convertor: aConvertor boardSize: sizeOfBoard
	
]

{ #category : 'effects' }
HyperJump >> applyEffectTo: aSpaceship in: aGame [
	| parsecsValue tilesToAdvance |
   listOfValues isEmpty ifTrue: [ listOfValues := originalList copy ].
   parsecsValue := listOfValues first.
   listOfValues := listOfValues copyFrom: 2 to: listOfValues size.
   tilesToAdvance := parsecsValue // convertor.
   aSpaceship move: tilesToAdvance
]

{ #category : 'effects' }
HyperJump >> convert: aConvertor with: sizeOfBoard and: aListOfValues [
	| results |
	convertor := aConvertor.
	parsecs := convertor * (sizeOfBoard parsec).
	results := aListOfValues collect: [ :each | each parsec ].
	originalList := results asSortedCollection.
	listOfValues := originalList asSortedCollection.
]

{ #category : 'initialization' }
HyperJump >> initializeWithParsecs: aListOfParsec convertor: aConvertor boardSize: sizeOfBoard [
	| results |
   convertor := aConvertor.
   results := aListOfParsec collect: [ :each | each parsec ].
   originalList := results asSortedCollection reverse.
   listOfValues := originalList copy.
	
]

{ #category : 'asserting' }
HyperJump >> shouldSaveAsLastEffect [
	^true 
]
