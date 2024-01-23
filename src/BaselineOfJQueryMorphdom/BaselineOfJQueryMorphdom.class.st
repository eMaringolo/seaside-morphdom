Class {
	#name : #BaselineOfJQueryMorphdom,
	#superclass : #BaselineOf,
	#category : #BaselineOfJQueryMorphdom
}

{ #category : #baselines }
BaselineOfJQueryMorphdom >> baseline: spec [

	<baseline>
	spec
		for: #common
		do: [
			spec
				package: 'JQuery-Morphdom-Core';
				package: 'JQuery-Morphdom-Example'
					with: [ spec requires: #('JQuery-Morphdom-Core') ].

			spec for: #withoutSeaside do:[
				self seaside: spec.
				spec
					package: 'JQuery-Morphdom-Core'
						with: [ spec requires: #('Seaside3') ] ].
			spec
				group: 'Core' with: #('JQuery-Morphdom-Core');
				group: 'Examples' with: #('JQuery-Morphdom-Core' 'JQuery-Morphdom-Example');
				group: 'all' with: #('Core' 'Examples');
				group: 'default' with: #('all') ]
]

{ #category : #accessing }
BaselineOfJQueryMorphdom >> customProjectAttributes [

	| attributes |
	attributes := OrderedCollection new.
	self class environment at: #WAObject ifAbsent: [ attributes add: #withoutSeaside ].
	^ attributes asArray
]

{ #category : #accessing }
BaselineOfJQueryMorphdom >> projectClass [

  Smalltalk at: #'MetacelloCypressBaselineProject' ifPresent: [ :cl | ^ cl ].
  ^ super projectClass
]

{ #category : #baselines }
BaselineOfJQueryMorphdom >> seaside: spec [

	spec
		baseline: 'Seaside3'
		with: [ spec
				loads: #('default');
				repository: 'github://SeasideSt/Seaside:master/repository' ]
]
