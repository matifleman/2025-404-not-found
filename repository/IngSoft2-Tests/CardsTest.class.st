Class {
	#name : 'CardsTest',
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
		'drawCardTile',
		'aSpaceship3'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
CardsTest >> setUp [
	super setUp.

	"Put here a common initialization logic for tests"
	aBoard := Board with: 30. 	
	aSpaceship1 := Spaceship withName: 'Nave 1' withBoard: aBoard withMaxFuel: 10 withCards: OrderedCollection new. 	
	aSpaceship2 := Spaceship withName: 'Nave 2' withBoard: aBoard withMaxFuel: 10 withCards: OrderedCollection new. 	
	aSpaceship3 := Spaceship withName: 'Nave 3' withBoard: aBoard withMaxFuel: 20. 
	spaceships := { aSpaceship1 . aSpaceship2 . aSpaceship3}. 	
	"1 vuelta = 6 nextTurn     1   2   1   2   1   2 " 	
	aDie1 := LoadedDie with: { 3 . 3 . 3 . 3}. 
	aDie2 := LoadedDie with: { 3 . 3 . 3 . 3}. 	
	dice := { aDie1 . aDie2 }. 	lap := 2. 	
	aGame := Game with: spaceships andDice: dice laps: lap in:aBoard . 	 
	
	
	
]

{ #category : 'asserting' }
CardsTest >> should: arg1 raise: arg2 withMessageText: arg3 [

	self
		should: arg1
		raise: arg2
		withExceptionDo: [ :arg4 |
		self assert: arg4 messageText equals: arg3 ]
]

{ #category : 'tests' }
CardsTest >> test01WhenSpaceshipLandsOnCardTileThenReceivesACard [

	| aCardDeck |
	
	aCardDeck := CardDeck new.
	aCardDeck addCard: (Overload new).
	drawCardTile := BoardTile inPosition: 6 effect: (DrawCard withDeck: aCardDeck) target: SelfTarget new.
	aBoard addTile: drawCardTile.
	aSpaceship1 turn: 6 in: aGame.
	self assert: aSpaceship1 cards equals: 1
]

{ #category : 'tests' }
CardsTest >> test02WhenSpaceshipLandsOnCardTileTwiceThenHasTwoCards [

	| anotherDrawCardTile aCardDeck anotherCardDeck |
	aCardDeck := CardDeck new.
	aCardDeck addCard: (Overload new).
	anotherCardDeck := CardDeck new.
	anotherCardDeck addCard: (Overload new).
	drawCardTile := BoardTile inPosition: 6 effect: (DrawCard withDeck: aCardDeck) target: SelfTarget new.
	aBoard addTile: drawCardTile .
	anotherDrawCardTile := BoardTile inPosition: 9 effect: (DrawCard withDeck: aCardDeck) target: SelfTarget new.
	aBoard addTile: anotherDrawCardTile.
	aSpaceship1
		turn: 6 in: aGame;
		turn: 3 in: aGame.
	self assert: aSpaceship1 cards equals: 2
]

{ #category : 'tests' }
CardsTest >> test03WhenSpaceShipPicksUpOverloadCardAndUses [
	| aCardDeck overloadCard|
	overloadCard:=Overload new.
	aCardDeck:=CardDeck new.
	aCardDeck addCard: overloadCard.
	drawCardTile:= BoardTile inPosition: 6 effect: (DrawCard withDeck: aCardDeck) target: SelfTarget new.
	aBoard addTile: drawCardTile .
	aSpaceship1 turn: 6 in: aGame.
	aSpaceship1 turn:1 playCard: overloadCard against: aSpaceship2 in:aGame .
	
	self assert: aSpaceship1 cards equals: 0.
]

{ #category : 'tests' }
CardsTest >> test04WhenSpaceShipUsesOverloadCardAndApplyEffect [
	| aCardDeck overloadCard|
	aCardDeck:=CardDeck new.
	overloadCard:=Overload new.
	aCardDeck addCard:overloadCard.
	drawCardTile:= BoardTile inPosition: 6 effect: (DrawCard withDeck: aCardDeck) target: SelfTarget new.
	aBoard addTile: drawCardTile .
	
	aSpaceship1 turn: 6 in: aGame.
	aSpaceship1 turn: 1 playCard: overloadCard against: aSpaceship2 in:aGame .
	
	aSpaceship2 turn: 4 in: aGame.
	
	self assert: aSpaceship2 position equals:(Position in: 2 at: 0).
]

{ #category : 'tests' }
CardsTest >> test05WhenUsedAllyCardThenBothSpaceshipFuelsGoDown [

	| aCardDeck allyCard|
	aCardDeck:=CardDeck new.
	allyCard:=Ally new.
	aCardDeck addCard: allyCard.
	drawCardTile:= BoardTile inPosition: 6 effect: (DrawCard withDeck: aCardDeck) target: SelfTarget new.
	aBoard addTile: drawCardTile .
	aSpaceship1 turn: 6 in: aGame.
	aSpaceship1 turn:6 playCard: allyCard against: aSpaceship2 in: aGame.
	
	self assert: aSpaceship2 fuel equals: 8
]

{ #category : 'tests' }
CardsTest >> test06WhenAllyRunsOutOfFuelThenBothRunOutOfFuel [

	| aCardDeck allyCard|
	aCardDeck:=CardDeck new.
	allyCard:=Ally new.
	aCardDeck addCard: allyCard.
	drawCardTile:= BoardTile inPosition: 6 effect: (DrawCard withDeck: aCardDeck) target: SelfTarget new.
	aBoard addTile: drawCardTile .
	aSpaceship1 turn: 6 in: aGame.
	aSpaceship1 turn:15 playCard: allyCard against: aSpaceship2 in: aGame.
	
	self assert: aSpaceship1 fuel equals: 0.
	self assert: aSpaceship2 fuel equals: 0
]

{ #category : 'tests' }
CardsTest >> test07WhenAllyRunsOutOfFuelThenBothRGoBackToZero [

	| aCardDeck allyCard|
	aCardDeck:=CardDeck new.
	allyCard:=Ally new.
	aCardDeck addCard: allyCard.
	drawCardTile:= BoardTile inPosition: 6 effect: (DrawCard withDeck: aCardDeck) target: SelfTarget new.
	aBoard addTile: drawCardTile .
	aSpaceship1 turn: 6 in: aGame.
	aSpaceship1 turn:15 playCard: allyCard against: aSpaceship2 in: aGame.

	
	self assert: aSpaceship1 position equals: (Position in: 0 at: 0).
	self assert: aSpaceship2 position equals: (Position in: 0 at: 0).
]

{ #category : 'tests' }
CardsTest >> test08WhenAccelerationCardIsUsedThenTheNextMoveIsUpByOne [

	| aCardDeck accelerationCard|
	aCardDeck:=CardDeck new.
	accelerationCard:=Acceleration new.
	aCardDeck addCard: accelerationCard.
	drawCardTile:= BoardTile inPosition: 6 effect: (DrawCard withDeck: aCardDeck) target: SelfTarget new.
	aBoard addTile: drawCardTile .
	aSpaceship1 turn: 6 in: aGame.
	aSpaceship1 turn: 2 playCard: accelerationCard against: nil in: aGame .
	
	self assert: aSpaceship1 position equals: (Position in: 9 at: 0).
]

{ #category : 'tests' }
CardsTest >> test09WhenAccelerationCardIsUsedThenAllMovesAreUpByOne [

	| aCardDeck accelerationCard|
	aCardDeck:=CardDeck new.
	accelerationCard:=Acceleration new.
	aCardDeck addCard: accelerationCard.
	drawCardTile:= BoardTile inPosition: 6 effect: (DrawCard withDeck: aCardDeck) target: SelfTarget new.
	aBoard addTile: drawCardTile .
	aSpaceship1 turn: 6 in: aGame.
	aSpaceship1 turn: 2 playCard: accelerationCard against: nil in: aGame .
	aSpaceship2 turn: 6 in: aGame.
	
	self assert: aSpaceship1 position equals: (Position in: 9 at: 0).
	self assert: aSpaceship2 position equals: (Position in: 7 at: 0).
]

{ #category : 'tests' }
CardsTest >> test10WhenUsedACancellationCardThenAPermanentCardIsEliminatedtest [

	| cancellationCard accelerationCard |
	cancellationCard :=Cancellation new.
	accelerationCard :=Acceleration new.
	aSpaceship1 drawCard: accelerationCard.
	aSpaceship2 drawCard: cancellationCard.
	aSpaceship1 turn: 2 playCard: accelerationCard against: nil in: aGame .
	aSpaceship2 turn: 2 playCard: cancellationCard against: accelerationCard in: aGame .
	self assert: (aGame permanentCards size) equals: 0
]

{ #category : 'tests' }
CardsTest >> test11WhenUsedACancellationCardThenAccelerationActionIsGone [

	| cancellationCard accelerationCard |
	cancellationCard := Cancellation new.
	accelerationCard := Acceleration new.
	aSpaceship1 drawCard: accelerationCard.
	aSpaceship2 drawCard: cancellationCard.
	aSpaceship1 turn: 2 playCard: accelerationCard against: nil in: aGame .
	
	aSpaceship2 turn: 2 playCard: cancellationCard against: accelerationCard in: aGame .
	aSpaceship1 turn: 1 in: aGame.
	self assert: aSpaceship1 position equals: (Position in: 4 at: 0)
]

{ #category : 'tests' }
CardsTest >> test12WhenUsedACancellationCardThenOverloadActionIsGone [

	| cancellationCard overloadCard |
	cancellationCard := Cancellation new.
	overloadCard := Overload new.
	aSpaceship1 drawCard: overloadCard.
	aSpaceship2 drawCard: cancellationCard.
	aSpaceship1 turn:1 playCard:overloadCard against:aSpaceship2 in:aGame.
	aSpaceship2 turn: 5 in: aGame.
	aSpaceship2	turn: 0 playCard: cancellationCard against: overloadCard in: aGame .
	aSpaceship2	turn: 1 in: aGame.
	self assert: aSpaceship2 position equals: (Position in: 4 at: 0)
]

{ #category : 'tests' }
CardsTest >> test13WhenUsedACancellationCardThenAllyActionIsGone [

	| aCancellationCard anAllyCard |
	aCancellationCard := Cancellation new.
	anAllyCard := Ally new.
	aSpaceship1 drawCard: anAllyCard.
	aSpaceship2 drawCard: aCancellationCard.
	aSpaceship1 turn: 12 playCard: anAllyCard against:aSpaceship2 in:aGame .
		
	aSpaceship2 turn: 0 playCard: aCancellationCard against: anAllyCard in: aGame .
	aSpaceship1 turn: 2 in: aGame.
	self assert: aSpaceship2 position equals: (Position in: 0 at: 0)
]

{ #category : 'tests' }
CardsTest >> test14WhenUsedACancellationCardOnANonExistenCardThenIsInvalid [

	| cancellationCard allyCard accelerationCard |
	cancellationCard := Cancellation new.
	allyCard := Ally new.
	accelerationCard := Acceleration new.
	aSpaceship1 drawCard: allyCard.
	aSpaceship2 drawCard: cancellationCard.
	aSpaceship1 turn:12 playCard:allyCard against:aSpaceship2 in:aGame .
	self
		should: [ aSpaceship2 turn: 0 playCard: cancellationCard against: accelerationCard in: aGame . ]
		raise: Error
		withMessageText: 'La carta a eliminar no esta en juego'
]

{ #category : 'tests' }
CardsTest >> test15WhenRedoCardUsedPlaysLatestPlayedCard [

	| redoCard overloadCard |
	redoCard := Redo new.
	overloadCard :=Overload new.
	aSpaceship1 drawCard: redoCard.
	aSpaceship2
		drawCard: overloadCard;
		turn:1 playCard: overloadCard against:aSpaceship1 in:aGame.
	aSpaceship1 turn:5 playCard: redoCard against:aSpaceship2 in:aGame.
		"turn: 5;
		useCardAgainst: aSpaceship2 in: aGame."
	aSpaceship2 turn: 3 in: aGame.
	self
		assert: aSpaceship2 position equals: (Position in: 2 at: 0);
		assert: aSpaceship1 position equals: (Position in: 3 at: 0);
		assert: aGame permanentCards size equals: 2
]

{ #category : 'tests' }
CardsTest >> test16WhenNotCardsInGameThenRedoNoEffect [

	| redoCard overloadCard |
	redoCard := Redo new.
	overloadCard := Overload new.
	aSpaceship1
		drawCard: redoCard;
		useCard:redoCard against: aSpaceship2 in: aGame.
	aSpaceship2 turn: 3 in: aGame.
	self
		assert: aSpaceship2 position equals: (Position in: 3 at: 0);
		assert: aGame permanentCards size equals: 0
]

{ #category : 'tests' }
CardsTest >> test17WhenRedoCardUsedPlaysLatestAccelerationCard [

	| redoCard accelerationCard aCardDeck |
	redoCard := Redo new.
	accelerationCard := Acceleration new.
	aCardDeck := CardDeck new.
	aCardDeck addCard: accelerationCard.
	drawCardTile:= BoardTile inPosition: 6 effect: (DrawCard withDeck: aCardDeck) target: SelfTarget new.
	aBoard addTile: drawCardTile .
	aSpaceship1 drawCard: redoCard.
	aSpaceship2
		turn: 6 in: aGame;
		turn: 1 playCard: accelerationCard against: nil in: aGame .
	aSpaceship1 turn: 2 playCard: redoCard against: nil in: aGame .
	self
		assert: aSpaceship2 position equals: (Position in: 8 at: 0);
		assert: aSpaceship1 position equals: (Position in: 4 at: 0);
		assert: aGame permanentCards size equals: 2
]

{ #category : 'tests' }
CardsTest >> test18WhenRepeatCardUsedThenAppliesBlackHoleEffectToSpaceship [
	|repeat blackHole|
	repeat := Repeat new.
	aSpaceship2  drawCard: repeat.
	
	blackHole:= BoardTile inPosition: 9 effect: BlackHole new target: SelfTarget new.
	aBoard addTile: blackHole.
	aSpaceship3 turn: 9 in: aGame. "Aplicamos el efecto blackHole en el juego, la Nave 3 tiene 20 de fuel"
	aSpaceship2 useCard:repeat against: aSpaceship3 in:aGame. "usa la carta repetida y va 4 mas para atras"
	
	self assert:aSpaceship3 position equals: (Position in:1 at:0).
]

{ #category : 'tests' }
CardsTest >> test19WhenRepeatCardUsedThenAppliesAtomicBombEffectToSpaceship [
	|repeat atomicBomb|
	repeat := Repeat new.
	aSpaceship2  drawCard: repeat.
	
	atomicBomb:= BoardTile inPosition: 9 effect: AtomicBomb new target: AllTarget new.
	aBoard addTile: atomicBomb.
	aSpaceship3 turn: 9 in: aGame. "Aplicamos el efecto atomicBomb en el juego, la Nave 3 tiene 20 de fuel"
	aSpaceship3 turn: 5 in: aGame. "Vuelve a comenzar de cero y se mueve hasta 5"
	aSpaceship1 turn: 3 in: aGame.
	aSpaceship2 useCard:repeat against: aSpaceship3 in:aGame. "usa la carta repetida y vuelve a 0"
	
	self assert:aSpaceship3 position equals: (Position in:0 at:0).
	self assert:aSpaceship1 position equals: (Position in:3 at:0).
]

{ #category : 'tests' }
CardsTest >> test20WhenRepeatCardUsedThenAppliesHyperGravityEffectToSpaceship [
	|repeat hyperGravity|
	repeat := Repeat new.
	aSpaceship2  drawCard: repeat.
	
	hyperGravity:= BoardTile inPosition: 5 effect: (HyperGravity needing: 3) target: SelfTarget new.
	aBoard addTile: hyperGravity.
	
	aSpaceship3 turn: 5 in: aGame. "Aplicamos el efecto HyperGravity "
	aSpaceship3 turn: 6 in: aGame. "deja de estar locked pero no avanza"
	aSpaceship2 useCard: repeat against: aSpaceship3 in: aGame. "usa la carta repetida y vuelve a aplicarse con el mismo exit roll"
	aSpaceship3 turn: 2 in: aGame. 
	
	self assert:aSpaceship3 position equals: (Position in: 5 at:0). "No se pudo mover de 11 al no sacar mas de 3"
	
]

{ #category : 'tests' }
CardsTest >> test21WhenRepeatCardUsedThenAppliesMoonWalkEffectToSpaceship [
	|repeat moonwalk|
	repeat := Repeat new.
	aSpaceship2  drawCard: repeat.
	
	moonwalk:= BoardTile inPosition: 5 effect: (MoonWalk steps: 3) target: OthersTarget new. "lo que tendra que retroceder"
	aBoard addTile: moonwalk.
	
	aSpaceship3 turn: 5 in: aGame. "hace retroceder a los demas 3 posiciones"
	aSpaceship3 turn: 4 in: aGame. "avanza a 9"
	aSpaceship2 useCard:repeat against: aSpaceship3 in:aGame. "usa la carta repetida y vuelve a aplicarse MW"
	
	
	self assert:aSpaceship3 position equals: (Position in:6 at:0). 
	
]

{ #category : 'tests' }
CardsTest >> test22WhenRepeatCardUsedThenAppliesHyperJumpEffectToSpaceship [
	|repeat hyperJumpEffect hyperJumpTile |
	repeat := Repeat new.
	aSpaceship2  drawCard: repeat.
	
	hyperJumpEffect := HyperJump 
       withParsecs: { Parsec with: 10. Parsec with: 12. Parsec with: 8. 
                      Parsec with: 5. Parsec with: 3. Parsec with: 2 }
       convertor: 2
       boardSize: aBoard size.
   hyperJumpTile := BoardTile inPosition: 5 effect: hyperJumpEffect target: SelfTarget new.
	aBoard addTile: hyperJumpTile.
	
	aSpaceship3 turn: 5 in: aGame. "se movera 6 lugares mas adelante"
	aSpaceship2 useCard:repeat against: aSpaceship3 in:aGame. "al volverselo a aplicar se movera 5 lugares mas"
	
	self assert:aSpaceship3 position equals: (Position in:16 at:0). 
	
]
