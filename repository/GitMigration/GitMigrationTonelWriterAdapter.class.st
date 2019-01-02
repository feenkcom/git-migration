Class {
	#name : #GitMigrationTonelWriterAdapter,
	#superclass : #TonelWriter,
	#category : #'GitMigration-FastImport'
}

{ #category : #writing }
GitMigrationTonelWriterAdapter >> writePackage: aDefinition  forPackageName: aPackageName [
	"I'm assuming first category is actually the package"
	packageDir := aPackageName. "aDefinition categories first"
	self flag: #todo. "this is lame... removing and rewriting full package needs to be rethink :)"
	(self fileUtils directoryExists: self packageDir) ifTrue: [ 
		self fileUtils deleteAll: self packageDir ].  
	self fileUtils ensureDirectoryExists: self packageDir.
	self fileUtils 
		writeStreamFor: 'package.st' 
		in: self packageDir 
		do: [ :s | 
			s 
				<< 'Package ' 
				<< (self toSTON: { #name ->  packageDir asSymbol } asDictionary) 
				<< self newLine ]
]

{ #category : #writing }
GitMigrationTonelWriterAdapter >> writeSnapshot: aSnapshot  forPackageName: aPackageName [
	snapshot := aSnapshot.
	"ensure package dirs exists. 
	 It has to be just one but well..."
	self writePackage: (snapshot definitions 
		detect: #isOrganizationDefinition
		ifFound: [ :each | each ]
		ifNone: [ self createDefaultOrganizationFrom: (snapshot definitions detect: #isClassDefinition) ])
	forPackageName: aPackageName.
	"now export classes"
	(snapshot definitions 
		select: #isClassDefinition)
		do: [ :each | self writeClass: each ].
	"... and method extensions"
	self writeMethodExtensions
]

{ #category : #writing }
GitMigrationTonelWriterAdapter >> writeVersion: aVersion [
	self writeSnapshot: aVersion snapshot forPackageName: aVersion package name
]
