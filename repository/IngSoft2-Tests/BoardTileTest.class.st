Class {
	#name : 'BoardTileTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
BoardTileTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'running' }
BoardTileTest >> testWhenTilePositionIsNegativeThenCreationFails [
	self
		should: [BoardTile inPosition: -2 effect: NoEffect new  target: SelfTarget new]
		raise: Error
		withMessageText: 'Tile should be a positive position'.
]

{ #category : 'running' }
BoardTileTest >> testWhenTilePositionIsOutsideThenNotAddedToBoard [
	| atomicBomb aBoard| 	 	
	aBoard := Board with: 20. 
	atomicBomb := BoardTile inPosition: 22 effect: NoEffect new  target: SelfTarget new. 	 	
	self
		should: [aBoard addTile: atomicBomb .]
		raise: Error
		withMessageText: 'Tile should be inside board'.
]
