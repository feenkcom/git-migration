Class {
	#name : #AuthorsHolder,
	#superclass : #Object,
	#classVars : [
		'authorsDict'
	],
	#category : #GitMigration
}

{ #category : #accessors }
AuthorsHolder class >> authorsDict [
	^ authorsDict
]

{ #category : #accessors }
AuthorsHolder class >> authorsDict: aDictionary [
	authorsDict := aDictionary
]
