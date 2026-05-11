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

{ #category : 'tests' }
ReversePolarityTest >> test16RPAppliedTwiceRestoresBlackHole [
	| aBlackHole reverseCard2 |
	
	reverseCard2 := ReversePolarity new.
	aCardDeck addCard: reverseCard2 .
	aBlackHole := BoardTile inPosition: 8 effect: (BlackHole new) target: SelfTarget new." blackhole en el 8"
	aBoard addTile: aBlackHole .
	
	aSpaceship1 turn: 6 in: aGame.  "levanta la carta"
	aSpaceship1 turn: 1 playCard: reverseCard2 against: aBlackHole in: aGame. "la juega en el blackhole"
	aSpaceship2 turn: 8 in: aGame. "cae en el blackhole, manda a todos para atras"
	
	aSpaceship3 turn: 11 in: aGame. "levanta carta"
	aSpaceship3 turn: 1 playCard: reverseCard against: aBlackHole in: aGame. "da vuela efecto"
	aSpaceship1 turn: 2 in: aGame. "afecta solo a 1"
	 
	self assert: aSpaceship1 position equals: (Position in: 5 at: 0).
	self assert: aSpaceship2 position equals: (Position in: 8 at: 0).
	self assert: aSpaceship3 position equals: (Position in: 7 at: 0).
	
	
]

{ #category : 'tests' }
ReversePolarityTest >> test17RPAppliedTwiceRestoresMoonwalk [
	| aMoonWalk reverseCard2 |
	
	reverseCard2 := ReversePolarity new.
	aCardDeck addCard: reverseCard2 .
	aMoonWalk := BoardTile inPosition: 8 effect: (MoonWalk steps: 4) target: OthersTarget new.
	aBoard addTile: aMoonWalk .
	
	aSpaceship1 turn: 6 in: aGame.  
	aSpaceship1 turn: 1 playCard: reverseCard2 against: aMoonWalk in: aGame. 
	aSpaceship2 turn: 8 in: aGame. 
	
	aSpaceship2 turn: 2 in: aGame. 
	aSpaceship2 turn: 1 playCard: reverseCard against: aMoonWalk in: aGame. 
	aSpaceship1 turn: 1 in: aGame. 
	 
	self assert: aSpaceship1 position equals: (Position in: 8 at: 0).
	self assert: aSpaceship2 position equals: (Position in: 3 at: 0).
	
	
]

{ #category : 'tests' }
ReversePolarityTest >> test18RPAppliedTwiceRestoresAtomicBomb [
	| anAtomicBomb reverseCard2 |
	
	reverseCard2 := ReversePolarity new.
	aCardDeck addCard: reverseCard2 .
	anAtomicBomb := BoardTile inPosition: 8 effect: (AtomicBomb new) target: AllTarget new.
	aBoard addTile: anAtomicBomb .
	
	aSpaceship1 turn: 6 in: aGame.  
	aSpaceship1 turn: 1 playCard: reverseCard2 against: anAtomicBomb in: aGame. 
	aSpaceship2 turn: 8 in: aGame. 
	
	aSpaceship3 turn: 6 in: aGame. 
	aSpaceship3 turn: 1 playCard: reverseCard against: anAtomicBomb in: aGame. 
	aSpaceship1 turn: 1 in: aGame. 
	 
	self assert: aSpaceship1 position equals: (Position in: 0 at: 0).
	self assert: aSpaceship2 position equals: (Position in: 0 at: 0).
	self assert: aSpaceship3 position equals: (Position in: 0 at: 0).
	
	
]

{ #category : 'tests' }
ReversePolarityTest >> test19RPAppliedTwiceRestoresHyperJump [
	| aHyperJump reverseCard2 hyperJumpEffect |
	hyperJumpEffect := HyperJump 
       withParsecs: { Parsec with: 10. Parsec with: 12. Parsec with: 8. 
                      Parsec with: 5. Parsec with: 3. Parsec with: 2 }
       convertor: 2
       boardSize: aBoard size.
	reverseCard2 := ReversePolarity new.
	aCardDeck addCard: reverseCard2 .
	aHyperJump := BoardTile inPosition: 8 effect: hyperJumpEffect target: SelfTarget new.
	aBoard addTile: aHyperJump .
	
	aSpaceship1 turn: 6 in: aGame.  
	aSpaceship1 turn: 1 playCard: reverseCard2 against: aHyperJump in: aGame. 
	aSpaceship2 turn: 8 in: aGame. 
	
	aSpaceship3 turn: 1 in: aGame. 
	aSpaceship3 turn: 1 playCard: reverseCard against: aHyperJump in: aGame. 
	aSpaceship3 turn: 1 in: aGame. 
	 
	self assert: aSpaceship1 position equals: (Position in: 13 at: 0).
	self assert: aSpaceship2 position equals: (Position in: 8 at: 0).
	self assert: aSpaceship3 position equals: (Position in: 12 at: 0).
	
	
]

{ #category : 'tests' }
ReversePolarityTest >> test20RPAppliedTwiceRestoresHyperGravity [
	|  reverseCard2 aHyperGravity |
	
	reverseCard2 := ReversePolarity new.
	aCardDeck addCard: reverseCard2 .
	aHyperGravity := BoardTile inPosition: 8 effect: (HyperGravity needing: 2) target: SelfTarget new.
	aBoard addTile: aHyperGravity .
	
	aSpaceship1 turn: 6 in: aGame.  
	aSpaceship1 turn: 1 playCard: reverseCard2 against: aHyperGravity in: aGame. 
	aSpaceship2 turn: 8 in: aGame." los demas no avanzan si sacan menos de 2" 
	aSpaceship3 turn: 1 in: aGame. "no avanza"
	 
	aSpaceship3 turn: 6 in: aGame. "sale del lock"
	aSpaceship3 turn: 1 playCard: reverseCard against: aHyperGravity in: aGame. "afecta al q cae"
	aSpaceship3 turn: 1 in: aGame. "cae"
	aSpaceship3 turn: 1 in: aGame. "no avanza"
	 
	self assert: aSpaceship1 position equals: (Position in: 7 at: 0).
	self assert: aSpaceship2 position equals: (Position in: 8 at: 0).
	self assert: aSpaceship3 position equals: (Position in: 8 at: 0).
	
	
]

{ #category : 'tests' }
ReversePolarityTest >> test21RPAppliedTwiceRestoresDrawCard [
	
	| reverseCard2 |
	aSpaceship1 turn: 6 in: aGame. 
	reverseCard2 := ReversePolarity new. 
	aCardDeck addCard: Ally new.
	aCardDeck addCard: reverseCard2.
	
	aSpaceship1 turn: 10 playCard: reverseCard against: drawCardTile in: aGame.
	aSpaceship2 turn: 6 in: aGame. "activa drawcard en los demas"
	
	aSpaceship1 turn: 2 playCard: reverseCard2 against: drawCardTile in: aGame.
	aCardDeck addCard: Acceleration new.
	aSpaceship3 turn: 6 in: aGame.
	 
	self assert: aSpaceship1 cards equals: 0.
	self assert: aSpaceship2 cards equals: 0.
	self assert: aSpaceship3 cards equals: 2.
	
	
]

{ #category : 'tests' }
ReversePolarityTest >> test22RPIsRemovedByCancellationAndRestoresTarget [
	| aBlackHole cancelCard |
	
	cancelCard := Cancellation new.
	aBlackHole := BoardTile inPosition: 8 effect: (BlackHole new) target: SelfTarget new." blackhole en el 8"
	aBoard addTile: aBlackHole .
	
	aSpaceship1 turn: 6 in: aGame.  "levanta la carta"
	aSpaceship1 turn: 1 playCard: reverseCard against: aBlackHole in: aGame. "la juega en el blackhole"
	aSpaceship2 turn: 8 in: aGame. "cae en el blackhole, manda a todos para atras"
	
	aCardDeck addCard: cancelCard .
	aSpaceship3 turn: 11 in: aGame. "levanta carta"
	aSpaceship3 useCancellationOn: reverseCard inGame: aGame . "da vuela efecto"
	aSpaceship1 turn: 5 in: aGame. "afecta solo a 1"
	 
	self assert: aSpaceship1 position equals: (Position in: 4 at: 0).
	self assert: aSpaceship2 position equals: (Position in: 8 at: 0).
	self assert: aSpaceship3 position equals: (Position in: 6 at: 0).
	
]

{ #category : 'tests' }
ReversePolarityTest >> test23RPIsRedoneOnSameTileByRedoCard [
	| aBlackHole redoCard |
	
	redoCard := Redo new.
	aBlackHole := BoardTile inPosition: 8 effect: (BlackHole new) target: SelfTarget new." blackhole en el 8"
	aBoard addTile: aBlackHole .
	
	aSpaceship1 turn: 6 in: aGame.  "levanta la carta"
	aSpaceship1 turn: 1 playCard: reverseCard against: aBlackHole in: aGame. "la juega en el blackhole"
	aSpaceship2 turn: 8 in: aGame. "cae en el blackhole, manda a todos para atras"
	
	aCardDeck addCard: redoCard .
	aSpaceship3 turn: 11 in: aGame. "levanta carta"
	aSpaceship3 turn: 1 playCard: redoCard against: aBlackHole in: aGame . "da vuela efecto"
	aSpaceship1 turn: 5 in: aGame. "afecta solo a 1"
	 
	self assert: aSpaceship1 position equals: (Position in: 4 at: 0).
	self assert: aSpaceship2 position equals: (Position in: 8 at: 0).
	self assert: aSpaceship3 position equals: (Position in: 6 at: 0).
	
]
