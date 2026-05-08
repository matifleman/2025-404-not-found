"
Controls the game functioning and logic
"
Class {
	#name : 'Game',
	#superclass : 'Object',
	#instVars : [
		'spaceships',
		'dice',
		'turnNumber',
		'numberSpaceships',
		'laps',
		'permanentCards',
		'lastEffect',
		'cardTargets',
		'board'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Game class >> with: spaceShips andDice: someDice laps: lap in:aBoard [
	(lap < 1) ifTrue: [ Error signal: 'Number of laps should be greater than 0' ].
	^ self new initializeWith: spaceShips andDice: someDice laps: lap in:aBoard.
]

{ #category : 'logic' }
Game >> activateAtomicBomb [     
	self spaceships do: [:ship | ship resetToStartWithoutFuelLoss ].
]

{ #category : 'logic' }
Game >> activateMoonWalk: nTiles from: triggeringSpaceship [
	self spaceships do: [:ship |
		ship = triggeringSpaceship ifFalse: [
			ship move: nTiles
		]
	].
]

{ #category : 'adding' }
Game >> addPermanentCard: aCard against: aSpaceship [ 
	permanentCards add: aCard.
   cardTargets at: aCard put: aSpaceship
]

{ #category : 'as yet unclassified' }
Game >> applyRewardTo: aSpaceship withPorcentageOf: aPorcentage [
	| randomNumber |

    randomNumber := (Random new next * 100) rounded.

    randomNumber <= aPorcentage
        ifTrue: [ aSpaceship increaseMaxFuelBy: 1 ]
        ifFalse: [ aSpaceship reduceFuelBy: 1 ].

]

{ #category : 'initialization' }
Game >> initializeWith: someSpaceships andDice: someDice laps: someLaps in:aBoard [
	
	board:= aBoard.
	laps := someLaps.
	spaceships := someSpaceships.
	dice := someDice.
	turnNumber := 1.
	numberSpaceships := spaceships size.
	permanentCards := OrderedCollection new.
	cardTargets:=Dictionary new.
]

{ #category : 'logic' }
Game >> isFinished [
	^ spaceships anySatisfy: [ :ship | ship hasWon: laps ].
]

{ #category : 'accessing' }
Game >> lastEffect [
^lastEffect 
]

{ #category : 'accessing' }
Game >> maximumValueOfDice [
	 ^ dice sum: [:die | die numberSides]

]

{ #category : 'as yet unclassified' }
Game >> modifyRollAll: aNumber [
	
	spaceships do: [ :ship | ship modifyRoll: aNumber ].
	
]

{ #category : 'logic' }
Game >> nextTurn [

	| spaceship positionsToMove|
	self isFinished ifTrue: [ ^ self ].
	spaceship := spaceships at: turnNumber. "obtengo nave actual"
	
	((spaceship) managePenalization) ifFalse:[
		positionsToMove:= self rollDices.
		(positionsToMove = self maximumValueOfDice)ifTrue: [self applyRewardTo: spaceship withPorcentageOf: 80].
		spaceship turn: positionsToMove in: self.
	].
	turnNumber := (turnNumber \\ numberSpaceships) + 1.



	
]

{ #category : 'accessing' }
Game >> permanentCards [

	^ permanentCards size
]

{ #category : 'removing' }
Game >> readLastCard [
	permanentCards isEmpty ifTrue: [ ^ NullCard new ].
    ^ permanentCards last
]

{ #category : 'removing' }
Game >> removeCard: aCardToRemove [
	| card target |
    card := permanentCards
        detect: [ :c | c == aCardToRemove ]
        ifNone: [ Error signal: 'La carta a eliminar no esta en juego' ].
    permanentCards remove: card.
    target := cardTargets at: card ifAbsent: [ nil ].
    target ifNotNil: [
        card removeFrom: self.
        cardTargets removeKey: card
    ] ifNil: [
        card removeFrom: self
    ]
]

{ #category : 'logic' }
Game >> rollDices [
	| resultados |
	resultados := dice collect: [ :dado | dado roll ].
	^ resultados sum.

]

{ #category : 'as yet unclassified' }
Game >> saveLastEffect: aBlock [
	lastEffect :=aBlock .
]

{ #category : 'logic' }
Game >> skipTurn [
	self isFinished ifTrue: [ ^ self ].
	(spaceships at: turnNumber) refuel.
	turnNumber := (turnNumber \\ numberSpaceships) + 1.
]

{ #category : 'accessing' }
Game >> spaceships [
	^ spaceships 
]
