"
wormhole builder

"
Class {
	#name : 'WormholeBuilder',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
WormholeBuilder class >> entranceAt: entrancePosition exitAt: exitPosition [
	| entranceEffect exitEffect entranceTile exitTile |
	entrancePosition negative ifTrue: [
		Error signal: 'Tile should be a positive position' ].
	exitPosition negative ifTrue: [
		Error signal: 'Tile should be a positive position' ].
	entranceEffect := Wormhole new.
	exitEffect := Wormhole new.
	entranceEffect pairWith: exitPosition.
	exitEffect pairWith: entrancePosition.
	entranceTile := BoardTile inPosition: entrancePosition effect: entranceEffect  target: SelfTarget new.
	exitTile := BoardTile inPosition: exitPosition effect: exitEffect  target: SelfTarget new.
	^Array with: entranceTile with: exitTile 
]
