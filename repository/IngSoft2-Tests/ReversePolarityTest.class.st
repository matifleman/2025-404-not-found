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
		'aSpaceship3',
		'aCardDeck',
		'drawCardTile',
		'reverseCard'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
ReversePolarityTest >> setUp [
	super setUp.

	"Put here a common initialization logic for tests"
	aBoard := Board with: 20.
	aSpaceship1 := Spaceship withName: 'Nave 1' withBoard: aBoard withMaxFuel: 30 withCards: OrderedCollection new.
	aSpaceship2 := Spaceship withName: 'Nave 2' withBoard: aBoard withMaxFuel: 30 withCards: OrderedCollection new.
	aSpaceship3 := Spaceship withName: 'Nave 3' withBoard: aBoard withMaxFuel: 30 withCards: OrderedCollection new.
	spaceships := { aSpaceship1 . aSpaceship2 . aSpaceship3 }.
	"Exacto una vuelta         1   2   3   1   2   3 "
	aDie1 := LoadedDie with: { 3 . 3 . 3 . 3 . 4 . 4}.
	aDie2 := LoadedDie with: { 3 . 3 . 3 . 3 . 5 . 5}.
	dice := { aDie1 . aDie2 }.
	lap := 1.
	aGame := Game with: spaceships andDice: dice laps: lap in:aBoard .
	
	aCardDeck:=CardDeck new.
	reverseCard := ReversePolarity new.
	aCardDeck addCard: reverseCard.
	drawCardTile:= BoardTile inPosition: 6 effect: (DrawCard withDeck: aCardDeck) target: SelfTarget new.
	aBoard addTile: drawCardTile .

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
ReversePolarityTest >> test06NoOneTargetResolvesNoShips [
	| target result |
	target := NoOneTarget new.
   result := target resolveFrom: aSpaceship1 in: aGame.
	self assert: result isEmpty .
]

{ #category : 'tests' }
ReversePolarityTest >> test07AllTargetReversedResolvesNoShips [
	| target result reversed |
	target := AllTarget new.
	reversed := target reverse.
   result := reversed resolveFrom: aSpaceship1 in: aGame.
	self assert: result isEmpty .
]

{ #category : 'tests' }
ReversePolarityTest >> test08NoOneTargetReversedResolvesAllShips [
	| target result reversed |
	target := NoOneTarget new.
	reversed := target reverse.
   result := reversed resolveFrom: aSpaceship1 in: aGame.
	self assert: result size equals: 3.
   self assert: (result includes: aSpaceship1 ).
	self assert: (result includes: aSpaceship1 ).
	self assert: (result includes: aSpaceship1 ).
]

{ #category : 'tests' }
ReversePolarityTest >> test09ReversedTwiceRestoresOriginalTarget [
	| target result reversedTwice |
	target := SelfTarget new.
	reversedTwice := target reverse reverse.
   result := reversedTwice resolveFrom: aSpaceship1 in: aGame.
	self assert: result size equals: 1.
   self assert: (result includes: aSpaceship1 ).
   self deny: (result includes: aSpaceship2 ).
	
]

{ #category : 'tests' }
ReversePolarityTest >> test10ReversePolarityInvertsBlackHoleToAffectOtherShips [
	| aBlackHole |

	aBlackHole := BoardTile inPosition: 8 effect: (BlackHole new) target: SelfTarget new." blackhole en el 8"
	aBoard addTile: aBlackHole .
	
	aSpaceship1 turn: 6 in: aGame.  "levanta la carta"
	aSpaceship1 turn: 10 playCard: reverseCard against: aBlackHole in: aGame. "la juega en el blackhole"
	aSpaceship2 turn: 8 in: aGame. "cae en el blackhole, manda a todos para atras"
	
	self assert: aSpaceship1 position equals: (Position in: 12 at: 0).
	self assert: aSpaceship2 position equals: (Position in: 8 at: 0)
	
	
]

{ #category : 'tests' }
ReversePolarityTest >> test11ReversePolarityInvertsMoonwalkAndAffectsSelf [
	| aMoonWalk |
	
	aMoonWalk := BoardTile inPosition: 8 effect: (MoonWalk steps: 4) target: OthersTarget new.
	aBoard addTile: aMoonWalk .
	
	aSpaceship1 turn: 6 in: aGame.  
	aSpaceship1 turn: 10 playCard: reverseCard against: aMoonWalk in: aGame. 
	aSpaceship2 turn: 8 in: aGame. 
	
	self assert: aSpaceship1 position equals: (Position in: 16 at: 0).
	self assert: aSpaceship2 position equals: (Position in: 4 at: 0)
	
	
]

{ #category : 'tests' }
ReversePolarityTest >> test12ReversePolarityInvertsAtomicBombAndAffectsNoOne [
	| anAtomicBomb |
	
	anAtomicBomb := BoardTile inPosition: 8 effect: (AtomicBomb new) target: AllTarget new.
	aBoard addTile: anAtomicBomb .
	
	aSpaceship1 turn: 6 in: aGame.  
	aSpaceship1 turn: 10 playCard: reverseCard against: anAtomicBomb in: aGame.
	aSpaceship2 turn: 8 in: aGame. 
	
	self assert: aSpaceship1 position equals: (Position in: 16 at: 0).
	self assert: aSpaceship2 position equals: (Position in: 8 at: 0)
	
	
]

{ #category : 'tests' }
ReversePolarityTest >> test13ReversePolarityInvertsHyperJumpAndAffectsOthers [
	| hyperJumpTile hyperJumpEffect |
	
	hyperJumpEffect := HyperJump 
       withParsecs: { Parsec with: 10. Parsec with: 12. Parsec with: 8. 
                      Parsec with: 5. Parsec with: 3. Parsec with: 2 }
       convertor: 2
       boardSize: aBoard size.
   hyperJumpTile := BoardTile inPosition: 8 effect: hyperJumpEffect target: SelfTarget new.
	aBoard addTile: hyperJumpTile .
	
	aSpaceship1 turn: 6 in: aGame.  
	aSpaceship1 turn: 10 playCard: reverseCard against: hyperJumpTile in: aGame.
	aSpaceship2 turn: 8 in: aGame. 
	
	self assert: aSpaceship1 position equals: (Position in: 1 at: 1).
	self assert: aSpaceship2 position equals: (Position in: 8 at: 0).
	self assert: aSpaceship3 position equals: (Position in: 5 at: 0).
	
	
]

{ #category : 'tests' }
ReversePolarityTest >> test14ReversePolarityInvertsHyperGravityAndAffectsOthers [
	| hyperGravity |
	
	hyperGravity := BoardTile inPosition: 8 effect: (HyperGravity needing: 7) target: SelfTarget new.
	aBoard addTile: hyperGravity .
	
	aSpaceship1 turn: 6 in: aGame.  
	aSpaceship1 turn: 10 playCard: reverseCard against: hyperGravity in: aGame.
	aSpaceship2 turn: 8 in: aGame. "activa hypergravity en los demas"
	
	aSpaceship1 turn: 6 in: aGame. "no sale queda en 16"
	aSpaceship2 turn: 6 in: aGame. "puede jugar"
	aSpaceship3 turn: 6 in: aGame. "no sale queda en 0"
	
	self assert: aSpaceship1 position equals: (Position in: 16 at: 0).
	self assert: aSpaceship2 position equals: (Position in: 14 at: 0).
	self assert: aSpaceship3 position equals: (Position in: 0 at: 0).
	
	
]

{ #category : 'tests' }
ReversePolarityTest >> test15ReversePolarityInvertsDrawCardAndOtherDraw [
	"Ya tengo drawCard en el 6"
	aSpaceship1 turn: 6 in: aGame.  
	aCardDeck addCard: Acceleration new.
	aCardDeck addCard: Ally new.
	aSpaceship1 turn: 10 playCard: reverseCard against: drawCardTile in: aGame.
	aSpaceship2 turn: 6 in: aGame. "activa drawcard en los demas"
	
	self assert: aSpaceship1 cards equals: 1.
	self assert: aSpaceship2 cards equals: 0.
	self assert: aSpaceship3 cards equals: 1.
	
	
]
