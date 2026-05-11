Class {
	#name : 'TurbineTest',
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
TurbineTest >> setUp [
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

{ #category : 'asserting' }
TurbineTest >> should: anErrorBlock raise: anErrorClass withMessageText: errorMessage [

	self
		should: anErrorBlock
		raise: anErrorClass
		withExceptionDo: [ :error |
		self assert: error messageText equals: errorMessage ]
]

{ #category : 'tests' }
TurbineTest >> test01SpaceshipStartsWith3Turbines [
	| aSpaceship sizeOfBoard aBoard |
	sizeOfBoard := 10.
	aBoard := Board with: sizeOfBoard .
	aSpaceship := Spaceship withName: 'Nave 1' withBoard: aBoard withMaxFuel: 10.

	self assert: aSpaceship turbines equals: 3
	
]

{ #category : 'tests' }
TurbineTest >> test02SpaceshipWithoutTurbinesCannotMove [

	aSpaceship1 turn: 2 in: aGame .
	aSpaceship1 loseTurbine.
	aSpaceship1 loseTurbine.
	aSpaceship1 loseTurbine.

	self
		should: [ aSpaceship1 turn: 2 in: aGame .]
		raise: Error
		withMessageText: 'Spaceship has no more turbines'.
	self assert: aSpaceship1 turbines equals: 0.
	self assert: aSpaceship1 position equals: (Position in: 2 at: 0)
	
]

{ #category : 'tests' }
TurbineTest >> test03SpaceshipLosesTurbineWhenRunsOutOfFuel [

	aSpaceship1 turn: 32 in: aGame .
	
	self assert: aSpaceship1 turbines equals: 2
	
]

{ #category : 'tests' }
TurbineTest >> test04SpaceshipLosesTurbineWhenBlackHoleIsApplied [
	| blackHole |
	blackHole:= BoardTile inPosition: 9 effect: BlackHole new  target: SelfTarget new.
	aBoard addTile: blackHole.
	
	aSpaceship1 turn: 9 in: aGame.
	
	self assert: aSpaceship1 turbines equals: 2.
	
]

{ #category : 'tests' }
TurbineTest >> test05SpaceshipLosesTurbineWhenFailsHyperGravityRoll [
	| hyperGravity |
	hyperGravity := BoardTile inPosition: 6 effect: (HyperGravity needing: 2) target: SelfTarget new.
	aBoard addTile: hyperGravity.
	
	aSpaceship1 turn: 6 in: aGame .
	aSpaceship1 turn: 1 in: aGame .
	
	self assert: aSpaceship1 turbines equals: 2
	
]
