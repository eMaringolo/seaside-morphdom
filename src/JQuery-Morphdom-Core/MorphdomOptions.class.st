"
https://github.com/patrick-steele-idem/morphdom

Supported options (all optional):

getNodeKey (Function(node)) - Called to get the Node's unique identifier. This is used by morphdom to rearrange elements rather than creating and destroying an element that already exists. This defaults to using the Node's id property. (Note that form fields must not have a name corresponding to forms' DOM properties, e.g. id.)

onBeforeNodeAdded (Function(node)) - Called before a Node in the to tree is added to the from tree. If this function returns false then the node will not be added. Should return the node to be added.

onNodeAdded (Function(node)) - Called after a Node in the to tree has been added to the from tree.

onBeforeElUpdated (Function(fromEl, toEl)) - Called before a HTMLElement in the from tree is updated. If this function returns false then the element will not be updated.

onElUpdated (Function(el)) - Called after a HTMLElement in the from tree has been updated.

onBeforeNodeDiscarded (Function(node)) - Called before a Node in the from tree is discarded. If this function returns false then the node will not be discarded.

onNodeDiscarded (Function(node)) - Called after a Node in the from tree has been discarded.

onBeforeElChildrenUpdated (Function(fromEl, toEl)) - Called before the children of a HTMLElement in the from tree are updated. If this function returns false then the child nodes will not be updated.
childrenOnly (Boolean) - If true then only the children of the fromNode and toNode nodes will be morphed (the containing element will be skipped). Defaults to false.


"
Class {
	#name : #MorphdomOptions,
	#superclass : #GRObject,
	#instVars : [
		'options'
	],
	#category : #'JQuery-Morphdom-Core'
}

{ #category : #'instance creation' }
MorphdomOptions class >> blazingFast [
	^ self new
		beBlazingFast;
		yourself
]

{ #category : #acccessing }
MorphdomOptions class >> eventOptions [

	^#(onBeforeElChildrenUpdated onBeforeElUpdated onBeforeNodeAdded onBeforeNodeDiscarded onElUpdated onNodeAdded onNodeDiscarded)

	
]

{ #category : #options }
MorphdomOptions >> addChild: aJsFunction [
	"Called when adding a new child to a parent. By default, parentNode.appendChild(childNode) is
	invoked. Use this callback to customize how a new child is added."
	
	self optionAt: 'addChild' put: aJsFunction
]

{ #category : #options }
MorphdomOptions >> beBlazingFast [

	self onBeforeElUpdated: (JSStream on: 'function(fromEl, toEl) {
        // spec - https://dom.spec.whatwg.org/#concept-node-equals
        if (fromEl.isEqualNode(toEl)) {
            return false
        }

        return true
    	}')
]

{ #category : #options }
MorphdomOptions >> childrenOnly: aBoolean [
	"If true then only the children of the fromNode and toNode nodes will be morphed (the containing element will be skipped). Defaults to false."

	self optionAt: 'childrenOnly:' put: aBoolean
]

{ #category : #options }
MorphdomOptions >> getNodeKey: aJSFunction [
 	"Called to get the Node's unique identifier. This is used by morphdom to rearrange elements rather than creating and destroying an element that already exists. This defaults to using the Node's id property. (Note that form fields must not have a name corresponding to forms' DOM properties, e.g. id.)."

	self optionAt: 'getNodeKey' put: aJSFunction
]

{ #category : #initialization }
MorphdomOptions >> initialize [

	super initialize.
	options := Dictionary new.
]

{ #category : #printing }
MorphdomOptions >> javascriptOn: aStream [
	"Generate the JavaScript string of the receiver."
	
	JSStream encodeDictionary: options on: aStream
]

{ #category : #options }
MorphdomOptions >> onBeforeElChildrenUpdated: aJSFunction [
	"Called before the children of a HTMLElement in the from tree are updated. If this function returns false then the child nodes will not be updated."

	self optionAt: 'onBeforeElChildrenUpdated' put: aJSFunction
]

{ #category : #options }
MorphdomOptions >> onBeforeElUpdated: aJSFunction [
	"Called before a HTMLElement in the from tree is updated. 
	If this function returns false then the element will not be updated."

	self optionAt: 'onBeforeElUpdated' put: aJSFunction
]

{ #category : #options }
MorphdomOptions >> onBeforeNodeAdded: aJSFunction [
 	"Called before a Node in the to tree is added to the from tree. 
	If this function returns false then the node will not be added. 
	Should return the node to be added."

	self optionAt: 'onBeforeNodeAdded' put: aJSFunction
]

{ #category : #options }
MorphdomOptions >> onBeforeNodeDiscarded: aJSFunction [
	"Called before a Node in the from tree is discarded. If this function returns false then the node will not be discarded."

	self optionAt: 'onBeforeNodeDiscarded' put: aJSFunction
]

{ #category : #options }
MorphdomOptions >> onElUpdated: aJSFunction [
	"Called after a HTMLElement in the from tree has been updated."

	self optionAt: 'onElUpdated' put: aJSFunction
]

{ #category : #options }
MorphdomOptions >> onNodeAdded: aJSFunction [
	"Called after a Node in the to tree has been added to the from tree."

	self optionAt: 'onNodeAdded' put: aJSFunction
]

{ #category : #options }
MorphdomOptions >> onNodeDiscarded: aJSFunction [
	"Called after a Node in the from tree has been discarded."

	self optionAt: 'onNodeDiscarded' put: aJSFunction
]

{ #category : #configuring }
MorphdomOptions >> optionAt: aString put: aJSFunction [ 
	
	options at: aString put: aJSFunction 
]

{ #category : #options }
MorphdomOptions >> skipFromChildren: aJsFunction [
	"Called when indexing a the `fromEl` tree. False by default. Return `true` to skip indexing the 
	from tree, which will keep current items in place after patch rather than removing them when 
	not found in the `toEl`"
	
	self optionAt: 'skipFromChildren' put: aJsFunction
]
