Extension { #name : #MCVersionInfo }

{ #category : #'*GitMigration' }
MCVersionInfo >> initializeWithName: vName id: aUUID message: aString date: aDate time: aTime author: initials ancestors: aCollection stepChildren: stepCollection [
	name := vName.
	id := aUUID.
	message := aString.
	date := aDate ifNil: [ Date today ].
	date year = 4654 ifTrue: [ 
		date := Date newDay: date dayOfMonth month: date monthName year: 2015.
		('Fixing date to ', date asString, ' for: ', vName) logCr ].
	time := aTime.
	author := initials.
	ancestors := aCollection.
	stepChildren := stepCollection
]
