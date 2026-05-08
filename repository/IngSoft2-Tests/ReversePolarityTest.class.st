Class {
	#name : 'ReversePolarityTest',
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
		'aGame',
		'aSpaceship3'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
ReversePolarityTest >> setUp [
	super setUp.

	"Put here a common initialization logic for tests"
	aBoard := Board with: 20.
	aSpaceship1 := Spaceship withName: 'Nave 1' withBoard: aBoard withMaxFuel: 30.
	aSpaceship2 := Spaceship withName: 'Nave 2' withBoard: aBoard withMaxFuel: 30.
	aSpaceship3 := Spaceship withName: 'Nave 3' withBoard: aBoard withMaxFuel: 30.
	spaceships := { aSpaceship1 . aSpaceship2 . aSpaceship3 }.
	"Exacto una vuelta         1   2   1   2   1   2 "
	aDie1 := LoadedDie with: { 3 . 3 . 3 . 3 . 4 . 4}.
	aDie2 := LoadedDie with: { 3 . 3 . 3 . 3 . 5 . 5}.
	dice := { aDie1 . aDie2 }.
	lap := 1.
	aGame := Game with: spaceships andDice: dice laps: lap in:aBoard .
]

{ #category : 'tests' }
ReversePolarityTest >> test01SelfTargetResolvesOnlyTriggeringShip [
	| target result |
	target := SelfTarget new.
   result := target resolveFrom: aSpaceship1 in: aGame.
   self assert: result size equals: 1.
   self assert: (result includes: aSpaceship1 ).
   self deny: (result includes: aSpaceship2 ).
]

{ #category : 'tests' }
ReversePolarityTest >> test02OthersTargetResolvesAllShipsExceptTriggeringShip [
	| target result |
	target := OthersTarget new.
   result := target resolveFrom: aSpaceship1 in: aGame.
   self assert: result size equals: 2.
   self assert: (result includes: aSpaceship2 ).
	self assert: (result includes: aSpaceship3 ).
   self deny: (result includes: aSpaceship1 ).
]

{ #category : 'tests' }
ReversePolarityTest >> test03SelfTargetReversedBecomesOtherTarget [
	| target result |
	target := SelfTarget new.
	target reverse.
   result := target resolveFrom: aSpaceship1 in: aGame.
   self assert: result size equals: 1.
   self assert: (result includes: aSpaceship1 ).
   self deny: (result includes: aSpaceship2 ).
]

{ #category : 'tests' }
ReversePolarityTest >> test04OtherTargetReversedBecomesSelfTarget [
	| target result reversed |
	target := OthersTarget new.
	reversed := target reverse.
   result := reversed resolveFrom: aSpaceship1 in: aGame.
   self assert: result size equals: 1.
   self assert: (result includes: aSpaceship1 ).
   self deny: (result includes: aSpaceship2 ).
	self deny: (result includes: aSpaceship3 ).

]

{ #category : 'tests' }
ReversePolarityTest >> test05AllTargetResolvesAllShips [
	| target result |
	target := AllTarget new.
   result := target resolveFrom: aSpaceship1 in: aGame.
	self assert: result size equals: 3.
   self assert: (result includes: aSpaceship1 ).
	self assert: (result includes: aSpaceship1 ).
	self assert: (result includes: aSpaceship1 ).
]

{ #category : 'tests' }
ReversePolarityTest >> test05NoOneTargetResolvesNoShips [
	| target result |
	target := NoOneTarget new.
   result := target resolveFrom: aSpaceship1 in: aGame.
	self assert: result isEmpty .
]
