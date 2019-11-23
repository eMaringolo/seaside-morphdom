Class {
	#name : #MorphdomExampleComponent,
	#superclass : #WAComponent,
	#category : #'JQuery-Morphdom-Example'
}

{ #category : #testing }
MorphdomExampleComponent class >> initialize [

	self register
]

{ #category : #testing }
MorphdomExampleComponent class >> register [

	| app |
	app := WAAdmin register: self asApplicationAt: 'morphdom'.
	app 
		addLibrary: JQDeploymentLibrary;
		addLibrary: MorphdomDevelopmentLibrary.
	^app	
	
]

{ #category : #accesing }
MorphdomExampleComponent >> morphdomHighlightOptionsWith: aScript [
	| options |
	options := MorphdomOptions new.
	options
		onElUpdated:
			(((aScript jQuery expression: (JSStream on: 'el'))
				cssAt: 'background-color'
				put: '#FF6') asFunction: #('el'));
		onNodeAdded:
			(((aScript jQuery expression: (JSStream on: 'node'))
				cssAt: 'background-color'
				put: '#0F0') asFunction: #('node')).
	^ options
]

{ #category : #accesing }
MorphdomExampleComponent >> morphdomOptions [
	| options |
	options := MorphdomOptions new.
	MorphdomOptions eventOptions
		do: [ :symbol | 
			options
				perform: symbol asMutator
				with:
					(JSStream
						on: ('console.log("<1s>", arguments)' expandMacrosWith: symbol asString)) asFunction ].
	^options
]

{ #category : #rendering }
MorphdomExampleComponent >> renderContentOn: html [
	self renderHeadingOn: html.
	self renderRandomTableOn: html.
	self renderMorphButtonsOn: html
]

{ #category : #rendering }
MorphdomExampleComponent >> renderHeadingOn: html [
	html heading
		with: [ html text: 'morphdom'.
			html space.
			html small: 'for Seaside-jQuery!' ].
	html
		paragraph: [ html
				text:
					'Lightweight module for morphing an existing DOM node tree to match a target DOM node tree.'.
			html break.
			html
				text: 'It''s fast and works with the real DOM—no virtual DOM needed!' ].
	html
		paragraph: [ html text: 'Works as a drop-in replacement of jQuery''s '.
			html emphasis: [ html teletype: 'replaceWith()' ] ]
]

{ #category : #rendering }
MorphdomExampleComponent >> renderMorphButtonsOn: html [

	html horizontalRule.
	self renderMorphSimpleButtonOn: html.
	html paragraph: 'Performs a morph on the table.'.
	html horizontalRule.
	self renderMorphLoggingButton: html.
	html paragraph: 'Performs a morph and logs all the events to the development console (Ctrl+Shift+I on most browsers).'.
	html horizontalRule.
	self renderMorphHighlightButton: html.
	html paragraph: 'Performs a morph and highlights in green the added nodes, and in yellow the morphed (preserved) ones.'.

	html horizontalRule.
	self renderMorphFastButton: html.
	html paragraph: 'Performs a morph using the recommended option to make it faster.'.
	

]

{ #category : #rendering }
MorphdomExampleComponent >> renderMorphFastButton: html [
	html button
		onClick:
			(html jQuery ajax
				script: [ :s | 
					s
						<<
							((html jQuery id: 'table')
								morph: [ :h | self renderRandomTableOn: h ]
								fast: true) ]);
		with: 'Morph fast! (if noticeable)'
]

{ #category : #rendering }
MorphdomExampleComponent >> renderMorphHighlightButton: html [
	html button
		onClick:
			(html jQuery ajax
				script: [ :s | 
					s
						<<
							((html jQuery id: 'table')
								morph: [ :h | self renderRandomTableOn: h ]
								options: (self morphdomHighlightOptionsWith: html)) ]);
		with: 'Morph highlighting changes'
]

{ #category : #rendering }
MorphdomExampleComponent >> renderMorphLoggingButton: html [
	html button
		onClick:
			(html jQuery ajax
				script: [ :s | 
					s
						<<
							((html jQuery id: 'table')
								morph: [ :h | self renderRandomTableOn: h ]
								options: self morphdomOptions) ]);
		with: 'Morph logging (see console)!'
]

{ #category : #rendering }
MorphdomExampleComponent >> renderMorphSimpleButtonOn: html [
	html button
		onClick:
			(html jQuery ajax
				script: [ :s | 
					s
						<<
							((html jQuery id: 'table') morph: [ :h | self renderRandomTableOn: h ]) ]);
		with: 'Morph!'
]

{ #category : #rendering }
MorphdomExampleComponent >> renderRandomTableOn: html [
	| rows cols |
	rows := (3 to: 6) atRandom.
	cols := (3 to: 6) atRandom.
	html table
		id: 'table';
		attributeAt: 'border' put: 1;
		with: [ html
				tableHead:
					[ 1 to: cols do: [ :i | html tableHeading: ('HC<1p>' expandMacrosWith: i) ] ].
			html
				tableBody: [ 1 to: rows do: [ :row | 
						html
							tableRow: [ 1 to: cols do: [ :col | 
									| id |
									id := ('r<1p>c<2p>' expandMacrosWith: row with: col).
									html
										tableData:
											[ html textInput id: id; placeholder: id asUppercase  ] ] ] ] ] ].
					

]
