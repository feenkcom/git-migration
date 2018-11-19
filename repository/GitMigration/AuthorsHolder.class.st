Class {
	#name : #AuthorsHolder,
	#superclass : #Object,
	#classVars : [
		'authorsDict'
	],
	#category : #GitMigration
}

{ #category : #accessors }
AuthorsHolder >> authorsDict [
	^ authorsDict
]

{ #category : #accessors }
AuthorsHolder >> authorsDict: aDictionary [
	authorsDict := aDictionary
]
