Class {
	#name : #GitMigrationVmMaker,
	#superclass : #Object,
	#category : #GitMigration
}

{ #category : #actions }
GitMigrationVmMaker >> exportVMMakerTo: exportFileName withAuthors: authorsFileName commitHash: initialCommit byAuthor: currentUserData [
	| migration authors |
	
	migration := GitMigration on: 'VMMaker'.
	migration onEmptyMessage: [ :info | 'empty commit message' ].
	migration selectedPackageNames: #('VMMaker' 'Balloon-Engine-Pools' 'BytecodeSets.spur' 'VMMaker.oscog' 'Cog' 'CogTools' 'ImageFormat' 'VMMakerCompatibilityForPharo6' 'Android-Base' 'CMakeVMMaker' 'CMakeVMMakerSqueak' 'CogAttic' 'CogBenchmarks' 'CogCompatibility' 'CogTools-Listener' 'ImageFormat' 'MemoryAccess' 'Qwaq-VMProfiling' 'SlangBrowser' 'VMM-touch-temp' 'VMMakerCompatibilityForPharo6' 'VMMakerExtras' 'VMMakerJS').

	migration downloadAllVersions.
	migration populateCaches.

	"allAuthors := migration allAuthors."

	authors := ((((authorsFileName asFileReference contents splitOn: Character lf) reject: #isEmpty) 
		collect: [ :aLine | aLine splitOn: $, ])
		inject: Dictionary new into: [ :list :data |
			data size = 3 ifTrue: [
				list 
					at: data first ifAbsentPut: { data second trimBoth . data third trimBoth };
					yourself ].
				list ]) .	
		
	migration authors: authors associations, {currentUserData }.

	"migration ignoredFileNames: #('VMMaker.oscog-eem.1082').
	migration ignoredFileNames: #()."
	"migration resetVersionsToMigrate."
	
	migration
		fastImportCodeToDirectory: 'smalltalksrc'
		initialCommit: initialCommit
		to: exportFileName.
]
