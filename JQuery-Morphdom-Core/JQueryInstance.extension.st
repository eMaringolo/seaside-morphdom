Extension { #name : #JQueryInstance }

{ #category : #'*JQuery-Morphdom-Core' }
JQueryInstance >> morph: aRenderable [ 
	"Morphs the HTML contents of matched elements to the contents of aRenderable,
	using morphdom() DOM morphing."
	
	self call: 'morphdom' with: (self render: aRenderable)
]

{ #category : #'*JQuery-Morphdom-Core' }
JQueryInstance >> morph: aRenderable fast: aTrue [ 
	
	^self morph: aRenderable options: MorphdomOptions blazingFast
]

{ #category : #'*JQuery-Morphdom-Core' }
JQueryInstance >> morph: aRenderable options: aDictionary [
	"Morphs the HTML contents of matched elements to the contents of aRenderable,
	using morphdom() DOM morphing."
	
	self call: 'morphdom' with: (self render: aRenderable) with: aDictionary
]
