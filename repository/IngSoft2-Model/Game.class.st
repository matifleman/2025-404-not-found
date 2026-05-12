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
		'board',
		'rewardResolver'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Game class >> with: spaceShips andDice: someDice laps: lap in:aBoard [
	(lap < 1) ifTrue: [ Error signal: 'Number of laps should be greater than 0' ].
	^ self new initializeWith: spaceShips andDice: someDice laps: lap in:aBoard withReward: 80.
]

{ #category : 'instance creation' }
Game class >> with: spaceShips andDice: someDice laps: lap in:aBoard withReward: aPercentage [
	(lap < 1) ifTrue: [ Error signal: 'Number of laps should be greater than 0' ].
	^ self new initializeWith: spaceShips andDice: someDice laps: lap in:aBoard withReward: aPercentage.
]

{ #category : 'adding' }
Game >> addPermanentCard: aCard against: aSpaceship [ 
	permanentCards add: aCard.
   cardTargets at: aCard put: aSpaceship
]

{ #category : 'initialization' }
Game >> initializeWith: someSpaceships andDice: someDice laps: someLaps in:aBoard withReward: aPercentage [
	
	board:= aBoard.
	laps := someLaps.
	spaceships := someSpaceships.
	dice := someDice.
	turnNumber := 1.
	numberSpaceships := spaceships size.
	permanentCards := OrderedCollection new.
	cardTargets:=Dictionary new.
	rewardResolver := RewardResolver withPercentage: aPercentage.
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

{ #category : 'logic' }
Game >> modifyRollAll: aNumber [
	
	spaceships do: [ :ship | ship modifyRoll: aNumber ].
	
]

{ #category : 'logic' }
Game >> nextTurn [

	| spaceship positionsToMove|
	self isFinished ifTrue: [ ^ self ].
	spaceship := spaceships at: turnNumber. "obtengo nave actual"
	spaceship isEliminated ifFalse: [ 
		((spaceship) managePenalization) ifFalse:[
			positionsToMove:= self rollDice.
			(positionsToMove = self maximumValueOfDice)ifTrue: [rewardResolver resolveFor: spaceship ].
			spaceship turn: positionsToMove in: self.
		].
	].
	turnNumber := (turnNumber \\ numberSpaceships) + 1.



	
]

{ #category : 'accessing' }
Game >> permanentCards [
	^ permanentCards
]

{ #category : 'removing' }
Game >> readLastCard [
	permanentCards isEmpty ifTrue: [ ^ NullCard new ].
   ^ permanentCards last
]

{ #category : 'removing' }
Game >> removeCard: aCardToRemove [
	| card |
	card := permanentCards
		detect: [ :c | c == aCardToRemove ]
      ifNone: [ Error signal: 'La carta a eliminar no esta en juego' ].
   permanentCards remove: card.
   cardTargets removeKey: card ifAbsent: [ nil ].
   card removeFrom: self.
]

{ #category : 'logic' }
Game >> rollDice [
	| resultados |
	resultados := dice collect: [ :dado | dado roll ].
	^ resultados sum.

]

{ #category : 'logic' }
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
