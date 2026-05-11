"
Tile that when a spaceship lands on, it has to draw a card from the deck
"
Class {
	#name : 'DrawCard',
	#superclass : 'TileEffect',
	#instVars : [
		'cardDeck'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
DrawCard class >> withDeck: aDeck [
	^self new initializeWithDeck: aDeck 
]

{ #category : 'effects' }
DrawCard >> applyEffectTo: aSpaceship in: aGame [
    aSpaceship drawCard: (cardDeck draw)
]

{ #category : 'initialization' }
DrawCard >> initializeWithDeck:aDeck [
	cardDeck := aDeck 
]

{ #category : 'asserting' }
DrawCard >> shouldSaveAsLastEffect [
	^true 
]
