"
Spaceship that can move by updating its position
"
Class {
	#name : 'Spaceship',
	#superclass : 'Object',
	#instVars : [
		'position',
		'name',
		'board',
		'penalization',
		'exitRoll',
		'fuelTank',
		'cards',
		'minusMoves',
		'ally',
		'rollAddOn'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance creation' }
Spaceship class >> withName: aName withBoard: aBoard withMaxFuel: maxFuel [

	aName size < 1 ifTrue: [
		Error signal: 'Name should have at least one character' ].
	^ self new initializeWith: aName withBoard: aBoard	 withMaxFuel: maxFuel withCards: nil
]

{ #category : 'instance creation' }
Spaceship class >> withName: aName withBoard:aBoard withMaxFuel: maxFuel withCards: cards [
	(aName size < 1) ifTrue: [ Error signal: 'Name should have at least one character'].
	^ self new initializeWith: aName withBoard: aBoard  withMaxFuel: maxFuel withCards: cards
]

{ #category : 'logic' }
Spaceship >> allyWith: aSpaceship [
	ally := aSpaceship.
	
]

{ #category : 'logic' }
Spaceship >> askForFuel: fuelNeeded [
	ally ifNil: [ ^false ].
	^ally shareFuel: fuelNeeded
]

{ #category : 'logic' }
Spaceship >> breakAlliance [

	ally := nil
]

{ #category : 'accessing' }
Spaceship >> cards [
	^cards size
]

{ #category : 'logic' }
Spaceship >> checkFuelCapacity [
^fuelTank maxFuel

]

{ #category : 'logic' }
Spaceship >> drawCard: aCard [
	cards add: aCard
]

{ #category : 'accessing' }
Spaceship >> fuel [
	^ fuelTank fuel
]

{ #category : 'logic' }
Spaceship >> hasWon: laps [

	^ position hasDoneLaps: laps
]

{ #category : 'logic' }
Spaceship >> increaseMaxFuelBy: aNumberToIncreaseTank [
	fuelTank increaseSize:aNumberToIncreaseTank.

]

{ #category : 'initialization' }
Spaceship >> initializeWith: aName withBoard: aBoard withMaxFuel: aMaxFuel withCards: someCards [
	board:=aBoard.
	position := Position in: 0 at: 0.
	name := aName.
	fuelTank := FuelTank with: aMaxFuel.
	penalization := 0.
	exitRoll := 0.
	cards := someCards.
	minusMoves :=0.
	ally := nil.
	rollAddOn := 0.
]

{ #category : 'initialization' }
Spaceship >> initializeWith: aName  withMaxFuel: aMaxFuel withCards: someCards [
	position := Position in: 0 at: 0.
	name := aName.
	fuelTank := FuelTank with: aMaxFuel.
	penalization := 0.
	exitRoll := 0.
	cards := someCards.
	minusMoves :=0.
	ally := nil.
	rollAddOn := 0.
]

{ #category : 'logic' }
Spaceship >> lockUntil: anExitRoll [
	exitRoll := anExitRoll.
]

{ #category : 'logic' }
Spaceship >> managePenalization [

	penalization == 0 ifTrue: [ ^ false ].
	nil.
	penalization := penalization - 1.
	penalization == 0 ifTrue: [ fuelTank refuel ].
	^ true
]

{ #category : 'logic' }
Spaceship >> modifyRoll: aNumber [
	rollAddOn := rollAddOn + aNumber.
]

{ #category : 'moving' }
Spaceship >> move: numberOfTiles [

	position := board boardPosition: position + numberOfTiles.
	fuelTank useFuel: numberOfTiles from: self.
	
	
	
]

{ #category : 'accessing' }
Spaceship >> name [
	^ name
]

{ #category : 'logic' }
Spaceship >> penalize [
	position := position backToZero.
	penalization := 2.
]

{ #category : 'accessing' }
Spaceship >> position [
	^ position
]

{ #category : 'logic' }
Spaceship >> reduceFuelBy: aNumber [
	fuelTank useFuel: aNumber from: self.

]

{ #category : 'moving' }
Spaceship >> refuel [
	fuelTank refuel
]

{ #category : 'initialization' }
Spaceship >> resetToStartWithoutFuelLoss [

	position := position backToZero.
]

{ #category : 'logic' }
Spaceship >> shareFuel: fuelNeeded [
	^fuelTank shareFuel: fuelNeeded from: self.
	
	
]

{ #category : 'logic' }
Spaceship >> turn: toMove in: aGame [
    toMove < exitRoll ifTrue: [ ^ self ].
    exitRoll := 0.
    self move: toMove + rollAddOn.
    board applyTileEffectTo: self in: aGame

]

{ #category : 'logic' }
Spaceship >> turn: aNumber playCard: aCard against: aTarget in: aGame [
    | cardToUse |
    cardToUse := cards
        detect: [ :c | c == aCard ]
        ifNone: [ Error signal: 'The chosen card was not found' ].
    cardToUse playOn: aTarget from: self in: aGame.
    cards remove: cardToUse.
    self turn: aNumber in: aGame

]

{ #category : 'logic' }
Spaceship >> useCancellationOn: cardToRemove inGame: aGame [
    | cancellationCard |
    cancellationCard := cards
        detect: [ :c | c isKindOf: Cancellation ]
        ifNone: [ Error signal: 'No cancellation card was found' ].
    cards remove: cancellationCard.
    aGame removeCard: cardToRemove.
    ^ cancellationCard
]

{ #category : 'logic' }
Spaceship >> useCard: aCard against: aTarget in: aGame [
    | cardToUse |
    cardToUse := cards
        detect: [ :c | c == aCard ]
        ifNone: [ Error signal: 'The chosen card was not found' ].
    aCard isPermanent ifTrue: [
        Error signal: 'Permanent Card can only be played during turn' ].
    cardToUse playOn: aTarget from: self in: aGame.
    cards remove: cardToUse
]
