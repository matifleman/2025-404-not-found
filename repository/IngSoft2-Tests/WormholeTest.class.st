Class {
	#name : 'WormholeTest',
	#superclass : 'TestCase',
	#instVars : [
		'aBoard',
		'aSpaceship1',
		'aSpaceship2',
		'spaceships',
		'aDie1',
		'aDie2',
		'dice',
		'lap',
		'aGame'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
WormholeTest >> setUp [
	super setUp.

	"Put here a common initialization logic for tests"
	aBoard := Board with: 20. 	
	aSpaceship1 := Spaceship withName: 'Nave 1' withBoard: aBoard withMaxFuel: 30. 	
	aSpaceship2 := Spaceship withName: 'Nave 2' withBoard: aBoard withMaxFuel: 30. 	
	spaceships := { aSpaceship1 . aSpaceship2}. 	
	"1 vuelta = 6 nextTurn     1   2   1   2   1   2 " 	
	aDie1 := LoadedDie with: { 3 . 4 . 3 . 1}. 
	aDie2 := LoadedDie with: { 3 . 3 . 3 . 2}. 	
	dice := { aDie1 . aDie2 }. 	lap := 2. 	
	aGame := Game with: spaceships andDice: dice laps: lap in:aBoard . 	
]

{ #category : 'running' }
WormholeTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
WormholeTest >> testWhenSpaceshipLandsOnEntranceHoleThenGoesThroughExitHole [
	| wormholes |
	wormholes := WormHole createPairWithEntrance: 2 andExit: 6.
	aBoard addTile: wormholes first.
	aBoard addTile: wormholes second.
	
	aSpaceship1 turn: 2 in: aGame.
	
	self assert: aSpaceship1 position equals: (Position in: 6 at: 0).
]

{ #category : 'tests' }
WormholeTest >> testWhenSpaceshipLandsOnExitHoleThenGoesThroughEntranceHole [ 
	| wormholes |
	wormholes := WormHole createPairWithEntrance: 2 andExit: 6.
	aBoard addTile: wormholes first.
	aBoard addTile: wormholes second.
	
	aSpaceship1 turn: 6 in: aGame.
	
	self assert: aSpaceship1 position equals: (Position in: 2 at: 0).
]

{ #category : 'tests' }
WormholeTest >> testWhenWormholeEntranceBoxOutsideBoardThenCreationFails [
	| wormholes |
	self
		should: [ WormHole createPairWithEntrance: -1 andExit: 6]
		raise: Error
		withMessageText: 'Tile should be a positive position'.
	wormholes := WormHole createPairWithEntrance: 22 andExit: 6.
	self
		should: [ aBoard addTile: (wormholes first). ]
		raise: Error
		withMessageText: 'Tile should be inside board'.
]

{ #category : 'tests' }
WormholeTest >> testWhenWormholeExitBoxOutsideBoardThenCreationFails [
	| wormholes |
	self
		should: [  WormHole createPairWithEntrance: 2 andExit: -6. ]
		raise: Error
		withMessageText: 'Tile should be a positive position'.
		
	wormholes := WormHole createPairWithEntrance: 2 andExit: 22.
	self
		should: [ aBoard addTile: (wormholes second). ]
		raise: Error
		withMessageText: 'Tile should be inside board'.
]
