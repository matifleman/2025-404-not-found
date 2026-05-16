"
Creates the tiles for the board
"
Class {
	#name : 'TileDistributionStrategy',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
TileDistributionStrategy >> initializeTiles: numberOfTiles [
	| tiles |
	tiles := (1 to: numberOfTiles) collect: [ :pos |
        | tile |
        tile := BoardTile inPosition: pos effect: (NoEffect new)  target: SelfTarget new.
        tile
    ].
	^ tiles
]

{ #category : 'initialization' }
TileDistributionStrategy >> initializeTilesRandom: numberOfTiles [
   | tiles |
	tiles := (1 to: numberOfTiles) collect: [ :pos |
        | tile |
        tile := self randomTileIn: pos.
        tile
    ].
	^ tiles
]

{ #category : 'initialization' }
TileDistributionStrategy >> randomTileIn: aPosition [
   | r  hyperGravityValue  moonWalkValue |
   r := Random new next.
	hyperGravityValue := r * 6.
	moonWalkValue := r * 10.

   (r < 0.40) ifTrue: [ ^ BoardTile inPosition: aPosition effect: (NoEffect new)  target: SelfTarget new. ].
   (r < 0.60) ifTrue: [ ^ BoardTile inPosition: aPosition effect: (BlackHole new)  target: SelfTarget new. ].
   (r < 0.80) ifTrue: [ ^ BoardTile inPosition: aPosition effect: (HyperGravity needing: hyperGravityValue) target: SelfTarget new ].
   (r < 0.90) ifTrue: [ ^ BoardTile inPosition: aPosition effect: (MoonWalk steps: moonWalkValue)  target: OthersTarget new. ].
   (r < 0.92) ifTrue: [ ^ BoardTile inPosition: aPosition effect: (AtomicBomb new)  target: AllTarget new. ].
   ^ HyperJump new.
]
