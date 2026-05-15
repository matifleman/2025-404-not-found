Class {
	#name : 'RewardTest',
	#superclass : 'TestCase',
	#instVars : [
		'aBoard',
		'aSpaceship1',
		'aDie'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
RewardTest >> setUp [
	super setUp.
	aBoard := Board with: 20.
	aSpaceship1 := Spaceship withName: 'Nave 1' withBoard: aBoard withMaxFuel: 10. 
	aDie := LoadedDie with: { 6 . 6 }.
   


]

{ #category : 'tests' }
RewardTest >> test01WhenMaxRollGetsMaxFuelPermanently [
	| resolver |
    resolver := RewardResolver withPercentage: 100.
    resolver resolveFor: aSpaceship1.
    self assert: aSpaceship1 checkFuelCapacity equals: 11.

		
	
	

]

{ #category : 'tests' }
RewardTest >> test02WhenMaxRollGetsOneLessFuel [
	| resolver |
    resolver := RewardResolver withPercentage: 0.
    resolver resolveFor: aSpaceship1.
    self assert: aSpaceship1 fuel equals: 9.


]

{ #category : 'tests' }
RewardTest >> test03WhenShipRollsMaximumThenMaxFuelIncreasesWithFullReward [ 
   | aGame |
	aGame := Game with: (OrderedCollection with: aSpaceship1) andDice: (OrderedCollection with: aDie) laps: 3 in: aBoard withReward: 100.
   aGame nextTurn. 
   self assert: aSpaceship1 checkFuelCapacity equals: 11.


]

{ #category : 'tests' }
RewardTest >> test04WhenShipRollsMaximumThenFuelReducesWithZeroReward [
	| aGame |
	aGame := Game with: (OrderedCollection with: aSpaceship1) andDice: (OrderedCollection with: aDie) laps: 3 in: aBoard withReward: 0.
   aGame nextTurn. 
   self assert: aSpaceship1 fuel equals: 3.

]
